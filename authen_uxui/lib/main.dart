import 'package:authen_uxui/components/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//C:\Users\Asus\flutter\authen_uxui\lib\components\signin.dart
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
  //await createUser();

  await auth.signOut();

  runApp(MaterialApp(
    home: Scaffold(
      body: Signin(),
    ),
  ));
}

Future createUser() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "testing@gmail.com", password: "123456");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The Password is to weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
