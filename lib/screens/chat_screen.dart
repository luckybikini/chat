// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _messagesCollection =
  FirebaseFirestore.instance.collection('messages'); // Firestore 컬렉션 참조

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    if (text.isEmpty) return;

    _controller.clear();

    // Firestore에 메시지 추가
    await _messagesCollection.add({
      'text': text,
      'isMe': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE6E6FA),
              child: Text(
                '치킨',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '치킨 파티방',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesCollection
                  .orderBy('createdAt', descending: true)
                  .snapshots(), // Firestore에서 메시지 스트림 가져오기
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('오류 발생'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  reverse: true, // 최신 메시지가 위로 오도록 설정
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final messageData = messages[index];
                    final message = Message(
                      text: messageData['text'],
                      isMe: messageData['isMe'],
                      time: "방금 전", // 메시지 시간 표시를 추가할 수 있음
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: message.isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!message.isMe) ...[
                            const CircleAvatar(
                              backgroundColor: Color(0xFFE6E6FA),
                              radius: 15,
                              child: Text(
                                '파티장',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Column(
                            crossAxisAlignment: message.isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              if (!message.isMe)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4, bottom: 4),
                                  child: Text(
                                    '파티장',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (message.isMe)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        message.time,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: message.isMe
                                          ? const Color(0xFFE6E6FA) // 라벤더색
                                          : const Color(0xFFF0F0F0), // 회색
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      message.text,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  if (!message.isMe)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        message.time,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '메시지 입력',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8F8FA),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_controller.text),
                    color: const Color(0xFFE6E6FA),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
