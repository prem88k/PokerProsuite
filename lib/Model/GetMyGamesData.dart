class GetMyGamesData {
  bool? success;
  List<GamesList>? host;

  GetMyGamesData({this.success, this.host});

  GetMyGamesData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['host'] != null) {
      host = <GamesList>[];
      json['host'].forEach((v) {
        host!.add(new GamesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.host != null) {
      data['host'] = this.host!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GamesList {
  int? id;
  String? date;
  String? address;
  String? time;
  List<User>? user;

  GamesList({this.id, this.date, this.address, this.time, this.user});

  GamesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    address = json['address'];
    time = json['time'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['address'] = this.address;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? status;

  User({this.id, this.name, this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}