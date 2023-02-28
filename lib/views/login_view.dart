import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Enter Email',
            ),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Enter Password'),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextButton(
            onPressed: () async {
              var email = _emailController.text;
              var password = _passwordController.text;

              try {
                var credentials = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(credentials);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  print('your password is invalid');
                }
                if (e.code == 'user-not-fund') {
                  print('invalid email');
                }
              } catch (e) {
                print('something went wrong');
                print(e);
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
            child: const Text('Already registered? go to Register'),
          )
        ],
      ),
    );
  }
}
