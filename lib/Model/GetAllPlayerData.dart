class GetAllPlayerData {
  bool? success;
  List<PlayerList>? data;

  GetAllPlayerData({this.success, this.data});

  GetAllPlayerData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PlayerList>[];
      json['data'].forEach((v) {
        data!.add(new PlayerList.fromJson(v));
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

class PlayerList {
  int? id;
  String? name;
  String? mobile;
  Null? deviceId;
  int? stripePaymentId;
  int? stripeCusId;
  Null? platform;
  String? fcmKey;
  String? profileimage;
  int? otp;
  int? notiCount;
  String? createdAt;
  String? updatedAt;

  PlayerList(
      {this.id,
        this.name,
        this.mobile,
        this.deviceId,
        this.stripePaymentId,
        this.stripeCusId,
        this.platform,
        this.fcmKey,
        this.profileimage,
        this.otp,
        this.notiCount,
        this.createdAt,
        this.updatedAt});

  PlayerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    deviceId = json['device_id'];
    stripePaymentId = json['stripe_payment_id'];
    stripeCusId = json['stripe_cus_id'];
    platform = json['platform'];
    fcmKey = json['fcm_key'];
    profileimage = json['profileimage'];
    otp = json['otp'];
    notiCount = json['noti_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['device_id'] = this.deviceId;
    data['stripe_payment_id'] = this.stripePaymentId;
    data['stripe_cus_id'] = this.stripeCusId;
    data['platform'] = this.platform;
    data['fcm_key'] = this.fcmKey;
    data['profileimage'] = this.profileimage;
    data['otp'] = this.otp;
    data['noti_count'] = this.notiCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}