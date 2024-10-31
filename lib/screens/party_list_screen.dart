// lib/screens/party_list_screen.dart
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class PartyListScreen extends StatelessWidget {
  const PartyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 변경
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              '필터',
              style: TextStyle(
                color: Colors.black,  // 텍스트 색상을 검은색으로 변경
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Switch(
              value: true,
              onChanged: (bool value) {},
              activeColor: const Color(0xFFC871FD),  // 스위치 색상을 메인 테마 색상으로 변경
              activeTrackColor: const Color(0xFFC871FD).withOpacity(0.3),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 필터 버튼들
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD89DFF).withOpacity(0.2),  // 필터 버튼 배경색 변경
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '같이 먹어요',
                    style: TextStyle(
                      color: Color(0xFFD89DFF),  // 텍스트 색상 변경
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8FA),  // 비활성 필터 배경색 변경
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '따로 먹어요',
                    style: TextStyle(
                      color: Colors.grey,  // 비활성 텍스트 색상
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 파티 목록
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPartyCard(
                  context,
                  title: '치킨의 민족',
                  menu: '후라이드 치킨',
                  capacity: '2/4',
                  isAvailable: true,
                ),
                const SizedBox(height: 16),
                _buildPartyCard(
                  context,
                  title: '피자헛',
                  menu: '페페로니 피자',
                  capacity: '3/4',
                  isAvailable: true,
                ),
                const SizedBox(height: 16),
                _buildPartyCard(
                  context,
                  title: '맥도날드',
                  menu: '빅맥 세트',
                  capacity: '1/4',
                  isAvailable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyCard(
      BuildContext context, {
        required String title,
        required String menu,
        required String capacity,
        required bool isAvailable,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),  // 테두리 색상 변경
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,  // 텍스트 색상 변경
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8FA),  // 배지 배경색 변경
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        capacity,
                        style: const TextStyle(
                          color: Colors.black87,  // 배지 텍스트 색상 변경
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '메뉴: $menu',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 48,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE0E0E0)),  // 구분선 색상 변경
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFCC8FFA),  // 버튼 텍스트 색상 변경
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: const Text('참여하기'),
            ),
          ),
        ],
      ),
    );
  }
}