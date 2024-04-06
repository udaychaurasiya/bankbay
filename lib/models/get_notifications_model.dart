import 'dart:convert';

GetNotificationsModel getNotificationsModelFromJson(String str) => GetNotificationsModel.fromJson(json.decode(str));

String getNotificationsModelToJson(GetNotificationsModel data) => json.encode(data.toJson());

class GetNotificationsModel {
  String? message;
  String? status;
  List<NotificationsData> data;

  GetNotificationsModel({
    this.message,
    this.status,
    required this.data,
  });

  factory GetNotificationsModel.fromJson(Map<String, dynamic> json) => GetNotificationsModel(
    message: json["message"],
    status: json["status"],
    data: json["data"]==null?[]:List<NotificationsData>.from(json["data"].map((x) => NotificationsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationsData {
  dynamic id;
  dynamic userId;
  String? title;
  String? subject;
  String? message;
  String? isRead;
  String? datetime;

  NotificationsData({
    this.id,
    this.userId,
    this.title,
    this.subject,
    this.message,
    this.isRead,
    this.datetime,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) => NotificationsData(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    subject: json["subject"],
    message: json["message"],
    isRead: json["is_read"],
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "subject": subject,
    "message": message,
    "is_read": isRead,
    "datetime": datetime,
  };
}
