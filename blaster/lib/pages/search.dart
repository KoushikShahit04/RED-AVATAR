import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Form(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
