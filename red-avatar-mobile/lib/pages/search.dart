import 'dart:convert';
import 'dart:developer' as developer;

import 'package:blaster/model/blockchain.donor.dart';
import 'package:blaster/model/donation.dart';
import 'package:blaster/model/donor.dart';
import 'package:blaster/model/enums.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String serverAppUrl = 'http://10.0.2.2:3000';
  List<SearchResult> results = [];
  List<String> bloodGroups = <String>[
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];
  String selectedBloodGroup = "A+";
  bool searched = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  autofocus: true,
                  value: selectedBloodGroup,
                  items: bloodGroups
                      .map<DropdownMenuItem<String>>((String val) =>
                          DropdownMenuItem<String>(
                              value: val, child: Text(val)))
                      .toList(),
                  onChanged: (String newValue) {
                    developer.log("Selected Group: " + newValue,
                        level: DiagnosticLevel.debug.index,
                        name: "blaster.search.category",
                        time: DateTime.now());
                    setState(() {
                      selectedBloodGroup = newValue;
                      results = [];
                      searched = false;
                    });
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).primaryColor,
                onPressed: _findBlood,
              ),
            )
          ],
        ),
        SizedBox(height: 40.0),
        (searched)
            ? Text(
                'Results',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              )
            : Text(''),
        Divider(
          height: 40.0,
        ),
        Container(
          height: 400,
          child: ListView.builder(
            itemCount: results == null ? 0 : results.length,
            itemBuilder: _resultWidgetBuilder,
          ),
        ),
      ],
    );
  }

  Widget _resultWidgetBuilder(BuildContext context, int index) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue),
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
                results[index].bloodGroup,
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              _getInstituteName(results[index].instituteId),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.pin_drop, color: Colors.blueAccent),
                Text(
                    results[index].latLong.latitute.toString() +
                        ", " +
                        results[index].latLong.longitude.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15.0))
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0),
                onPressed: () => _openMap(results[index].latLong))),
      ),
    );
  }

  void _openMap(LatLong latLong) async {
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

  void _findBlood() {
    results = [];
    http.get(serverAppUrl + "/blaster/blood/" + selectedBloodGroup,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      List<Donor> donors =
          List<Map<String, dynamic>>.from(json.decode(response.body))
              .map((Map<String, dynamic> e) => Donor.fromJson(e))
              .toList();
      donors.forEach((donor) {
        if (DonationRequestStatus.REQUESTED == donor.donationRequest.status) {
          SearchResult result = SearchResult(
              bloodGroup: donor.bloodGroup,
              instituteId: donor.donationRequest.donationCenter,
              latLong: LatLong(latitute: 20.305951, longitude: 85.831746));
          results.add(result);
        }
      });
      setState(() {
        results = results;
        searched = true;
      });
    }).catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not find any maching blood'),
      ));
    });

    http.get(serverAppUrl + "/blaster/blockchain/" + selectedBloodGroup,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      List<BlockchainDonor> donors =
          List<Map<String, dynamic>>.from(json.decode(response.body))
              .map((e) => BlockchainDonor.fromJson(e))
              .toList();

      donors.forEach((donor) {
        donor.donationDetails
            .where((donation) => donation.bagStatus == BagStatus.APPROVED)
            .forEach((donation) {
          SearchResult searchResult = SearchResult(
              bloodGroup: donor.bloodGroup,
              instituteId: donation.collectedInstitute,
              latLong: LatLong(latitute: 20.305951, longitude: 85.831746));
          results.add(searchResult);
        });
      });

      setState(() {
        results = results;
        searched = true;
      });

      if (results.isEmpty) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Could not find any maching blood'),
        ));
      }
    }).catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not find any maching blood'),
      ));
    });
  }
}

class SearchResult {
  String bloodGroup;
  String instituteId;
  LatLong latLong;
  int count = 0;

  SearchResult({this.bloodGroup, this.instituteId, this.latLong});
}

class LatLong {
  double latitute;
  double longitude;

  LatLong({this.latitute, this.longitude});
}
