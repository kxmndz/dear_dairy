import 'package:dear_dairy/AppContext.dart';
import 'package:flutter/material.dart';

class DairyLoginPage extends StatelessWidget {
  const DairyLoginPage({super.key});

  final _username = '';

  void _handleLogin(BuildContext context) {
    AppContext ctx;
    Navigator.pushNamedAndRemoveUntil(context, '/entries', (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Center(
              child: Text(
                'Dear Dairy',
                style: TextStyle(fontSize: 48, fontFamily: 'monospace'),
              ),
            ),

            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
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
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () => _handleLogin(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
