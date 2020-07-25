import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redavatar/model/award.dart';

class AwardWidget extends StatelessWidget {
  final Award award;
  AwardWidget({this.award});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow[200], border: Border.all(color: Colors.black)),
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.award,
              size: 50,
              color: Colors.red,
            ),
            // Image.asset("assets/images/commend.jpg", scale: 12),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(award.awardName, style: TextStyle(fontSize: 20.0)),
            )
          ],
        ),
      ),
    );
  }
}
