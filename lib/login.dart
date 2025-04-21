import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _login() {
    if (_userController.text == 'admin' && _passController.text == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
