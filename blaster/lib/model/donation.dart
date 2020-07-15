import 'package:blaster/helper/helper.dart';
import 'package:blaster/model/enums.dart';

class Donation {
  String bagId;
  String donationDate;
  BagStatus bagStatus;
  String collectedInstitute;

  Donation();

  Donation.fromJson(Map<String, dynamic> json)
      : bagId = json['bagId'],
        donationDate = json['donationDate'],
        bagStatus = enumFromString(json['bagStatus'], BagStatus.values),
        collectedInstitute = json['collectedInstitute'];

  Map<String, dynamic> toJson() => {
        'bagId': bagId,
        'donationDate': donationDate.toString(),
        'bagStatus': enumToString(bagStatus),
        'collectedInstitute': collectedInstitute
      };
}
