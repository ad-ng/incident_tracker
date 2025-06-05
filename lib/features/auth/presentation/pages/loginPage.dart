import 'package:flutter/material.dart';
import 'package:incident_tracker/features/auth/presentation/widgets/myInput.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text('Hello Again !')),
            Center(child: Text('Log into your account')),
            MyInput(
              hintText: 'Email',
              suffixIcon: Icon(Icons.email),
              isPassword: false,
              textEditingController: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
