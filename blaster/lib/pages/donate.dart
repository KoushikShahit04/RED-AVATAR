import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:blaster/model/donation.dart';
import 'package:blaster/model/donation.request.dart';
import 'package:blaster/model/donor.dart';
import 'package:blaster/model/enums.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DonatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String _donorId = "D1234";
  var donor = new Donor();
  var donationRequest = new DonationRequest();
  String serverAppUrl = 'http://10.0.2.2:3000';
  final _donateBloodFormKey = GlobalKey<FormState>();
  String _selectedBloodGroup = 'A+';

  // Text controllers
  var donorIdTextController = new TextEditingController(text: "D1234");
  var donorNameTextController = new TextEditingController();
  var mobileTextController = new TextEditingController();
  var emailTextController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _getDonorDetails(_donorId).then((value) {
      setState(() {
        donor = value;
        donor.donationRequest = donationRequest;
        donor.donationRequest.status = DonationRequestStatus.REQUESTED;
        donorIdTextController.text = donor.donorId;
        donorNameTextController.text = donor.donorName;
        mobileTextController.text = donor.donorMobileNumber;
        emailTextController.text = donor.donorEmail;
      });
    });
  }

  void _donateBlood() async {
    if (_donateBloodFormKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Saving...'),
      ));
      await _saveData();
    }
  }

  Future _saveData() async {
    _donateBloodFormKey.currentState.save();
    developer.log('Updated Donor values: ' + donor.toJson().toString(),
        level: DiagnosticLevel.debug.index,
        name: 'blaster.donate.category',
        time: DateTime.now());

    // HttpClient httpClient = new HttpClient();
    // HttpClientRequest request = await httpClient
    //     .patchUrl(Uri.parse(serverAppUrl + "/blaster/donor/" + _donor.donorId));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(_donor.toJson().toString()));
    // HttpClientResponse response = await request.close();
    // // todo - you should check the response.statusCode
    // String reply = await response.transform(utf8.decoder).join();
    http
        .patch(serverAppUrl + "/blaster/donor/" + donor.donorId,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: json.encode(donor.toJson()))
        .then((http.Response response) => {
              developer.log("Resposne from server: " + response.body,
                  level: DiagnosticLevel.debug.index,
                  name: 'blaster.donate.category',
                  time: DateTime.now()),
              donor.rev = json.decode(response.body)['rev'],
            });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _donateBloodFormKey,
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: donorNameTextController,
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (String value) => donor.donorName = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Blood Group',
                labelStyle: TextStyle(fontSize: 21.0),
              ),
              value: _selectedBloodGroup,
              items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  _selectedBloodGroup = newValue;
                });
              },
              onSaved: (String value) => donor.bloodGroup = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: DateTimeField(
              initialValue: DateTime.now(),
              decoration: InputDecoration(labelText: 'Donation Date'),
              format: DateFormat("dd-MMM-yyyy"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 1)),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              onSaved: (DateTime value) => donationRequest.donationDate = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              items: _getCenterDropdown(),
              value: donationRequest.donationCenter,
              onChanged: (value) {
                setState(() {
                  donationRequest.donationCenter = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: mobileTextController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.number,
              onSaved: (String value) => donor.donorMobileNumber = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: emailTextController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) => donor.donorEmail = value,
            ),
          ),
          RaisedButton(
            child: Text('Donate'),
            color: Theme.of(context).primaryColor,
            onPressed: _donateBlood,
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getCenterDropdown() {
    List<Map<String, String>> centers = [
      {'value': 'I1234', 'text': 'Apollo Hospital'},
      {'value': 'I1235', 'text': 'Kalinga Hospital'},
    ];
    donationRequest.donationCenter = "I1234";

    return centers
        .map((e) => DropdownMenuItem(
              value: e['value'],
              child: Text(e['text']),
            ))
        .toList();
  }

  Future<Donor> _getDonorDetails(String donorId) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .getUrl(Uri.parse(serverAppUrl + "/blaster/donor/" + donorId));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    developer.log("Donor details : " + reply,
        level: DiagnosticLevel.debug.index,
        name: 'blaster.donate.category',
        time: DateTime.now());
    httpClient.close();

    return Donor.fromJson((jsonDecode(reply) as List<dynamic>).elementAt(0));
  }
}
