class GetAddSessionData {
  bool? success;
  List<SessionList>? data;

  GetAddSessionData({this.success, this.data});

  GetAddSessionData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SessionList>[];
      json['data'].forEach((v) {
        data!.add(new SessionList.fromJson(v));
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

class SessionList {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? cashOut;
  String? cashIn;
  String? createdAt;
  String? updatedAt;

  SessionList(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.cashOut,
        this.cashIn,
        this.createdAt,
        this.updatedAt});

  SessionList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    time = json['time'];
    cashOut = json['cash_out'];
    cashIn = json['cash_in'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['cash_out'] = this.cashOut;
    data['cash_in'] = this.cashIn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}