import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Components/navbar.dart';
import 'package:todo_app/Components/text.dart';
import 'package:todo_app/Screens/LoginScreen/register.dart';

class Login extends StatefulWidget {
  final void Function() onTap;
  final String username;
  const Login({
    super.key,
    required this.onTap,
    required this.username
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final email = TextEditingController();
  final password = TextEditingController();

  void signuserin() async {

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Navbar(username: widget.username,)),
    );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return
            AlertDialog(
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
            ]);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              CustomText(
                text: "Login to your \naccount.",
                fontStyle: null,
                color: Colors.black,
                fontweigth: FontWeight.bold,
                fontSize: 40,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Please sign in to your account",
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
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.name,
                controller: email,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Enter Your Email Address',
                    fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.mail),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
          
                  ),
              ),
              SizedBox(height: 20),
              CustomText(
                text: "Password",
                fontStyle: null,
                color: Colors.black,
                fontweigth: null,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: _obscureText,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(196, 196, 196, 0.2),
                    filled: true,
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
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
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Color.fromARGB(255, 29, 78, 216), fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                      String uname = email.text.toString();
                      String passwrd = password.text.toString();
                      signuserin();
                    }, 
                    style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 150),
                    backgroundColor: Color.fromARGB(255, 29, 78, 216),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Or sign in with'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/g.png', 
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
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Register(onTap: (String username) {
                             },),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Color.fromARGB(255, 29, 78, 216),),
                      ),
                    ),
                  ],
                )
            ],
          ),
      ]),
    );
  }
}