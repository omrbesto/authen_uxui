import 'package:authen_uxui/components/usered.dart';

import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adddel extends StatefulWidget {
  final String status;
  const Adddel({Key key, this.status}) : super(key: key);

  @override
  _AdddelState createState() => _AdddelState();
}

class _AdddelState extends State<Adddel> {
  String docID, name, genre, rating;
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
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (doc) => docID = doc,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Docoment.ID can' 't use in Create Data',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (names) => name = names,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (genres) => genre = genres,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Genre',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Text(""),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (rate) => rating = rate,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Rating',
                      labelStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButtonCData(),
              buildButtonUData(),
              buildButtonDData(),
              buildButtonBack(),
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

  void createData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .add({'Name': '$name', 'Genre': '$genre', 'Rating': '$rating'})
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }

  void updateData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .doc("$docID")
        .update({'Name': '$name', 'Genre': '$genre', 'Rating': '$rating'})
        .then((value) => print('updated!'))
        .catchError((e) => print('update error'));
  }

  Future DeleteData() {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    users
        .doc('$docID')
        .delete()
        .then((value) => print('delete success!'))
        .catchError((e) => print(e));
  }

  Container buildButtonBack() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Back",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Usered()));
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

  Container buildButtonCData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Create Data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          onTap: () {
            createData();
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#20C9D8"), HexColor("#00FF82")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonUData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Update Data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black)),
          onTap: () {
            updateData();
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#2ECCDD"), HexColor("#2D78F6")],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildButtonDData() {
    return Container(
        constraints: BoxConstraints.expand(width: 300, height: 50),
        child: InkWell(
          child: Text("Delete Data",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
          onTap: () {
            DeleteData();
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [HexColor("#FF0083"), HexColor("#FF6262")],
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
