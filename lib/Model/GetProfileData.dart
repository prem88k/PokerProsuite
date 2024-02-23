class GetProfileData {
  bool? success;
  List<ProfileList>? data;

  GetProfileData({this.success, this.data});

  GetProfileData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProfileList>[];
      json['data'].forEach((v) {
        data!.add(new ProfileList.fromJson(v));
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

class ProfileList {
  int? id;
  String? name;
  String? mobile;
  String? createdAt;
  String? updatedAtId;

  ProfileList({this.id, this.name, this.mobile, this.createdAt, this.updatedAtId});

  ProfileList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAtId = json['updated_at id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at id'] = this.updatedAtId;
    return data;
  }
}