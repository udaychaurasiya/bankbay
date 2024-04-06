// To parse this JSON data, do
//
//     final myEarningsModel = myEarningsModelFromJson(jsonString);

import 'dart:convert';

MyEarningsModel myEarningsModelFromJson(String str) => MyEarningsModel.fromJson(json.decode(str));

String myEarningsModelToJson(MyEarningsModel data) => json.encode(data.toJson());

class MyEarningsModel {
  String? message;
  String? status;
  List<Datum> data;

  MyEarningsModel({
    this.message,
    this.status,
    required this.data,
  });

  factory MyEarningsModel.fromJson(Map<String, dynamic> json) => MyEarningsModel(
    message: json["message"],
    status: json["status"],
    data: json["data"]==null?[]:List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? loanId;
  String? leadId;
  String? userId;
  String? amount;
  String? status;
  String? datetime;

  Datum({
    this.id,
    this.loanId,
    this.leadId,
    this.userId,
    this.amount,
    this.status,
    this.datetime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    loanId: json["loan_id"],
    leadId: json["lead_id"],
    userId: json["user_id"],
    amount: json["amount"],
    status: json["status"],
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loan_id": loanId,
    "lead_id": leadId,
    "user_id": userId,
    "amount": amount,
    "status": status,
    "datetime": datetime,
  };
}
