import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _gender = 'Male';
  String _contact = '';
  String _otp = '';
  bool _otpSent = false;
  bool _isVerifying = false;

  void _sendCode() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _otpSent = true;
      });
    }
  }

  void _verifyAndSignUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isVerifying = true;
      });
      // এখানে পরবর্তীতে OTP ভেরিফাই করার লজিক যুক্ত করতে পারবেন
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up - Free Chats')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value ?? '',
                ),
                DropdownButtonFormField<String>(
                  value: _gender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _gender = value ?? 'Male'),
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email or Phone Number'),
                  onSaved: (value) => _contact = value ?? '',
                ),
                SizedBox(height: 16),
                if (_otpSent) ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Verification Code'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _otp = value ?? '',
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyAndSignUp,
                    child: _isVerifying
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Verify & Sign Up'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: _sendCode,
                    child: Text('Send Verification Code'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
