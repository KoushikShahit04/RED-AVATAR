import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redavatar/model/award.dart';
import 'package:redavatar/model/blockchain.donor.dart';
import 'package:redavatar/model/donation.dart';
import 'package:redavatar/model/donor.dart';
import 'package:redavatar/widget/award_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Award> donorAwards = [];
  BlockchainDonor blockchainDonor;
  String firstDonation = "";
  String lastDonation = "";
  String totalDonations = "";

  @override
  void initState() {
    super.initState();
    _getDonorDetails().then((value) {
      setState(() {
        this.donorAwards = value.donorAwards;
      });
      _getBlockchainDonorDetails().then((value) {
        setState(() {
          this.blockchainDonor = value;
          _updateDonationDetails();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            'My Donations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  Row(
                    children: List.generate(
                        5,
                        (index) =>
                            Icon(Icons.stars, color: Colors.red, size: 40)),
                  ),
                  // Image.asset('assets/images/5-stars.jpeg', scale: 4.5),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      '80 Unit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
          Text('Platinum Donor',
              style: TextStyle(color: Colors.yellow[800], fontSize: 30),
              textAlign: TextAlign.center),
          Divider(color: Colors.black),
          Text(
            "Awards",
            textAlign: TextAlign.center,
          ),
          Container(
              height: 300,
              child: (this.donorAwards.isNotEmpty)
                  ? ListView.builder(
                      itemCount: this.donorAwards.length,
                      itemBuilder: (context, index) =>
                          AwardWidget(award: this.donorAwards[index]))
                  : Text("Loading")),
          Divider(color: Colors.black),
          Container(
            width: 150,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.tint,
                    color: Colors.red,
                    size: 60,
                  ),
                  // Image.asset('assets/images/blood_drop.png', scale: 2.0),
                  Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('1st Donation - ' + this.firstDonation),
                            Text('Last Donation - ' + this.lastDonation),
                            Text('Total Units - ' + this.totalDonations)
                          ]))
                ]),
          ),
        ],
      ),
    );
  }

  Future<Donor> _getDonorDetails() async {
    http.Response resp =
        await http.get("http://10.0.2.2:8888/redavatar/donor/D1234");
    return Donor.fromJson(json.decode(resp.body));
  }

  Future<BlockchainDonor> _getBlockchainDonorDetails() async {
    http.Response resp =
        await http.get("http://10.0.2.2:8888/redavatar/blockchain/donor/D1234");
    return BlockchainDonor.fromJson(json.decode(resp.body));
  }

  String _updateDonationDetails() {
    if (this.blockchainDonor != null) {
      this.blockchainDonor.donationDetails.sort(
          (Donation a, Donation b) => a.donationDate.compareTo(b.donationDate));

      setState(() {
        this.firstDonation = DateFormat("yyyy")
            .format(this.blockchainDonor.donationDetails[0].donationDate);
        this.totalDonations =
            this.blockchainDonor.donationDetails.length.toString();
        this.lastDonation = DateFormat("yyyy-MM-dd").format(this
            .blockchainDonor
            .donationDetails[this.blockchainDonor.donationDetails.length - 1]
            .donationDate);
      });
    }
    return "1999";
  }
}
