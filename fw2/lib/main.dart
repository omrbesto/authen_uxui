import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(
          children: [
            Image.asset(
              'assets/ricado.jpg',
              width: 500,
              height: 300,
              fit: BoxFit.cover,
            ),
            TitleSection(),
            buttonSection(),
            description(),
          ],
        )),
      ),
      builder: EasyLoading.init(),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'พี่โตถูกใจสิ่งนี้',
              style: TextStyle(fontWeight: (FontWeight.bold)),
            ),
            Text(
              'Ricardo Milos',
              style: TextStyle(),
            ),
          ],
        ),
        Row(
          children: [
            FavoriteWidget(),
          ],
        )
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon:
                    (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
                color: Colors.red[500],
                onPressed: _toggleFavorite,
              ),
            ),
            SizedBox(
              width: 18,
              child: Container(
                child: Text('$_favoriteCount'),
              ),
            ),
          ],
        ));
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        EasyLoading.showInfo('Unliked');
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
        EasyLoading.showSuccess('Liked');
      }
    });
  }
}

class buttonSection extends StatelessWidget {
  const buttonSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            IconButton(
              icon: (Icon(
                Icons.phone,
                color: Colors.blue,
              )),
              onPressed: () {
                EasyLoading.showToast('พี่โตโทรหาคุณ');
              },
            ),
            Text(
              "CALL",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: (Icon(
                Icons.near_me,
                color: Colors.blue,
              )),
              onPressed: () {
                EasyLoading.showToast('พี่โตถูกใจสิ่งนี้');
              },
            ),
            Text(
              'ROUTE',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: (Icon(
                Icons.share,
                color: Colors.blue,
              )),
              onPressed: () {
                html.window
                    .open('https://www.youtube.com/watch?v=GM60LKSkbGA', '');
              },
            ),
            Text(''),
            Text(
              'SHARE',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        )
      ],
    ));
  }
}

class description extends StatelessWidget {
  const description({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Text(
            "   คลิปผู้ชายกล้ามโต ผ้าโพกหัวสีแดง สวมเพียงกางเกงในลายธงชาติอเมริกันตัวจิ๋ว กำลังเต้นยั่วยวนโชว์บั้นท้ายติดระเบิด กับท่าทางยกนิ้วโป้งพร้อมแคปชัน “พี่โตถูกสิ่งนี้” กลายเป็นมีมสุดฮิตที่กำลังมาแรงในช่วงเวลานี้ ซึ่งแม้หน้าตาของเขาจะละม้ายคล้ายคลึงกับอดีตนักร้องชื่อดังวงคนโง่ แต่น้อยคนนักจะรู้ว่าแท้จริงแล้วเขาคือใครกันแน่"
            "   ริคาร์โด ไมลอส คือชื่อจริงของชายคนนั้น"
            "   ไมลอสเป็นนายแบบสำหรับผู้ใหญ่ชาวบราซิล ที่โด่งดังจากคลิปดังกล่าวในเว็บไซต์หนังโป๊เกย์ของประเทศอังกฤษในชื่อ Jock Butt ต่อมาคลิปดังกล่าวก็ถูกเผยแพร่ในเว็บไซต์ชื่อดังของประเทศญี่ปุ่น Nico Nico Douga (NND) ในหัวข้อ Gachimuchi หรือหนุ่มกล้ามโต (muscular boys) ทำให้คลิปเด้งเป้าของพี่แกกลายเป็นที่นิยมในประเทศญี่ปุ่น มีการทำคลิปล้อเลียนออกมาจำนวนมากจนเป็นไวรัล"));
  }
}
