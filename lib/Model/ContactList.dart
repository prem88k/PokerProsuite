class CategoryList {
  bool success;
  String message;
  List<CategoryData> model;

  CategoryList({this.success, this.message, this.model});

  CategoryList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['model'] != null) {
      model = new List<CategoryData>();
      json['model'].forEach((v) {
        model.add(new CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.model != null) {
      data['model'] = this.model.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String sId;
  String firstname;
  String username;
  String userId;
  String countryName;
  String countryCode;
  String dateAdded;
  String dateModify;
  int iV;

  CategoryData(
      {this.sId,
        this.firstname,
        this.username,
        this.userId,
        this.countryName,
        this.countryCode,
        this.dateAdded,
        this.dateModify,
        this.iV});

  CategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['firstname'];
    firstname = json['username'];
    userId = json['userId'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    dateAdded = json['date_added'];
    dateModify = json['date_modify'];
    iV = json['__v'];
  }
  factory CategoryData.fromMap(Map<String, dynamic> data) => CategoryData(
    sId: data['_id'],
    username: data['firstname'],
    firstname: data['username'],
    userId: data['userId'],
    countryName: data['countryName'],
    countryCode: data['countryCode'],
    dateAdded: data['date_added'],
    dateModify: data['date_modify'],
    iV: data['__v'],

  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.username;
    data['username'] = this.firstname;
    data['userId'] = this.userId;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['date_added'] = this.dateAdded;
    data['date_modify'] = this.dateModify;
    data['__v'] = this.iV;
    return data;
  }
}