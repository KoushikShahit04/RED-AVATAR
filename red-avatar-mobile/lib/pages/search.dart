import 'dart:convert';
import 'dart:developer' as developer;

import 'package:redavatar/model/blockchain.donor.dart';
import 'package:redavatar/model/donor.dart';
import 'package:redavatar/model/enums.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redavatar/widget/search_result.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String serverAppUrl = 'http://10.0.2.2:8888';
  List<Result> donorResults = [];
  List<Result> bloodBagResults = [];
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
                          name: "redavatar.search.category",
                          time: DateTime.now());
                      setState(() {
                        selectedBloodGroup = newValue;
                        donorResults = [];
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
                  color: Theme.of(context).accentColor,
                  onPressed: _findBlood,
                ),
              )
            ],
          ),
          SizedBox(height: 40.0),
          (donorResults.isNotEmpty)
              ? Column(
                  children: <Widget>[
                    Divider(height: 20.0),
                    Text(
                      'Donor Available',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount:
                            donorResults == null ? 0 : donorResults.length,
                        itemBuilder: (context, index) =>
                            SearchResult(result: donorResults[index]),
                      ),
                    )
                  ],
                )
              : Text(""),
          Divider(height: 20.0),
          (bloodBagResults.isNotEmpty)
              ? Text(
                  'Blood Bag Available',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                )
              : Text(''),
          (bloodBagResults.isNotEmpty)
              ? Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount:
                        bloodBagResults == null ? 0 : donorResults.length,
                    itemBuilder: (context, index) =>
                        SearchResult(result: bloodBagResults[index]),
                  ),
                )
              : Text(""),
        ]);
  }

  void _findBlood() {
    donorResults = [];
    http.get(serverAppUrl + "/redavatar/blood/" + selectedBloodGroup,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      List<Donor> donors =
          List<Map<String, dynamic>>.from(json.decode(response.body))
              .map((Map<String, dynamic> e) => Donor.fromJson(e))
              .toList();
      donors.forEach((donor) {
        if (DonationRequestStatus.REQUESTED == donor.donationRequest.status) {
          Result result = Result(
              bloodGroup: donor.bloodGroup,
              instituteId: donor.donationRequest.donationCenter,
              latLong: LatLong(latitute: 20.305951, longitude: 85.831746));
          donorResults.add(result);
        }
      });
      setState(() {
        donorResults = donorResults;
        searched = true;
      });
    }).catchError((onError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not find any maching blood'),
      ));
    });

    http.get(serverAppUrl + "/redavatar/blockchain/" + selectedBloodGroup,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      List<BlockchainDonor> donors =
          List<Map<String, dynamic>>.from(json.decode(response.body))
              .map((e) => BlockchainDonor.fromJson(e))
              .toList();

      donors.forEach((donor) {
        donor.donationDetails
            .where((donation) => donation.bagStatus == BagStatus.APPROVED)
            .forEach((donation) {
          Result searchResult = Result(
              bloodGroup: donor.bloodGroup,
              instituteId: donation.collectedInstitute,
              latLong: LatLong(latitute: 20.305951, longitude: 85.831746));
          bloodBagResults.add(searchResult);
        });
      });

      setState(() {
        bloodBagResults = bloodBagResults;
        searched = true;
      });

      if (donorResults.isEmpty) {
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
