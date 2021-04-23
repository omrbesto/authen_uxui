import 'signin.dart';
import 'package:authen_uxui/components/adddel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Usered extends StatefulWidget {
  final String status;
  const Usered({Key key, this.status}) : super(key: key);

  @override
  _UseredState createState() => _UseredState();
}

class _UseredState extends State<Usered> {
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
          image: AssetImage('assets/images/bg2.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snap) {
                final user = snap.data;
                if (user != null) {
                  return Text(
                    'Signed-in as ${user.email}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  );
                }
                return Text(
                  'Sign-Out',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtonMdata(),
              buildButtonDelU(),
              buildButtonSignOut(),
            ],
          ),
        ],
      ),
    ));
  }

  void onClickSignOut() async {
    await FirebaseAuth.instance.signOut();
    //EasyLoading.showSuccess("Sign-Out Complete");
  }

  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Container buildButtonSignOut() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Sign out",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            onClickSignOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Signin()));
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

  Container buildButtonDelU() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Delete User",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            deleteUser();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Signin()));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#F61F46"), HexColor("#FE6F5C")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonMdata() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Modified Data!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Adddel()));
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#00FFBC"), HexColor("#00B8FF")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
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
