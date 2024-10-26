import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Components/navbar.dart';
import 'package:todo_app/Screens/LoginScreen/login_register.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              String username = snapshot.data!.displayName ?? "User";
              return Navbar(username: username);
            } else {
              return const LoginOrRegister();
            }
          })),
    );
  }
}
