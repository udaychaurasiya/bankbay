// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String? message;
  String? status;
  int? limit;
  int? page;
  List<CountryData> data;

  CountryModel({
    this.message,
    this.status,
    this.limit,
    this.page,
    required this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    message: json["message"],
    status: json["status"]??"",
    limit: json["limit"],
    page: json["page"],
    data: json["data"]==null?[]:List<CountryData>.from(json["data"].map((x) => CountryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "limit": limit,
    "page": page,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountryData {
  int? id;
  String? countryName;

  CountryData({
    this.id,
    this.countryName,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    id: json["id"],
    countryName: json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_name": countryName,
  };
}
