import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up - Free Chats')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value ?? '',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _gender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _gender = value ?? 'Male'),
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email or Phone Number'),
                  onSaved: (value) => _contact = value ?? '',
                ),
                const SizedBox(height: 20),
                if (_otpSent) ...[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Verification Code'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _otp = value ?? '',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyAndSignUp,
                    child: _isVerifying
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Verify & Sign Up'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: _sendCode,
                    child: const Text('Send Verification Code'),
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
