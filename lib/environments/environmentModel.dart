class EnvironmentModel {
  EnvironmentModel(
      {this.uuid,
      this.name,
      this.username,
      this.profileImage,
      this.email,
      this.phoneNumber,
      this.token});

  String? uuid;
  String? name;
  String? username;
  String? profileImage;
  String? email;
  String? phoneNumber;
  String? token;

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) =>
      EnvironmentModel(
          uuid: json["uuid"],
          name: json["name"],
          username: json["username"],
          profileImage: json["profileImage"],
          email: json["email"],
          // ignore: prefer_null_aware_operators
          phoneNumber: json["phoneNumber"] == null
              ? null
              : json["phoneNumber"].toString(),
          token: json["token"],
         );
}
