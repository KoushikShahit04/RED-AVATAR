import 'package:redavatar/helper/helper.dart';
import 'package:redavatar/model/enums.dart';
import 'package:intl/intl.dart';

class DonationRequest {
  DateTime donationDate;
  String donationCenter;
  DonationRequestStatus status;

  DonationRequest({this.donationDate, this.donationCenter, this.status});

  DonationRequest.fromJson(Map<String, dynamic> json)
      : donationDate = DateFormat('yyyy-MM-dd').parse(json['donationDate']),
        donationCenter = json['donationCenter'],
        status = enumFromString(json['status'], DonationRequestStatus.values);

  Map<String, dynamic> toJson() => {
        'donationDate': DateFormat('yyyy-MM-dd').format(donationDate),
        'donationCenter': donationCenter,
        'status': enumToString(status)
      };
}
