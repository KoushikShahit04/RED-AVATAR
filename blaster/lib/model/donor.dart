import 'package:blaster/helper/helper.dart';
import 'package:blaster/model/award.dart';
import 'package:blaster/model/donation.dart';
import 'package:blaster/model/enums.dart';

class Donor {
  String _id;
  String _rev;
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

  Donor();

  String get rev => _rev;

  String get id => _id;

  Donor.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        _rev = json['_rev'],
        donorId = json['donorId'],
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
        '_id': _id,
        '_rev': _rev,
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
