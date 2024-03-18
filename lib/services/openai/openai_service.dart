import 'package:dart_openai/dart_openai.dart';
import 'package:emotion_chat/env/env.dart';

class OpenAIService {
  static List<OpenAIChatCompletionChoiceMessageModel> messagesList = [];

  Future<String> createModel(String sendMessage, String emotion) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = const Duration(seconds: 200); // 시간 제한 늘림

    // Assistant에게 대화의 방향성을 알려주는 메시지
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '너는 심리 상담가야. 내담자는 $emotion의 감정을 느꼈어.',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    messagesList.add(systemMessage);

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
    print('요청 메시지 리스트 출력!!');
    print(requestMessages);
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: requestMessages,
      maxTokens: 250,
    );

    String message =
        chatCompletion.choices.first.message.content![0].text.toString();
    return message;

    // log(chatCompletion.systemFingerprint.toString());
    // log(chatCompletion.usage.promptTokens.toString());
    // log(chatCompletion.id.toString());
  }
}
