import 'package:blaster/helper/helper.dart';
import 'package:blaster/model/award.dart';
import 'package:blaster/model/donation.dart';
import 'package:blaster/model/enums.dart';

class Donor {
  String donorId;
  String donorName;
  String bloodGroup;
  DonorStatus donorStatus;
  String donorMobileNumber;
  String donorEmail;
  DonorCategory donorCategory;
  String rewardPoint;
  List<Donation> donationDetails;
  List<Award> donorAwards;

  Donor(String id)
      : donorId = id,
        donorName = null,
        bloodGroup = null,
        donorStatus = null,
        donorMobileNumber = null,
        donorEmail = null,
        donorCategory = null,
        rewardPoint = null,
        donationDetails = null,
        donorAwards = null;

  Donor.fromJson(Map<String, dynamic> json)
      : donorId = json['donorId'],
        donorName = json['donorName'],
        bloodGroup = json['bloodGroup'],
        donorStatus = enumFromString(json['donorStatus'], DonorStatus.values),
        donorMobileNumber = json['donorMobileNumber'],
        donorEmail = json['donorEmail'],
        donorCategory =
            enumFromString(json['donorCategory'], DonorCategory.values),
        rewardPoint = json['rewardPoint'],
        donationDetails = (json['donationDetails'] as List<dynamic>)
            .map((e) => Donation.fromJson(e as Map<String, dynamic>))
            .toList(),
        donorAwards = (json['donorAwards'] as List<dynamic>)
            .map((e) => Award.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'donorId': donorId,
        'donorName': donorName,
        'bloodGroup': bloodGroup,
        'donorStatus': enumToString(donorStatus),
        'donorMobileNumber': donorMobileNumber,
        'donorEmail': donorEmail,
        'donorCategory': enumToString(donorCategory),
        'rewardPoint': rewardPoint,
        'donationDetails': donationDetails.map((e) => e.toJson()).toList(),
        'donorAwards': donorAwards.map((e) => e.toJson()).toList()
      };
}
