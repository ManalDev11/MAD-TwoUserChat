import 'package:flutter/material.dart';

class MessageModel {
  final String id;
  String text;
  final bool isSent;
  final String time;

  bool isEdited;
  String? replyTo;
  bool isReplySent;

  MessageModel({
    required this.id,
    required this.text,
    required this.isSent,
    required this.time,
    this.isEdited = false,
    this.replyTo,
    this.isReplySent = false,
  });
}

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({
    super.key,
    required this.name,
    required this.imagePath,
  });

  final String name;
  final String imagePath;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  MessageModel? _replyMessage;
  MessageModel? _editMessage;

  bool _showEmojiPicker = false;

  bool _isRecording = false;
  Duration _recordDuration = Duration.zero;

  final List<String> _emojiList = [
    '😀','😃','😄','😁','😆','😅',
    '😂','🤣','😊','😍','🥰','😘',
    '😎','🤩','🥳','😇','🙂','😉',
    '❤️','🧡','💛','💚','💙','💜',
    '🖤','🤍','💕','💞','💓','💗',
    '👍','👏','🙌','👌','✌️','🤝',
    '🔥','⭐','✨','🌹','🌸','💐',
    '🎉','🎊','🎁','🎂','☕','🍕',
    '📱','💻','📷','🎧','🚗','✈️',
    '😢','😭','😡','🤔','😴','🥱',
  ];

  final List<MessageModel> _messages = [
    MessageModel(
      id: '1',
      text: 'السلام عليكم',
      isSent: false,
      time: '08:30',
    ),
    MessageModel(
      id: '2',
      text: 'وعليكم السلام',
      isSent: true,
      time: '08:31',
    ),
    MessageModel(
      id: '3',
      text: 'كيف حالك منال؟',
      isSent: false,
      time: '08:32',
    ),
    MessageModel(
      id: '4',
      text: 'الحمد لله بخير 😊',
      isSent: true,
      time: '08:33',
    ),
    MessageModel(
      id: '5',
      text: 'كيف مشروع الفلاتر؟',
      isSent: false,
      time: '08:34',
    ),
    MessageModel(
      id: '6',
      text: 'تمام الحمد لله وأشتغل عليه حالياً',
      isSent: true,
      time: '08:35',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }
  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;

    final now = TimeOfDay.now();

    final timeStr =
        '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    if (_editMessage != null) {
      setState(() {
        _editMessage!.text = _msgController.text.trim();
        _editMessage!.isEdited = true;

        _editMessage = null;
        _msgController.clear();
      });

      return;
    }

    setState(() {
      _messages.add(
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _msgController.text.trim(),
          isSent: true,
          time: timeStr,
          replyTo: _replyMessage?.text,
          isReplySent: _replyMessage?.isSent ?? false,
        ),
      );

      _replyMessage = null;
      _msgController.clear();
    });

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  void _showMessageOptions(MessageModel message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F2C34),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: message.isSent
                      ? const Color(0xFF005C4B)
                      : const Color(0xFF2A3942),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              const Divider(),

              ListTile(
                leading: const Icon(
                  Icons.reply,
                  color: Colors.white,
                ),
                title: const Text(
                  "رد",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);

                  setState(() {
                    _replyMessage = message;
                    _editMessage = null;
                  });
                },
              ),

              if (message.isSent)
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "تعديل",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      _editMessage = message;
                      _replyMessage = null;
                      _msgController.text = message.text;
                    });
                  },
                ),

              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text(
                  "حذف",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(message);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(MessageModel message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F2C34),

          title: const Text(
            "حذف الرسالة",
            style: TextStyle(color: Colors.white),
          ),

          content: const Text(
            "هل تريد حذف هذه الرسالة ؟",
            style: TextStyle(color: Colors.white70),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("إلغاء"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  _messages.removeWhere(
                    (m) => m.id == message.id,
                  );
                });
              },
              child: const Text(
                "حذف",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }


  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  void _addEmoji(String emoji) {
    _msgController.text += emoji;

    _msgController.selection =
        TextSelection.fromPosition(
      TextPosition(
        offset: _msgController.text.length,
      ),
    );

    setState(() {});
  }


  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordDuration = Duration.zero;
    });

    _startTimer();
  }

  void _startTimer() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_isRecording) {
          setState(() {
            _recordDuration +=
                const Duration(seconds: 1);
          });

          _startTimer();
        }
      },
    );
  }

  void _stopRecordingAndSend() {
    if (!_isRecording) return;

    final now = TimeOfDay.now();

    final timeStr =
        '${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add(
        MessageModel(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          text:
              '🎙️ رسالة صوتية (${_formatDuration(_recordDuration)})',
          isSent: true,
          time: timeStr,
        ),
      );

      _isRecording = false;
      _recordDuration = Duration.zero;
    });
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
      _recordDuration = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) =>
        n.toString().padLeft(2, '0');

    final minutes =
        twoDigits(duration.inMinutes);

    final seconds =
        twoDigits(duration.inSeconds % 60);

    return "$minutes:$seconds";
  }


  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor:
            const Color(0xFF1F2C34),
      ),
    );
  }

  void _showCallScreen(bool isVideo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0B141A),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),

              CircleAvatar(
                radius: 65,
                foregroundImage: AssetImage(widget.imagePath),
              ),

              const SizedBox(height: 20),

              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                isVideo
                    ? "جاري إجراء مكالمة فيديو..."
                    : "جاري إجراء مكالمة صوتية...",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isVideo)
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cameraswitch,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  if (isVideo)
                    const SizedBox(width: 25),

                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);

                        _showSnackBar(
                          "تم إنهاء المكالمة",
                        );
                      },
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  void _onCallPressed() {
    _showCallScreen(false);
  }

  void _onVideoCallPressed() {
    _showCallScreen(true);
  }


  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F2C34),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              _buildAttachmentItem(
                Icons.insert_drive_file,
                Colors.indigo,
                "مستند",
              ),

              _buildAttachmentItem(
                Icons.camera_alt,
                Colors.pink,
                "كاميرا",
              ),

              _buildAttachmentItem(
                Icons.photo,
                Colors.purple,
                "المعرض",
              ),

              _buildAttachmentItem(
                Icons.headset,
                Colors.orange,
                "صوت",
              ),

              _buildAttachmentItem(
                Icons.location_on,
                Colors.green,
                "الموقع",
              ),

              _buildAttachmentItem(
                Icons.person,
                Colors.blue,
                "جهة اتصال",
              ),

              _buildAttachmentItem(
                Icons.poll,
                Colors.teal,
                "تصويت",
              ),

              _buildAttachmentItem(
                Icons.event,
                Colors.deepOrange,
                "حدث",
              ),

              _buildAttachmentItem(
                Icons.gif_box,
                Colors.red,
                "GIF",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentItem(
    IconData icon,
    Color color,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        _showSnackBar(
          "تم اختيار $title",
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }


  void _showMoreOptions(String value) {
    _showSnackBar(
      "تم اختيار: $value",
    );
  }

  List<PopupMenuEntry<String>> getPopupMenuItems() {
    return [
      const PopupMenuItem(
        value: "مجموعة جديدة",
        child: Text("مجموعة جديدة"),
      ),

      const PopupMenuItem(
        value: "رسالة جماعية جديدة",
        child: Text("رسالة جماعية جديدة"),
      ),

      const PopupMenuItem(
        value: "بحث",
        child: Text("بحث"),
      ),

      const PopupMenuItem(
        value: "الوسائط والروابط",
        child: Text("الوسائط والروابط"),
      ),

      const PopupMenuItem(
        value: "الأجهزة المرتبطة",
        child: Text("الأجهزة المرتبطة"),
      ),

      const PopupMenuItem(
        value: "الرسائل المميزة",
        child: Text("الرسائل المميزة"),
      ),

      const PopupMenuItem(
        value: "كتم الإشعارات",
        child: Text("كتم الإشعارات"),
      ),

      const PopupMenuItem(
        value: "خلفية الدردشة",
        child: Text("خلفية الدردشة"),
      ),

      const PopupMenuItem(
        value: "تصدير المحادثة",
        child: Text("تصدير المحادثة"),
      ),

      const PopupMenuItem(
        value: "الإعدادات",
        child: Text("الإعدادات"),
      ),
    ];
  }


  void _onCameraPressed() {
    _showSnackBar(
      "تم فتح الكاميرا",
    );
  }


  void _onAttachPressed() {
    _showAttachmentMenu();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B141A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2C34),
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              foregroundImage: AssetImage(
                widget.imagePath,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                const Text(
                  "متصل الآن",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: _onVideoCallPressed,
            icon: const Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),

          IconButton(
            onPressed: _onCallPressed,
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),

          PopupMenuButton<String>(
            color: const Color(0xFF1F2C34),

            onSelected: _showMoreOptions,

            itemBuilder: (context) =>
                getPopupMenuItems(),

            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),

              itemCount: _messages.length,

              itemBuilder: (context, index) {
                return _buildMessageBubble(
                  _messages[index],
                );
              },
            ),
          ),

          if (_showEmojiPicker)
            _buildEmojiPicker(),

          if (_replyMessage != null ||
              _editMessage != null)
            _buildReplyEditBar(),

          if (_isRecording)
            _buildRecordingBar()
          else
            _buildInputBar(),
        ],
      ),
    );
  }
  Widget _buildMessageBubble(
      MessageModel message) {
    return GestureDetector(
      onLongPress: () {
        _showMessageOptions(message);
      },

      onDoubleTap: () {
        setState(() {
          if (!message.text.contains("❤️")) {
            message.text += " ❤️";
          }
        });
      },

      child: Align(
        alignment: message.isSent
            ? Alignment.centerRight
            : Alignment.centerLeft,

        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),

          padding: const EdgeInsets.all(8),

          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width *
                    0.75,
          ),

          decoration: BoxDecoration(
            color: message.isSent
                ? const Color(0xFF005C4B)
                : const Color(0xFF1E2D35),

            borderRadius: BorderRadius.only(
              topLeft:
                  const Radius.circular(8),
              topRight:
                  const Radius.circular(8),

              bottomLeft: message.isSent
                  ? const Radius.circular(8)
                  : Radius.zero,

              bottomRight: message.isSent
                  ? Radius.zero
                  : const Radius.circular(8),
            ),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              if (message.replyTo != null)
                Container(
                  margin:
                      const EdgeInsets.only(
                          bottom: 6),

                  padding:
                      const EdgeInsets.all(6),

                  decoration: BoxDecoration(
                    color: Colors.black26,

                    borderRadius:
                        BorderRadius.circular(
                            6),
                  ),

                  child: Text(
                    message.replyTo!,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ),

              Text(
                message.text,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  if (message.isEdited)
                    const Text(
                      "معدلة ",
                      style: TextStyle(
                        color:
                            Colors.white54,
                        fontSize: 10,
                      ),
                    ),

                  Text(
                    message.time,

                    style: const TextStyle(
                      color:
                          Colors.white54,
                      fontSize: 10,
                    ),
                  ),

                  if (message.isSent)
                    const Padding(
                      padding:
                          EdgeInsets.only(
                              left: 4),
                      child: Icon(
                        Icons.done_all,
                        size: 14,
                        color:
                            Color(0xFF53BDEB),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReplyEditBar() {
    final bool isEdit = _editMessage != null;
    final MessageModel message =
        isEdit ? _editMessage! : _replyMessage!;

    return Container(
      color: const Color(0xFF1F2C34),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A3942),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit
                        ? "تعديل الرسالة"
                        : (message.isSent
                            ? "أنت"
                            : widget.name),
                    style: TextStyle(
                      color: isEdit
                          ? Colors.amber
                          : Colors.green,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    message.text,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                _replyMessage = null;
                _editMessage = null;
                _msgController.clear();
              });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildEmojiPicker() {
    return Container(
      height: 250,
      color: const Color(0xFF1F2C34),

      child: GridView.builder(
        padding: const EdgeInsets.all(10),

        itemCount: _emojiList.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _addEmoji(_emojiList[index]);
            },
            child: Center(
              child: Text(
                _emojiList[index],
                style:
                    const TextStyle(fontSize: 26),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildRecordingBar() {
    return Container(
      color: const Color(0xFF1F2C34),

      padding: const EdgeInsets.all(12),

      child: Row(
        children: [

          IconButton(
            onPressed: _cancelRecording,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                _formatDuration(
                  _recordDuration,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          IconButton(
            onPressed:
                _stopRecordingAndSend,
            icon: const Icon(
              Icons.send,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildInputBar() {
    final bool isTextEmpty =
        _msgController.text.trim().isEmpty;

    return Container(
      color: const Color(0xFF1F2C34),

      padding: const EdgeInsets.all(8),

      child: Row(
        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(
                  0xFF2A3942,
                ),
                borderRadius:
                    BorderRadius.circular(
                        25),
              ),

              child: Row(
                children: [

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap:
                        _toggleEmojiPicker,
                    child: Icon(
                      _showEmojiPicker
                          ? Icons.keyboard
                          : Icons
                              .emoji_emotions_outlined,
                      color:
                          Colors.white54,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      controller:
                          _msgController,

                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                      ),

                      minLines: 1,
                      maxLines: 4,

                      onChanged: (_) {
                        setState(() {});
                      },

                      decoration:
                          const InputDecoration(
                        border:
                            InputBorder
                                .none,
                        hintText:
                            "اكتب رسالة...",
                        hintStyle:
                            TextStyle(
                          color: Colors
                              .white54,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        _onAttachPressed,
                    child: const Icon(
                      Icons.attach_file,
                      color:
                          Colors.white54,
                    ),
                  ),

                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap:
                        _onCameraPressed,
                    child: const Icon(
                      Icons.camera_alt,
                      color:
                          Colors.white54,
                    ),
                  ),

                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: () {
              if (isTextEmpty) {
                _startRecording();
              } else {
                _sendMessage();
              }
            },

            child: CircleAvatar(
              radius: 24,
              backgroundColor:
                  const Color(
                0xFF00A884,
              ),

              child: Icon(
                isTextEmpty
                    ? Icons.mic
                    : (_editMessage !=
                            null
                        ? Icons.check
                        : Icons.send),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}