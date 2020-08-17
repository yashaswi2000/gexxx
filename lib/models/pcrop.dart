class Pcrop {
  String crop;
  DateTime cultivationdate;

  Pcrop({this.crop, this.cultivationdate});

  Map<String, dynamic> toJson() => {
        'crop': crop,
        'cultivationdate': cultivationdate.toIso8601String(),
      };

  Pcrop.fromJson(Map<dynamic, dynamic> json)
      : crop = json['crop'],
        cultivationdate = DateTime.parse(json['cultivationdate']);
}
