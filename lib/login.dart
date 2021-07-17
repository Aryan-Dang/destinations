import 'package:firebase_auth/firebase_auth.dart';
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
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPage(title: 'About the Destinations App')),
        );
      });
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
              RaisedButton(
                color: Colors.blue,
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
                      MaterialPageRoute(builder: (context) => DestinationPage(title: 'Saved Destinations')),
                    );
                  } on FirebaseAuthException catch  (e) {
                    print('Login Failed. Error code: ${e.code}');
                    print(e.message);
                  }
                },
              ),
              RaisedButton(
                  child: Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                    )
                  ),
                  color: Colors.blue,
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