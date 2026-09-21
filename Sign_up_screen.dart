import 'package02/flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up - Free Chats')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value!),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email or Phone Number'),
                onSaved: (value) => _contact = value!,
              ),
              if (_otpSent) ...[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Verification Code'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _otp = value!,
                ),
                ElevatedButton(
                  onPressed: _isVerifying ? null : () {},
                  child: _isVerifying
                      ? CircularProgressIndicator()
                      : Text('Verify & Sign Up'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    setState(() => _otpSent = true);
                  },
                  child: Text('Send Verification Code'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
