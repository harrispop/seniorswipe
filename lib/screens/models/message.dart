class Message {
  final int id;
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
  });
}