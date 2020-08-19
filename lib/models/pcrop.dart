class Pcrop {
  String crop;
  DateTime cultivationdate;
  String id;

  Pcrop({this.crop, this.cultivationdate, this.id});

  Map<String, dynamic> toJson() => {
        'crop': crop,
        'cultivationdate': cultivationdate.toIso8601String(),
        'id': id,
      };

  Pcrop.fromJson(Map<dynamic, dynamic> json)
      : crop = json['crop'],
        id = json['id'],
        cultivationdate = DateTime.parse(json['cultivationdate']);
}
