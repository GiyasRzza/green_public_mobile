import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:green_public_mobile/page/register/sign_in_page.dart';
import 'package:green_public_mobile/page/register/widget/image_picker.dart';
import 'package:http/http.dart' as http;

class SignUpPersonScreen extends StatelessWidget {
  SignUpPersonScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _registerPerson() async {
    final url = Uri.parse('http://37.60.230.124/api/auth/local/register');
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "name": _nameController.text,
        "surname": _surnameController.text,
        "phoneNumber": _phoneController.text,
        "companyName": "",
        "position": "",
        "type": "user"
      }),
    );

    if (response.statusCode == 200) {
      print('Registration successful');
      print(response.body);
    } else {
      print('Registration failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up as a natural person',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const LogoPicker(isUser: true),
              const SizedBox(height: 16),
              _buildTextField('Name', _nameController),
              _buildTextField('Surname', _surnameController),
              _buildTextField('E-mail address', _emailController),
              _buildTextField('Phone number', _phoneController),
              _buildPasswordField('Password', _passwordController),
              _buildPasswordField('Confirm password', _confirmPasswordController),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registerPerson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Center(child: Text('Confirm', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                child: const Center(child: Text('Explore without registration', style: TextStyle(color: Colors.black))),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Have an account?",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            print("More clicked!");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
