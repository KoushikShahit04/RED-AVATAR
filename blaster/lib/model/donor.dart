class Donor {
  String donorAadhar;
  String donorName;
  String donorEmail;
  String bloodGroup;
  String donationDate;
  String donorMobileNumber;

  Donor.create()
      : donorAadhar = null,
        donorName = null,
        donorEmail = null,
        bloodGroup = null,
        donationDate = null,
        donorMobileNumber = null;

  Donor.fromJson(Map<String, dynamic> json)
      : donorAadhar = json['donorAadhar'],
        donorName = json['donorName'],
        donorEmail = json['donorEmail'],
        bloodGroup = json['bloodGroup'],
        donationDate = json['donationDate'],
        donorMobileNumber = json['donorMobileNumber'];

  Map<String, dynamic> toJson() => {
        'donorAadhar': donorAadhar,
        'donorName': donorName,
        'donorEmail': donorEmail,
        'bloodGroup': bloodGroup,
        'donationDate': donationDate,
        'donorMobileNumber': donorMobileNumber
      };
}
