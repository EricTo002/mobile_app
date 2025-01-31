import 'dart:async';
import 'dart:convert';
import 'dart:typed_data'; // Needed for Uint8List in stream transformation

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late Dio _dio;
  TextEditingController _controller = TextEditingController();
  String _responseMessage = '';

  @override
  void initState() {
    super.initState();
    _dio = Dio();
  }

  // Method to send message to the API and receive a response
  Future<void> _sendMessage(String userMessage) async {
    try {
      final response = await _dio.post(
        'https://api.chatanywhere.tech/v1/chat/completions', // Your API endpoint
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ', // Replace with your actual API key
          },
        ),
        data: {
          'messages': [
            {'role': 'user', 'content': userMessage}
          ],
          'stream': false, // This will handle one-time responses (not streaming)
        },
      );

      // Parse the response from the API
      final responseData = response.data;
      if (responseData != null && responseData['choices'] != null) {
        setState(() {
          _responseMessage = responseData['choices'][0]['message']['content'] ?? 'No response from API';
        });
      } else {
        setState(() {
          _responseMessage = 'No valid response from API';
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = 'Error in sending message: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatbot")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter your message",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String userMessage = _controller.text.trim();
                if (userMessage.isNotEmpty) {
                  _sendMessage(userMessage);
                }
              },
              child: const Text('Send Message'),
            ),
            const SizedBox(height: 16),
            _responseMessage.isNotEmpty
                ? Text("Response: $_responseMessage")
                : const Text("No response yet"),
          ],
        ),
      ),
    );
  }
}
