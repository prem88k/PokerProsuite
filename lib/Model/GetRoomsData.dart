class GetRoomsData {
  bool? success;
  List<RoomsList>? data;

  GetRoomsData({this.success, this.data});

  GetRoomsData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <RoomsList>[];
      json['data'].forEach((v) {
        data!.add(new RoomsList.fromJson(v));
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

class RoomsList {
  int? roomId;
  int? gameId;
  int? userId;
  String? userName;
  String? groupName;

  RoomsList({this.roomId, this.gameId, this.userId, this.userName, this.groupName});

  RoomsList.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    gameId = json['game_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['game_id'] = this.gameId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['group_name'] = this.groupName;
    return data;
  }
}