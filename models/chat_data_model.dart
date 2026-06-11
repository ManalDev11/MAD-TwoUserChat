class ChatDataModel {
  final String name;
  final String imagePath;
  final String time;
  final String lastMessage;
  final int mssgCount;

  ChatDataModel(
      {required this.name,
      required this.imagePath,
      required this.time,
      required this.lastMessage,
      required this.mssgCount});
}
