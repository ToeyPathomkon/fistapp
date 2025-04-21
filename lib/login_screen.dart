import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (userController.text == 'admin' && passController.text == 'admin') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Incorrect username or password")),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
