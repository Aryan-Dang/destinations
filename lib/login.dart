// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// // Import the firebase_core plugin
// import 'package:firebase_core/firebase_core.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }
//
// /// We are using a StatefulWidget such that we only create the [Future] once,
// /// no matter how many times our widget rebuild.
// /// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
// /// would re-initialize FlutterFire and make our application re-enter loading state,
// /// which is undesired.
// class App extends StatefulWidget {
//   // Create the initialization Future outside of `build`:
//   @override
//   _AppState createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//   /// The future is part of the state of our widget. We should not call `initializeApp`
//   /// directly inside [build].
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return SomethingWentWrong();
//         }
//
//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return App();
//         }
//
//         // Otherwise, show something whilst waiting for initialization to complete
//         return Loading();
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              TextField(
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: schoolController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'School',
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text)
                      .then((value) {
                    print("Successfully sign in");
                    //print(value.user.uid);

                    // FirebaseFirestore.instance.child("users/" + value.user.uid).once()
                    //     .then((ds) {
                    //   print(ds.key);
                    //   print(ds.value);
                    //   GlobalInfo.userInfo = ds.value;
                    //
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => FriendListPage()),
                    //   );
                    //
                    // }).catchError((e) {
                    //   print("Failed to get the user information");
                    // });


                  }).catchError((error) {
                    print("Failed to sign in");
                    print(error);
                  });
                },
              ),
              RaisedButton(
                child: Text("Signup"),
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text)
                      .then((value) {
                    print("Successfully signed up. ");
                    // var uid = value.user.uid;
                    // FirebaseDatabase.instance.reference().child('users/' + uid).set(
                    //     {
                    //       'uid' : uid,
                    //       'email' : emailController.text.toString(),
                    //       'name' : nameController.text.toString(),
                    //       'school' : schoolController.text.toString(),
                    //     }
                    // ).then((value) {
                    //   print("Successfully signed up the user with details.");
                    // }).catchError((error) {
                    //   print("Failed to put the details.");
                    //   print(error);
                    // });
                  }).catchError((error){
                    print("Failed to sign up");
                    print(error);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}