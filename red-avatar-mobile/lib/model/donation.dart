import 'package:redavatar/helper/helper.dart';
import 'package:redavatar/model/enums.dart';
import 'package:intl/intl.dart';

class Donation {
  String bagId;
  DateTime donationDate;
  BagStatus bagStatus;
  String collectedInstitute;

  Donation({this.bagId, this.bagStatus});

  Donation.fromJson(Map<String, dynamic> json)
      : bagId = json['bagId'],
        donationDate = DateFormat('yyyy-MM-dd').parse(json['donationDate']),
        bagStatus = enumFromString(json['bagStatus'], BagStatus.values),
        collectedInstitute = json['collectedInstitute'];

  Map<String, dynamic> toJson() => {
        'bagId': bagId,
        'donationDate': DateFormat('yyyy-MM-dd').format(donationDate),
        'bagStatus': enumToString(bagStatus),
        'collectedInstitute': collectedInstitute
      };
}
