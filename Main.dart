import 'package:flutter/material.dart';

void main() {
  runApp(const FreeChatsApp());
}

class FreeChatsApp extends StatefulWidget {
  const FreeChatsApp({super.key});

  @override
  State<FreeChatsApp> createState() => _FreeChatsAppState();
}

class _FreeChatsAppState extends State<FreeChatsApp> {
  // ডিফল্ট ডার্ক মোড (ফেসবুক স্টাইল #18191A)
  ThemeMode _themeMode = ThemeMode.dark;

  // ডার্ক এবং লাইট মোড টগল করার ফাংশন
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Chats',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      // লাইট মোড থিম
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      // ফেসবুক স্টাইল ডার্ক মোড
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF18191A),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF242526),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const ChatRoomScreen(
        peerName: 'Zahirul Islam Jihan',
        lastSeen: 'Active 10 hours ago',
      ),
    );
  }
}
