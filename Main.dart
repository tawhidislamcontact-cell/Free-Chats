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
      // সরাসরি চ্যাট রুম স্ক্রিন সেট করা হয়েছে
      home: const ChatRoomScreen(
        peerName: 'Zahirul Islam Jihan',
        lastSeen: 'Active now',
      ),
    );
  }
}

// ==========================================
// চ্যাট রুম স্ক্রিন কম্পোনেন্ট (একই ফাইলের সাথে যুক্ত)
// ==========================================
class ChatRoomScreen extends StatelessWidget {
  final String peerName;
  final String lastSeen;

  const ChatRoomScreen({
    super.key,
    required this.peerName,
    required this.lastSeen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // প্রোফাইল ছবি ছাড়া শুধু বোল্ড নাম
            Text(
              peerName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              lastSeen,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          // অডিও কল বাটন
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // অডিও কল লজিক
            },
          ),
          // ভিডিও কল বাটন
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // ভিডিও কল লজিক
            },
          ),
          // লক্ষ্য করুন: এখানে কোনো 'i' (information) বাটন রাখা হয়নি।
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: const [
                // ডেমো চ্যাট বাবল (লোকাল ফার্স্ট পলিসি অনুযায়ী)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Chip(
                      label: Text("হ্যালো! কেমন আছো?"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "সব ঠিকঠাক আছে ভাই।",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // মেসেজ ইনপুট এবং মিডিয়া শেয়ারিং বার
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.blue),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Message",
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
