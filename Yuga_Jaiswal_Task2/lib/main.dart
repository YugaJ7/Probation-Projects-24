import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/LoginScreen/auth_page.dart';
import 'package:todo_app/Screens/LoginScreen/login.dart';
import 'package:todo_app/Screens/LoginScreen/login_register.dart';
//import 'package:todo_app/Screens/home_screen.dart';
import 'package:todo_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo App",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AuthPage(),
        //'/home': (context) => HomeScreen(),
        '/login': (context) =>  LoginOrRegister(),
      },
    );
  }
}
