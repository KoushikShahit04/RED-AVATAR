import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class SearchResult extends StatelessWidget {
  final Result result;

  SearchResult({this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.white24),
                ),
              ),
              child: Text(
                result.bloodGroup,
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              _getInstituteName(result.instituteId),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.pin_drop, color: Colors.red),
                Text(
                    result.latLong.latitute.toString() +
                        ", " +
                        result.latLong.longitude.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15.0))
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0),
                onPressed: () => _openMap(result.latLong, context))),
      ),
    );
  }

  void _openMap(LatLong latLong, BuildContext context) async {
    double latitude = latLong.latitute;
    double longitude = latLong.longitude;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await urlLauncher.canLaunch(googleUrl)) {
      await urlLauncher.launch(googleUrl);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not find any maching blood'),
      ));
    }
  }

  String _getInstituteName(String instId) {
    List<Map<String, String>> centers = [
      {'value': 'I1234', 'text': 'Apollo Hospital'},
      {'value': 'I1235', 'text': 'Kalinga Hospital'},
    ];
    return centers.firstWhere((element) => element['value'] == instId)['text'];
  }
}

class Result {
  String bloodGroup;
  String instituteId;
  LatLong latLong;
  int count = 0;

  Result({this.bloodGroup, this.instituteId, this.latLong});
}

class LatLong {
  double latitute;
  double longitude;

  LatLong({this.latitute, this.longitude});
}
