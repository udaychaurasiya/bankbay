// To parse this JSON data, do
//
//     final profileCompleteModel = profileCompleteModelFromJson(jsonString);

import 'dart:convert';

ProfileCompleteModel profileCompleteModelFromJson(String str) => ProfileCompleteModel.fromJson(json.decode(str));

String profileCompleteModelToJson(ProfileCompleteModel data) => json.encode(data.toJson());

class ProfileCompleteModel {
  String? message;
  String? status;
  ProfileData data;

  ProfileCompleteModel({
    this.message,
    this.status,
    required this.data,
  });

  factory ProfileCompleteModel.fromJson(Map<String, dynamic> json) => ProfileCompleteModel(
    message: json["message"],
    status: json["status"],
    data: json["data"]==null?ProfileData(cmpStatus: []):ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class ProfileData {
  String? popupStatus;
  List<CmpStatus> cmpStatus;

  ProfileData({
    this.popupStatus,
    required this.cmpStatus,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    popupStatus: json["popup_status"],
    cmpStatus: List<CmpStatus>.from(json["cmp_status"].map((x) => CmpStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "popup_status": popupStatus,
    "cmp_status": List<dynamic>.from(cmpStatus.map((x) => x.toJson())),
  };
}

class CmpStatus {
  String? title;
  double? count;

  CmpStatus({
    this.title,
    this.count,
  });

  factory CmpStatus.fromJson(Map<String, dynamic> json) => CmpStatus(
    title: json["title"],
    count: json["count"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "count": count,
  };
}
