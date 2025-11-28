import 'package:flutter/material.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        'name': 'Sasha',
        'message': 'Mau diskusi lewat zoom?',
        'time': '7.30 PM',
        'unread': 1,
      },
      {
        'name': 'Juno',
        'message': 'Mau ketemu offline?',
        'time': '9.30 AM',
        'unread': 3,
      },
      {
        'name': 'Harya',
        'message': 'P',
        'time': '1.30 PM',
        'unread': 5,
      },
      {
        'name': 'Adlina',
        'message': 'Terima kasih kak! seru sekali!!',
        'time': '5.40 PM',
        'unread': 0,
      },
      {
        'name': 'Lea',
        'message': 'Ok kak aman banget makasih ya',
        'time': '8.28 AM',
        'unread': 3,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // HEADER UNGU + CHAT TITLE + SEARCH
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    // bg ungu
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFBFC9FF),
                            Color(0xFFA8B6FF),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                    ),

                    // 🎨 elemen lengkung putih di kiri atas
                    Positioned(
                      top: -80,
                      left: -120,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(260),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -40,
                      left: -60,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.26),
                          borderRadius: BorderRadius.circular(220),
                        ),
                      ),
                    ),

                    // konten header: title + search
                    SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          const Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // SEARCH BAR – KOTAK
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.8),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Cari chat',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.search),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // AREA PUTIH + LIST CHAT
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return _ChatItem(
                        name: chat['name'] as String,
                        message: chat['message'] as String,
                        time: chat['time'] as String,
                        unread: chat['unread'] as int,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatRoomScreen(
                                tutorName: chat['name'] as String,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // NAVBAR DI BAWAH
          const Align(
            alignment: Alignment.bottomCenter,
            child: _BottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final VoidCallback onTap;

  const _ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F2FF),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo.png', // ganti nanti
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4B3C73),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6E6E8F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6E6E8F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (unread > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6E8BFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        unread.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
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
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 32,
            color: Colors.white,
          ),
          Positioned(
            bottom: 10,
            left: 40,
            right: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // pill ungu
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBFC9FF),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.home_rounded,
                          color: Colors.white, size: 24),
                      Icon(Icons.person_rounded,
                          color: Colors.white, size: 24),
                    ],
                  ),
                ),

                // cekungan putih di tengah
                Positioned(
                  top: -12,
                  child: Container(
                    width: 80,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(36),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
