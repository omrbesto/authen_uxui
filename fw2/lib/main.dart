import 'package:flutter/material.dart';

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
            'assets/lake.jpg',
            width: 500,
            height: 300,
            fit: BoxFit.cover,
          ),
          TitleSection(),
          buttonSection(),
          description(),
        ],
      )),
    ));
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
              'Oeschinen Lake Campground',
              style: TextStyle(fontWeight: (FontWeight.bold)),
            ),
            Text(
              'Kandersteg, Switzerland',
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
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
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
            Icon(
              Icons.phone,
              color: Colors.blue,
            ),
            Text(
              "CALL",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.near_me,
              color: Colors.blue,
            ),
            Text(
              "Route",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.share,
              color: Colors.blue,
            ),
            Text(
              "SHARE",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
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
          "Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.",
        ));
  }
}
