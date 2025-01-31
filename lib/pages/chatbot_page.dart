import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';

class ChatMessage {
  final String content;
  final bool isUser;

  ChatMessage({required this.content, required this.isUser});
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final Dio _dio = Dio();
  bool _isLoading = false;
  int lastIndex = 0;

  static const String _apiKey = "sk-cjGCB9tIjunKEj0MBLrl5SKJSJ1VwuynAozFe5TMxxhSlDjC";
  static const String _baseUrl = "https://api.chatanywhere.tech/v1/chat/completions";

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty || _isLoading) return;

    final userMessage = _controller.text;
    _controller.clear();

    setState(() {
      _messages.add(ChatMessage(content: userMessage, isUser: true));
      _messages.add(ChatMessage(content: "", isUser: false));
      lastIndex = _messages.length - 1;
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await _dio.post(
        _baseUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $_apiKey",
            "Content-Type": "application/json",
          },
          responseType: ResponseType.stream,
        ),
        data: {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": userMessage}
          ],
          "stream": true,
        },
      );

      final responseStream = response.data as ResponseBody;
      String fullResponse = "";

      // Corrected stream transformation
      await for (var chunk in responseStream.stream.transform(utf8.decoder)) {
        chunk.split('\n').forEach((line) {
          if (line.startsWith('data: ') && !line.contains('[DONE]')) {
            try {
              final jsonResponse = json.decode(line.substring(6));
              final content = jsonResponse['choices'][0]['delta']['content'] ?? "";
              fullResponse += content;
              
              setState(() {
                _messages[lastIndex] = ChatMessage(
                  content: fullResponse,
                  isUser: false,
                );
              });
              _scrollToBottom();
            } catch (e) {
              print("Error parsing: $e");
            }
          }
        });
      }

    } catch (e) {
      setState(() {
        _messages[lastIndex] = ChatMessage(
          content: "Error: ${e.toString()}",
          isUser: false,
        );
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _ChatBubble(
                  text: message.content,
                  isUser: message.isUser,
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: _isLoading ? Colors.grey : Colors.blue,
            ),
            onPressed: _isLoading ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.blue[800] : Colors.black,
          ),
        ),
      ),
    );
  }
}