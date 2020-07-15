import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:blaster/model/donation.dart';
import 'package:blaster/model/donor.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DonatePage extends StatefulWidget {
  final String donorId;
  const DonatePage({this.donorId});

  @override
  State<StatefulWidget> createState() => _DonatePageState(this.donorId);
}

class _DonatePageState extends State<DonatePage> {
  String donorId;
  Donor _donor;
  String serverAppUrl = 'http://10.0.2.2:3000';
  final _donateBloodFormKey = GlobalKey<FormState>();
  String _selectedBloodGroup = 'A+';

  _DonatePageState(this.donorId) {
    _donor = Donor(donorId);
    _getDonorDetails(this.donorId).then((Donor value) => {
          _donor = value,
          _donor.donationDetails.add(Donation()),
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
    developer.log('Updated Donor values: ' + _donor.toJson().toString(),
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
        .patch(serverAppUrl + "/blaster/donor/" + _donor.donorId,
            headers: {"Content-Type": "text/plain"},
            body: jsonEncode(_donor.toJson()))
        .then((http.Response response) => developer.log(
            "Resposne from server: " + response.body,
            level: DiagnosticLevel.debug.index,
            name: 'blaster.donate.category',
            time: DateTime.now()));
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
              initialValue: _donor.donorId,
              decoration: InputDecoration(labelText: 'Donor Id'),
              keyboardType: TextInputType.number,
              enabled: false,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (String value) => _donor.donorName = value,
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
              onSaved: (String value) => _donor.bloodGroup = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: DateTimeField(
              decoration: InputDecoration(labelText: 'Donation Date'),
              format: DateFormat("dd-MMM-yyyy"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 1)),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              onSaved: (DateTime value) => _donor.donationDetails[0]
                  .donationDate = DateFormat('yyyy-MM-dd').format(value),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.number,
              onSaved: (String value) => _donor.donorMobileNumber = value,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) => _donor.donorEmail = value,
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
