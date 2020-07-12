import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:blaster/model/donor.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DonatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final String serverAppUrl = 'http://127.0.0.1:3000/app';
  final _donateBloodFormKey = GlobalKey<FormState>();
  String _selectedBloodGroup = 'A+';
  Donor _donor = Donor.create();

  void _donateBlood() async {
    if (_donateBloodFormKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Saving...'),
      ));
      _donateBloodFormKey.currentState.save();
      developer.log('Updated Donor values: ' + _donor.toJson().toString(),
          level: DiagnosticLevel.debug.index,
          name: 'blaster.donate.category',
          time: DateTime.now());

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      await _saveData();
    }
  }

  Future _saveData() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(serverAppUrl));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(_donor)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    developer.log("Resposne from server: " + reply,
        level: DiagnosticLevel.debug.index,
        name: 'blaster.donate.category',
        time: DateTime.now());
    httpClient.close();
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
              decoration: InputDecoration(labelText: 'Aadhar Number'),
              keyboardType: TextInputType.number,
              onSaved: (String value) => _donor.donorAadhar = value,
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
              onSaved: (DateTime value) =>
                  _donor.donationDate = DateFormat('yyyy-MM-dd').format(value),
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
}
