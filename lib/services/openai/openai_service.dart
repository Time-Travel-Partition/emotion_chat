import 'package:dart_openai/dart_openai.dart';
import 'package:emotion_chat/env/env.dart';
import 'package:emotion_chat/services/chat/chat_service.dart';

class OpenAIService {
  List<OpenAIChatCompletionChoiceMessageModel> messagesList = [];
  final ChatService _chatService = ChatService();

  Future<String> createModel(String sendMessage, int emotion) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = const Duration(seconds: 200); // 시간 제한 늘림

    String emotionString = getEmotionString(emotion);

    // Assistant에게 대화의 방향성을 알려주는 메시지
    final systemSettingMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          // 명확하고 구체적으로 적어야 함.
          // ex) 친근하게 다가가줘 (X) 이름을 부르거나 스몰토크를 해줘 (O)
          // 꼭 필요한 내용만 적어야 함.
          '''
            한국어를 사용하면서 높임말로 대답해줘.
            두 문장 안으로 최대한 짧게 대답해줘.
            너는 심리 상담가야. 내담자는 $emotionString의 감정을 느꼈어.
            내담자의 이름을 부르거나 스몰토크를 하면서 친근하게 다가가줘.
            내담자가 감정에 대한 생각과 상황을 분리해서 생각하도록 도와줘.
            내담자가 감정의 원인을 찾도록 대화를 유도하고 너는 적절하게 맞장구를 쳐줘.
            지나치게 낙관적인 대답은 지양해줘.
            내담자의 감정의 크기가 큰 경우,
            다른 이유나 삽화적 기억이 있는지를 대화를 통해 확인하고 전문가와의 상담을 제안해줘.
            감정의 크기가 작은 경우,
            그 대상과 관련된 에피소드를 계속 말하게 하고 공감함으로써 조금씩 감정을 완화시켜줘.
            "화이팅" 같은 뜬금없는 응원의 말 하지 말아줘.
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    if (messagesList.isEmpty) {
      messagesList.add(systemSettingMessage);
      // 이전 메시지 내역 추가
      await _addMessagesFromFirestore(emotion);
    }

    // 사용자가 보내는 메시지
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          sendMessage,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    messagesList.add(userMessage);

    final requestMessages = [...messagesList];
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: requestMessages,
      maxTokens: 250,
      temperature: 1.0,
    );

    String message =
        chatCompletion.choices.first.message.content![0].text.toString();

    // 시스템 응답을 messageList에 추가
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(message),
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    messagesList.add(systemMessage);

    return message;
  }

  Future<void> _addMessagesFromFirestore(int emotion) async {
    await for (var snapshot in _chatService.getMessages(emotion)) {
      for (var document in snapshot.docs) {
        final messageData = document.data() as Map<String, dynamic>;
        final messageContent = messageData['content'] as String;

        final messageModel = OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
                messageContent),
          ],
          role: messageData['isBot'] == true
              ? OpenAIChatMessageRole.assistant
              : OpenAIChatMessageRole.user,
        );

        messagesList.add(messageModel);
      }
      break; // 스트림의 첫 번째 QuerySnapshot만 처리
    }
  }

  getEmotionString(int index) {
    if (index == 0) return '기쁨';
    if (index == 1) return '화남';
    if (index == 2) return '불안';
    if (index == 3) return '우울';
  }
}
