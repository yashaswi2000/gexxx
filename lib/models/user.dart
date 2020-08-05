class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class UserData {
  final String uid;
  final String name;
  String email;
  final String phonenumber;
  String state;
  int statenumber;
  String age;
  String district;
  String village;
  String gender;
  String image;
  String language;
  String languagecode;
  List<String> favouritecrops;
  UserData(
      {this.uid,
      this.name,
      this.email,
      this.statenumber,
      this.phonenumber,
      this.age,
      this.state,
      this.district,
      this.village,
      this.gender,
      this.image,
      this.language,
      this.languagecode,
      this.favouritecrops});
}
