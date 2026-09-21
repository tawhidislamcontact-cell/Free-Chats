import 'package:flutter/material.dart';
import 'sign_up_screen.dart';

void main() {
  runApp(const FreeChatsApp());
}

class FreeChatsApp extends StatelessWidget {
  const FreeChatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Chats',
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
          ),
        ),
      ),

      // System Auto Mode
      themeMode: ThemeMode.system,

      home: const MainTabController(),
    );
  }
}

class MainTabController extends StatelessWidget {
  const MainTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Free Chats'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.person_add), text: 'Sign Up'),
              Tab(icon: Icon(Icons.chat_bubble), text: 'Chats'),
              Tab(icon: Icon(Icons.security), text: 'Security'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SignUpScreen(),
            const ChatBubbleDemoScreen(),
            const SecurityScreen(),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. CHAT BUBBLE UI MODULE
// ==========================================
class ChatBubbleDemoScreen extends StatelessWidget {
  const ChatBubbleDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBubble(
          context: context,
          message: 'Hello! Welcome to Free Chats.',
          isMe: false,
          isDark: isDark,
        ),
        _buildBubble(
          context: context,
          message: 'Hi! Is the UI light & dark mode ready?',
          isMe: true,
          isDark: isDark,
        ),
        _buildBubble(
          context: context,
          message: 'Yes! It dynamically adapts to system themes and includes secure password management.',
          isMe: false,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildBubble({
    required BuildContext context,
    required String message,
    required bool isMe,
    required bool isDark,
  }) {
    final bubbleColor = isMe
        ? (isDark ? Colors.indigoAccent : Colors.indigo)
        : (isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade200);

    final textColor = isMe ? Colors.white : (isDark ? Colors.white : Colors.black87);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}

// ==========================================
// 2. SECURITY & PASSWORD MANAGEMENT MODULE
// ==========================================
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _contactController = TextEditingController();
  final _otpController = TextEditingController();

  bool _isForgotPasswordMode = false;
  bool _otpSent = false;

  void _changePassword() {
    if (_newPassController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match!')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully!')),
    );
  }

  void _sendOtp() {
    setState(() {
      _otpSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP sent to your registered contact!')),
    );
  }

  void _resetPasswordWithOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isForgotPasswordMode ? 'Forgot Password' : 'Change Password',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isForgotPasswordMode = !_isForgotPasswordMode;
                    _otpSent = false;
                  });
                },
                child: Text(_isForgotPasswordMode ? 'Back to Change Password' : 'Forgot Password?'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!_isForgotPasswordMode) ...[
            // Standard Change Password Form
            TextField(
              controller: _oldPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Current Password'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _newPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm New Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('Update Password'),
            ),
          ] else ...[
            // OTP Forgot Password Flow
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Registered Email or Phone'),
            ),
            const SizedBox(height: 12),
            if (!_otpSent)
              ElevatedButton(
                onPressed: _sendOtp,
                child: const Text('Send OTP'),
              )
            else ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Enter OTP Code'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _newPassController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Set New Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPasswordWithOtp,
                child: const Text('Reset Password'),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
