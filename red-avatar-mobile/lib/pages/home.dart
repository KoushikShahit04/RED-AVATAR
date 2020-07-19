import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            'My Donations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/5-stars.jpeg',
                  scale: 4.5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '80 Unit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          Text(
            'Platinum Donor',
            style: TextStyle(color: Colors.yellow[800], fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Divider(
            color: Colors.black,
          ),
          Row(children: <Widget>[
            Image.asset(
              "assets/images/commend.jpg",
              scale: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '12 Donation College Award',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
          Divider(
            color: Colors.black,
          ),
          Row(children: <Widget>[
            Image.asset(
              "assets/images/commend.jpg",
              scale: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Odisha CM Donor Award',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
          Divider(
            color: Colors.black,
          ),
          Row(children: <Widget>[
            Image.asset(
              "assets/images/commend.jpg",
              scale: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Pm Platinum Donor Award',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
          Divider(
            color: Colors.black,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/blood_drop.png',
                scale: 2.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('1st Donation - 1999'),
                    Text('During College - 12 Units'),
                    Text('Corporate - 40 Units'),
                    Text('Voluntary - 18 Units'),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
