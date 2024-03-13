class GetNotificationData {
  bool? success;
  List<NotificationList>? data;

  GetNotificationData({this.success, this.data});

  GetNotificationData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <NotificationList>[];
      json['data'].forEach((v) {
        data!.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String? message;
  int? gameId;
  int? userId;
  String? date;
  String? time;
  String? address;
  int? status;

  NotificationList(
      {this.message,
        this.gameId,
        this.userId,
        this.date,
        this.time,
        this.address,
        this.status});

  NotificationList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    gameId = json['game_id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['game_id'] = this.gameId;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }
}