import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'destinationpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Initialize FlutterFire
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login/Signup",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 50.0,
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 5),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.lightBlueAccent,
                child: Text("Log In!"),
                onPressed: () async {

                  //Test code to print contents of controllers
                  // print(emailController.text);
                  // print(passwordController.text);

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text
                    );
                    print('Login successful!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DestinationPage(title: 'Saved Destinations')),
                    );
                  } on FirebaseAuthException catch  (e) {
                    print('Login Failed. Error code: ${e.code}');
                    print(e.message);
                  }
                },
              ),
              RaisedButton(
                child: Text("Sign Up!"),
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text
                    );
                    print('Account created!');
                  } on FirebaseAuthException catch  (e) {
                    print('Signup Failed. Error code: ${e.code}');
                    print(e.message);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}