import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([]);

  void addMessage(ChatMessage message) {
    state = [...state, message];
  }

  Future<void> sendMessage(String content) async {
    // Add the user's message
    addMessage(ChatMessage(
      id: DateTime.now().toString(),
      content: content,
      sender: 'user',
      timestamp: DateTime.now(),
    ));

    // Call backend API to get response from ChatGPT
    final response = await getChatGPTResponse(content);

    // Add the bot's response
    addMessage(ChatMessage(
      id: DateTime.now().toString(),
      content: response,
      sender: 'bot',
      timestamp: DateTime.now(),
    ));
  }

  // Future<String> getChatGPTResponse(String content) async {
  //   // Implement API call to your backend
  //   // For now, return a placeholder
  //   return 'This is a response from ChatGPT.';
  // }

  Future<String> getChatGPTResponse(String content) async {
  final response = await http.post(
    Uri.parse('https://your-backend-url.com/chat'),
    headers: {
      'Content-Type': 'application/json',
      // Include authentication token if required
    },
    body: jsonEncode({'message': content}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['response'];
  } else {
    // Handle error
    //throw Exception('Failed to get response');
    return 'This is a response from ChatGPT.';
  }
}
}
