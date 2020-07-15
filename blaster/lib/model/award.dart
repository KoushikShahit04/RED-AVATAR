class Award {
  String awardName;
  DateTime awardDate;
  String awardedBy;

  Award();

  Award.fromJson(Map<String, dynamic> json)
      : awardName = json['awardName'],
        awardDate = DateTime.parse(json['awardDate']),
        awardedBy = json['awardedBy'];

  Map<String, dynamic> toJson() => {
        'awardName': awardName,
        'awardDate': awardDate.toString(),
        'awardedBy': awardedBy
      };
}
