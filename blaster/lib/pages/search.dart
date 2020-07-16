import 'dart:convert';

import 'package:blaster/model/donation.dart';
import 'package:blaster/model/donor.dart';
import 'package:blaster/model/enums.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
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
            results[index].instituteId,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
        ),
      ),
    );
  }

  void _findBlood() {
    http.get(serverAppUrl + "/blaster/blood/" + selectedBloodGroup,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      List<Donor> donors =
          List<Map<String, dynamic>>.from(json.decode(response.body))
              .map((Map<String, dynamic> e) => Donor.fromJson(e))
              .toList();
      List<SearchResult> searchResults = [];
      donors.forEach((donor) {
        donor.donationDetails.forEach((donation) {
          if (BagStatus.APPROVED == donation.bagStatus) {
            SearchResult result = SearchResult(
                bloodGroup: donor.bloodGroup,
                instituteId: donation.collectedInstitute,
                latLong: LatLong(latitute: 20.305951, longitude: 85.831746));
            searchResults.add(result);
          }
        });

        setState(() {
          results = searchResults;
          searched = true;
        });
      });
      if (donors.isEmpty || searchResults.isEmpty) {
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

  SearchResult({this.bloodGroup, this.instituteId, this.latLong});
}

class LatLong {
  double latitute;
  double longitude;

  LatLong({this.latitute, this.longitude});
}
