import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/utils/interaction_utils.dart';

// Message model (moved outside of MessagesScreen)
class Message {
  final int id;
  final String sender;
  final String content;
  final DateTime timestamp;
  bool isRead;
  final bool isInbound;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    required this.isInbound,
  });
}

// MessageProvider (for state management)
class MessageProvider with ChangeNotifier {
  final Map<int, bool> _messageReadStatus = {};
  List<Message> messages = [
    Message(
      id: 0,
      sender: 'Alice',
      content: 'Is the book still available? Can you offer a discount?',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isRead: false,
      isInbound: true,
    ),
    Message(
      id: 1,
      sender: 'You',
      content: 'Sure, I can lower the price to \$10.',
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
      isRead: true,
      isInbound: false,
    ),
    Message(
      id: 2,
      sender: 'Bob',
      content: 'When can we meet to exchange the items?',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      isRead: false,
      isInbound: true,
    ),
    Message(
      id: 3,
      sender: 'You',
      content: 'How about tomorrow at 3 PM near campus?',
      timestamp: DateTime.now().subtract(Duration(days: 2)),
      isRead: true,
      isInbound: false,
    ),
    Message(
      id: 4,
      sender: 'Charlie',
      content: 'Can you send me more pictures of the item?',
      timestamp: DateTime.now().subtract(Duration(days: 3)),
      isRead: false,
      isInbound: true,
    ),
  ];

  bool showInbound = true;

  bool isMessageRead(int messageId) {
    return _messageReadStatus[messageId] ??
        messages.firstWhere((message) => message.id == messageId).isRead;
  }

  void markMessageAsRead(int messageId) {
    _messageReadStatus[messageId] = true;
    messages.firstWhere((message) => message.id == messageId).isRead = true;
    notifyListeners();
  }

  void toggleMailbox(bool isInbound) {
    showInbound = isInbound;
    notifyListeners();
  }

  List<Message> getFilteredMessages() {
    return messages.where((message) => message.isInbound == showInbound).toList();
  }
}

// MessagesScreen (widget)
class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    InteractionUtils.preloadSound('button_click.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageProvider(),
      child: Consumer<MessageProvider>(
        builder: (context, messageProvider, child) {
          List<Message> filteredMessages = messageProvider.getFilteredMessages();
          return Scaffold(
            appBar: AppBar(
              title: Text('Messages'),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Icon(Icons.arrow_downward),
                        title: Text('Inbound Mailbox'),
                        onTap: () {
                          InteractionUtils.playSound('button_click.mp3',
                              volume: 0.003);
                          messageProvider.toggleMailbox(true);
                        },
                        tileColor: messageProvider.showInbound
                            ? Colors.blue[100]
                            : null,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Icon(Icons.arrow_upward),
                        title: Text('Outbound Mailbox'),
                        onTap: () {
                          InteractionUtils.playSound('button_click.mp3',
                              volume: 0.003);
                          messageProvider.toggleMailbox(false);
                        },
                        tileColor: !messageProvider.showInbound
                            ? Colors.blue[100]
                            : null,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMessages.length,
                    itemBuilder: (context, index) {
                      final message = filteredMessages[index];
                      return ListTile(
                        title: Text(
                          message.sender,
                          style: TextStyle(
                            fontWeight: messageProvider
                                .isMessageRead(message.id)
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          message.content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!messageProvider.isMessageRead(message.id))
                              Icon(Icons.circle,
                                  color: Colors.blue, size: 10),
                            SizedBox(width: 8),
                            Text(
                              '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                            ),
                          ],
                        ),
                        onTap: () {
                          InteractionUtils.playSound('button_click.mp3',
                              volume: 0.003);
                          InteractionUtils.triggerHapticFeedback();
                          messageProvider.markMessageAsRead(message.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}