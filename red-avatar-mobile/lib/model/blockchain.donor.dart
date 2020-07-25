import 'package:redavatar/helper/helper.dart';
import 'package:redavatar/model/donation.dart';
import 'package:redavatar/model/enums.dart';

class BlockchainDonor {
  String donorId;
  String donorName;
  String bloodGroup;
  DonorStatus donorStatus;
  String donorMobileNumber;
  String donorEmail;
  List<Donation> donationDetails;

  BlockchainDonor();

  BlockchainDonor.fromJson(Map<String, dynamic> json)
      : donorId = json['donorId'],
        donorName = json['donorName'],
        bloodGroup = json['bloodGroup'],
        donorStatus = enumFromString(json['donorStatus'], DonorStatus.values),
        donorMobileNumber = json['donorMobileNumber'],
        donorEmail = json['donorEmail'],
        donationDetails = (json['donationDetails'] as List<dynamic>)
            .map((e) => Donation.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'donorId': donorId,
        'donorName': donorName,
        'bloodGroup': bloodGroup,
        'donorStatus': enumToString(donorStatus),
        'donorMobileNumber': donorMobileNumber,
        'donorEmail': donorEmail,
        'donationDetails': donationDetails.map((e) => e.toJson()).toList(),
      };
}
