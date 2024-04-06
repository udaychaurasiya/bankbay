// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  String? message;
  String? status;
  List<StateData> data;

  StateModel({
    this.message,
    this.status,
    required this.data,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    message: json["message"],
    status: json["status"],
    data: List<StateData>.from(json["data"].map((x) => StateData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StateData {
  int? id;
  String? countryId;
  String? stateName;
  String? isStatus;
  String? datetime;

  StateData({
    this.id,
    this.countryId,
    this.stateName,
    this.isStatus,
    this.datetime,
  });

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
    id: json["id"],
    countryId: json["country_id"],
    stateName: json["state_name"],
    isStatus: json["is_status"],
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "state_name": stateName,
    "is_status": isStatus,
    "datetime": datetime,
  };
}
