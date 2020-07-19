import 'package:blaster/helper/helper.dart';
import 'package:blaster/model/donation.dart';
import 'package:blaster/model/enums.dart';

class BlockchainDonor {
  String _id;
  String _rev;
  String donorId;
  String donorName;
  String bloodGroup;
  DonorStatus donorStatus;
  String donorMobileNumber;
  String donorEmail;
  List<Donation> donationDetails;

  BlockchainDonor();

  String get rev => _rev;
  set rev(String rev) => {this._rev = rev};

  String get id => _id;

  BlockchainDonor.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        _rev = json['_rev'],
        donorId = json['donorId'],
        donorName = json['donorName'],
        bloodGroup = json['bloodGroup'],
        donorStatus = enumFromString(json['donorStatus'], DonorStatus.values),
        donorMobileNumber = json['donorMobileNumber'],
        donorEmail = json['donorEmail'],
        donationDetails = (json['donationDetails'] as List<dynamic>)
            .map((e) => Donation.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        '_id': _id,
        '_rev': _rev,
        'donorId': donorId,
        'donorName': donorName,
        'bloodGroup': bloodGroup,
        'donorStatus': enumToString(donorStatus),
        'donorMobileNumber': donorMobileNumber,
        'donorEmail': donorEmail,
        'donationDetails': donationDetails.map((e) => e.toJson()).toList(),
      };
}
