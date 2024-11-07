import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/login.dart';
import 'package:quiz_app/screens/util.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
   });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

bool obscureText = true;
  String email = '';
  String password = '';
  String username = '';
Future <void> register() async{
  if (formKey.currentState!.validate()){
      try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'username': username,
        'email' : email,
        'password' : password
      }
      );

      Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen()));
    }on FirebaseAuthException catch(e){
      showErrorMessage(e.code);
    }
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
          //padding: const EdgeInsets.all(16.0), 
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                 SizedBox(height: 30),
                        Center(
                          child: Image.asset(
                            'assets/splash_front.png', 
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                  CustomText(
                    text: "Welcome to",
                    fontStyle: null,
                    color: Colors.black87,
                    fontweigth: FontWeight.bold,
                    fontSize: 40,
                  ),
                  CustomText(
                    text: "Quizzy",
                    fontStyle: null,
                    color: Colors.black87,
                    fontweigth: FontWeight.bold,
                    fontSize: 40,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: "Create an account to begin the fun",
                    fontStyle: null,
                    color: Colors.grey,
                    fontweigth: null,
                    fontSize: 16,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value)=>username=value,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                        filled: true,
                        hintText: "Enter Your Name",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                        prefixIcon: const Icon(Icons.person),),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    onChanged: (value) => email = value,
                    validator: (value) => !EmailValidator.validate(value!, true)
                        ? 'Not a valid email.'
                        : null,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                        filled: true,
                        hintText: "Enter Your Email Address",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                        prefixIcon: const Icon(Icons.mail),),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    onChanged: (value) => password = value,
                    obscureText: obscureText,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: register,
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
                                height: 50,
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?",style: TextStyle(fontSize: 15,color: Colors.black)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 23, 9, 133),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
                        ),
              ),
            ),
          ),
        ]
        ),
  ],
      ),
    );
  }
}
