import 'dart:math';
import 'package:authen_uxui/components/futured.dart';
import 'package:authen_uxui/components/usered.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  final String status;
  const Signin({Key key, this.status}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override //+

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg3.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Music Manager!!',
            style: TextStyle(
              fontSize: 36,
              color: Colors.greenAccent,
            ),
          )),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (mail) => email = mail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (pass) => password = pass,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtonSignIn(),
              buildButtonFSignin(),
              buildButtonGSignin(),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Or you didn't have an ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "acoount ?",
                    style: TextStyle(color: Colors.amberAccent, fontSize: 16),
                  ),
                ],
              ),
              buildButtoncreateUser(),
            ],
          ),
        ],
      ),
    ));
  }

  Future onClickSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: "$email", password: "$password");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Usered()),
      );
      print("Email : $email");
      print("Pass : $password");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (error) {
      print(e);
    }
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          onTap: () async {
            if (email == null || password == null) {
            } else
              await onClickSignIn();
          },
          //EasyLoading.showSuccess('Login Success!');
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#00FFB0"), HexColor("#0082FF")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Future createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: '$email', password: '$password');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Usered()));
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

  Container buildButtoncreateUser() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Register",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () async {
            if (email == null || password == null) {
            } else
              await createUser();
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#F61F46"), HexColor("#FF62B5")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonFSignin() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/fb.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Text("  "),
              Text("Sign-in with Facebook",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Futured()));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#384DEA"), HexColor("#1830E9")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonGSignin() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text("  "),
              Text("Sign-in with Google",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Futured()));
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
