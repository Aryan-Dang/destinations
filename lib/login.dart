import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'aboutpage.dart';
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
    void _navToAbout() {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPage(title: 'About the Destinations App')),
        );
      });
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> _addUser(String mail) {
      // Call the user's CollectionReference to add a new user
      return users
      .doc(mail)
      .set({
        'Destinations':[]
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Destinations"),
        actions: <Widget>[
            IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: _navToAbout,
          )
          ]
        ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome to the Destinations app!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40.0,
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
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ElevatedButton(
                        //color: Colors.blue,
                        child: Text("Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )
                        ),
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
                              MaterialPageRoute(builder: (context) => DestinationPage(title: 'Saved Destinations', email: emailController.text)),
                            );
                          } on FirebaseAuthException catch  (e) {
                            print('Login Failed. Error code: ${e.code}');
                            print(e.message);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: ElevatedButton(
                          child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                            )
                          ),
                          //color: Colors.blue,
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              print('Account created!');
                              await _addUser(emailController.text);
                            } on FirebaseAuthException catch  (e) {
                              print('Signup Failed. Error code: ${e.code}');
                              print(e.message);
                            }
                          }
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}