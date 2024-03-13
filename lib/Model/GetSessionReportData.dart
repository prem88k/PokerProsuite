class GetSessionReportData {
  bool? success;
  List<All>? all;
  List<Monthly>? monthly;
  List<Yearly>? yearly;
  List<Weekly>? weekly;

  GetSessionReportData(
      {this.success, this.all, this.monthly, this.yearly, this.weekly});

  GetSessionReportData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
    if (json['monthly'] != null) {
      monthly = <Monthly>[];
      json['monthly'].forEach((v) {
        monthly!.add(new Monthly.fromJson(v));
      });
    }
    if (json['yearly'] != null) {
      yearly = <Yearly>[];
      json['yearly'].forEach((v) {
        yearly!.add(new Yearly.fromJson(v));
      });
    }
    if (json['weekly'] != null) {
      weekly = <Weekly>[];
      json['weekly'].forEach((v) {
        weekly!.add(new Weekly.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.all != null) {
      data['all'] = this.all!.map((v) => v.toJson()).toList();
    }
    if (this.monthly != null) {
      data['monthly'] = this.monthly!.map((v) => v.toJson()).toList();
    }
    if (this.yearly != null) {
      data['yearly'] = this.yearly!.map((v) => v.toJson()).toList();
    }
    if (this.weekly != null) {
      data['weekly'] = this.weekly!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class All {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? cashOut;
  String? cashIn;
  String? createdAt;
  String? updatedAt;

  All(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.cashOut,
        this.cashIn,
        this.createdAt,
        this.updatedAt});

  All.fromJson(Map<String, dynamic> json) {
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

class Monthly {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? cashOut;
  String? cashIn;
  String? createdAt;
  String? updatedAt;

  Monthly(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.cashOut,
        this.cashIn,
        this.createdAt,
        this.updatedAt});

  Monthly.fromJson(Map<String, dynamic> json) {
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

class Yearly {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? cashOut;
  String? cashIn;
  String? createdAt;
  String? updatedAt;

  Yearly(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.cashOut,
        this.cashIn,
        this.createdAt,
        this.updatedAt});

  Yearly.fromJson(Map<String, dynamic> json) {
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

class Weekly {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? cashOut;
  String? cashIn;
  String? createdAt;
  String? updatedAt;

  Weekly(
      {this.id,
        this.userId,
        this.date,
        this.time,
        this.cashOut,
        this.cashIn,
        this.createdAt,
        this.updatedAt});

  Weekly.fromJson(Map<String, dynamic> json) {
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
