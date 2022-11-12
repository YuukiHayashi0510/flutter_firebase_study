// メッセージclass
class Message {
  String message;

  // sender is Me ?
  bool isMe;
  DateTime sendTime;

  Message({required this.message, required this.isMe, required this.sendTime});
}
