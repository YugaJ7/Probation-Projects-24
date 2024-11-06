import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/register.dart';
import 'package:quiz_app/screens/util.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  String email = '';
  String password = '';
  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch(e){
    showErrorMessage(e.code);
  }
}

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Color.fromARGB(255, 245, 240, 255),
            title: Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',
                    style: TextStyle(color: Colors.black)),
              )
            ]
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
          child: Image.asset(
              'assets/login_back.png',
              fit: BoxFit.cover
            ),
          ),
          ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                  Center(
                    child: Image.asset(
                      'assets/splash_front.png', 
                      height: MediaQuery.of(context).size.height/7,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                CustomText(
                  text: "Login to your \naccount.",
                  fontStyle: null,
                  color: Colors.black87,
                  fontweigth: FontWeight.bold,
                  fontSize: 40,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Please sign in to begin the fun",
                  fontStyle: null,
                  color: Colors.grey,
                  fontweigth: null,
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Email Address",
                  fontStyle: null,
                  color: Colors.black,
                  fontweigth: null,
                  fontSize: 16,
                ),
                SizedBox(height: 5),
                TextField(
                  onChanged: (value) => email = value,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Enter Your Email Address',
                      fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.mail),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                    ),
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Password",
                  fontStyle: null,
                  color: Colors.black,
                  fontweigth: null,
                  fontSize: 16,
                ),
                SizedBox(height: 5),
                TextField(
                  onChanged: (value) => password = value,
                  obscureText: _obscureText,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
                      filled: true,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.key),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Color.fromARGB(255, 23, 9, 133), fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color(0xFF4E42A9),
                      ),
                      child: Text(
                        'Let\'s Play',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Or sign in with',style: TextStyle(fontSize: 15,color: Colors.black)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/g.png', 
                          width: 60,  
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontSize: 15,color: Colors.black)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Register(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 23, 9, 133),),
                        ),
                      ),
                    ],
                  )
              ],
            ),
        ]),
      ]
      ),
    );
  }
}