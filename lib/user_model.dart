import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserModel {
  String lastName;
  String phoneNumber;
  String city;
  Timestamp date;
  String firstName;
  Certificate certificate;
  String curriculum;

  UserModel({
    required this.lastName,
    required this.phoneNumber,
    required this.city,
    required this.date,
    required this.firstName,
    required this.certificate,
    required this.curriculum,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    city: json["city"],
    date: json["date"],
    firstName: json["first_name"],
    certificate: Certificate.fromJson(json["certificate"]),
    curriculum: json["curriculum"],
  );

  Map<String, dynamic> toJson() => {
    "last_name": lastName,
    "phone_number": phoneNumber,
    "city": city,
    "date": date.toString(),
    "first_name": firstName,
    "certificate": certificate.toJson(),
    "curriculum": curriculum,
  };
}

class Certificate {
  String score;
  String type;

  Certificate({
    required this.score,
    required this.type,
  });

  factory Certificate.fromRawJson(String str) => Certificate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    score: json["score"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "score": score,
    "type": type,
  };
}
