import 'package:dart_openai/dart_openai.dart';
import 'package:emotion_chat/env/env.dart';

class OpenAIService {
  Future<String> createModel(String sendMessage) async {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.requestsTimeOut = const Duration(seconds: 60); // 시간 제한 늘림

    // Assistant에게 대화의 방향성을 알려주는 메시지
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "You're a psychological consultant.",
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    // 사용자가 보내는 메시지
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          sendMessage,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [
      systemMessage,
      userMessage,
    ];

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
