import 'package:dear_dairy/AppContext.dart';
import 'package:flutter/material.dart';

class DairyLoginPage extends StatefulWidget {
  const DairyLoginPage({super.key});

  @override
  State<DairyLoginPage> createState() => _DairyLoginPageState();
}

class _DairyLoginPageState extends State<DairyLoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Center(
              child: Text(
                'Dear Dairy',
                style: TextStyle(fontSize: 48, fontFamily: 'monospace'),
              ),
            ),

            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () {
                final username = _usernameController.text;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/entries',
                      (r) => false,
                  arguments: AppContext.internal(username: username),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
