import 'package:flutter/material.dart';
import 'package:training_course/constants/routes.dart';
import 'package:training_course/services/auth/auth_service.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerfyEmailState();
}

class _VerfyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text('We have sent an email verification email to your email'),
          const Text(
              'if you have not received the email please press the button'),
          TextButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send Verification Email')),
          TextButton(
              onPressed: () async {
                AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Restart'))
        ],
      ),
    );
  }
}
