import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('http://localhost:8080/auth/register'),
                  body: json.encode({
                    'username': usernameController.text,
                    'password': passwordController.text,
                  }),
                  headers: {'Content-Type': 'application/json'},
                );

                if (response.statusCode == 200) {
                  final data = json.decode(response.body);
                  print('User registered: ${data['message']}');
                } else {
                  print('Failed to register user');
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
