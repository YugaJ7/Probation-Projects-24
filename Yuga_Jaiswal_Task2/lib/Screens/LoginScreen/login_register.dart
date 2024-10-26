import 'package:flutter/material.dart';
import 'package:todo_app/Screens/LoginScreen/login.dart';
import 'package:todo_app/Screens/LoginScreen/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    if (showLogin = true) {
      return Login(onTap:(){
        setState(() {
          showLogin=!showLogin;
        });
      },
       username: 'default');
    } else {
      return Register(
        onTap: (String username) {
          // Pass the username from Register to Login
          setState(() {
            showLogin = !showLogin;
          });
          // Once the registration is done, show login with the username
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(
                onTap: () {
                  setState(() {
                    showLogin = !showLogin;
                  });
                },
                username: username, // Pass the username to the Login page
              ),
            ),
          );
        },
      );
    }
  }
}