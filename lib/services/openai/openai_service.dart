import 'package:dart_openai/dart_openai.dart';
import 'package:emotion_chat/env/env.dart';
import 'package:emotion_chat/screens/main/chat_tab/chat_screen.dart';
import 'package:emotion_chat/services/chat/chat_service.dart';

class OpenAIService {
  List<OpenAIChatCompletionChoiceMessageModel> messagesList = [];
  final ChatService _chatService = ChatService();

  Future<String> createModel(String sendMessage, int emotion) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = const Duration(seconds: 200); // 시간 제한 늘림
    String emotionToString = getEmotionString(emotion);
    // Assistant에게 대화의 방향성을 알려주는 메시지
    final systemSettingMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '너는 심리 상담가야. 내담자는 $emotionToString의 감정을 느꼈어. 내담자가 자신의 감정을 잘 이해할 수 있도록 도와줘. 조언보다 공감을 해줘. 질문을 통해 내담자의 대답을 이끌어 내는 것도 좋은 방법이야.',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );
    if (messagesList.isEmpty) {
      messagesList.add(systemSettingMessage);
      await _addMessagesFromFirestore(emotion);
    }
    // // conversationHistory에 있는 메시지들을 messagesList에 추가
    // for (String historyMessage in conversationHistory) {
    //   final historyMessageModel = OpenAIChatCompletionChoiceMessageModel(
    //     content: [
    //       OpenAIChatCompletionChoiceMessageContentItemModel.text(
    //         historyMessage,
    //       ),
    //     ],
    //     role: OpenAIChatMessageRole.user,
    //   );

    //   messagesList.add(historyMessageModel);
    // }

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

    // 메시지 리스트 출력
    final requestMessages = [...messagesList];
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: requestMessages,
      maxTokens: 250,
    );

    String message =
        chatCompletion.choices.first.message.content![0].text.toString();

    // 시스템 응답을 messageList에 추가
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(message),
      ],
      role: OpenAIChatMessageRole.system,
    );
    messagesList.add(systemMessage);
    return message;
  }

  Future<void> _addMessagesFromFirestore(int emotion) async {
    await for (var snapshot in _chatService.getMessages(emotion)) {
      for (var document in snapshot.docs) {
        final messageData = document.data() as Map<String, dynamic>;
        final messageContent = messageData['content']
            as String; // 'content'는 Firestore에서 메시지 내용을 저장하는 필드의 이름입니다.

        final messageModel = OpenAIChatCompletionChoiceMessageModel(
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
                messageContent),
          ],
          role: messageData['isBot'] == true
              ? OpenAIChatMessageRole.system
              : OpenAIChatMessageRole.user,
        );

        messagesList.add(messageModel);
      }
      break; // 이 예시에서는 스트림의 첫 번째 QuerySnapshot만 처리합니다. 필요에 따라 로직을 조정하세요.
    }
  }

  getEmotionString(int index) {
    if (index == 0) return '기쁨';
    if (index == 1) return '화남';
    if (index == 2) return '불안';
    if (index == 3) return '우울';
  }
}
