import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    this.firstname,
    this.lastname,
    this.password,
    this.username,
    this.token,
    this.id,
  });

  String? firstname;
  String? lastname;
  String? password;
  String? username;
  String? token;
  String? id;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    password: json["password"],
    username: json["username"],
    token: json["token"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "password": password,
    "username": username,
    "token": token,
    "id": id,
  };
}
