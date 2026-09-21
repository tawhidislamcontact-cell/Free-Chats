import 'package:flutter/material.dart';
import 'sign_up_screen.dart';

void main() {
  runApp(FreeChatsApp());
}

class FreeChatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Chats',
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
