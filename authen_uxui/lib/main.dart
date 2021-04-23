import 'package:authen_uxui/components/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print("User is currently signed out!");
    } else {
      print("User is signed In !");
    }
  });
  runApp(MaterialApp(
    home: Scaffold(
      body: Signin(),
    ),
  ));
}
