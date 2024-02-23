class GetMyGamesData {
  bool? success;
  List<GamesList>? rides;

  GetMyGamesData({this.success, this.rides});

  GetMyGamesData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['rides'] != null) {
      rides = <GamesList>[];
      json['rides'].forEach((v) {
        rides!.add(new GamesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.rides != null) {
      data['rides'] = this.rides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GamesList {
  int? id;
  String? date;
  String? address;
  String? time;

  GamesList({this.id, this.date, this.address, this.time});

  GamesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    address = json['address'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['address'] = this.address;
    data['time'] = this.time;
    return data;
  }
}