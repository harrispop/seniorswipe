// This comes up when you try to write a message

import 'package:flutter/material.dart';
import '../screens/models/message.dart';

class MessageComposeScreen extends StatefulWidget {
  final String recipient;

  MessageComposeScreen({required this.recipient});

  @override
  _MessageComposeScreenState createState() => _MessageComposeScreenState();
}

class _MessageComposeScreenState extends State<MessageComposeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _outboundMessages = [];

  void _sendMessage() {
    setState(() {
      _outboundMessages.add(
        Message(
          id: _outboundMessages.length,
          sender: 'Me',
          content: _controller.text,
          timestamp: DateTime.now(),
        ),
      );
      _controller.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message ${widget.recipient}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}