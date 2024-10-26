import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Components/text.dart';
import 'package:todo_app/Screens/LoginScreen/login.dart';

class Register extends StatefulWidget {
  final Function(String) onTap;
  const Register({
    super.key,
    required this.onTap,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscureText = true;
  var name = TextEditingController();
  var emailtext = TextEditingController();
  var password = TextEditingController();
  var confirmpass = TextEditingController();
  void usersignup() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (password.text == confirmpass.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailtext.text,
          password: password.text,
        );
        Navigator.pop(context);
        widget.onTap(name.text);
        showdialog(context);
        await Future.delayed(Duration(milliseconds: 100));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Login(
                      onTap: () {},username: name.text,
                    )));
        Navigator.of(context).pop();
      } else {
        Navigator.pop(context);
        await Future.delayed(Duration(milliseconds: 100));
        showErrorMessage("Password doesn't match");        
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      await Future.delayed(Duration(milliseconds: 100));
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
            text: "Create your new \naccount",
            fontStyle: null,
            color: Colors.black,
            fontweigth: FontWeight.bold,
            fontSize: 40,
          ),
          SizedBox(height: 10),
          CustomText(
            text: "Create an account to start your day",
            fontStyle: null,
            color: Colors.grey,
            fontweigth: null,
            fontSize: 16,
          ),
          SizedBox(height: 10),
          CustomText(
            text: "Username",
            fontStyle: null,
            color: Colors.black,
            fontweigth: null,
            fontSize: 16,
          ),
          SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.name,
            controller: name,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                filled: true,
                labelText: "Enter Your Name",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),),
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
            keyboardType: TextInputType.name,
            controller: emailtext,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                filled: true,
                labelText: "Enter Your Email Address",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),),
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
            controller: password,
            obscureText: false,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                filled: true,
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),),
          ),
          SizedBox(height: 10),
          CustomText(
            text: "Confirm Your Password",
            fontStyle: null,
            color: Colors.black,
            fontweigth: null,
            fontSize: 16,
          ),
          SizedBox(height: 5),
          TextField(
            controller: confirmpass,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Color.fromRGBO(196, 196, 196, 0.2),
                filled: true,
                labelText: "Confirm Password",
                labelStyle: const TextStyle(color: Colors.grey),
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
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              String uname = emailtext.toString();
              String passwrd = password.text.toString();
              usersignup();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login(onTap: () {},username: name.text,)));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 146),
              backgroundColor: Color.fromARGB(255, 29, 78, 216),
            ),
            child: Text(
              'Register',
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
            children: [
              Text("Have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login(
                                onTap: () {},username: name.text,
                              )));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color.fromARGB(255, 29, 78, 216),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ]),
    );
  }

  void showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("You are registered"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          );
    });
  }
}
