class GetMessageData {
  bool? success;
  List<MessageList>? data;

  GetMessageData({this.success, this.data});

  GetMessageData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MessageList>[];
      json['data'].forEach((v) {
        data!.add(new MessageList.fromJson(v));
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

class MessageList {
  int? senderId;
  String? senderName;
  String? message;
  String? createdAt;
  String? updatedAtId;

  MessageList(
      {this.senderId,
        this.senderName,
        this.message,
        this.createdAt,
        this.updatedAtId});

  MessageList.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAtId = json['updated_at id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['sender_name'] = this.senderName;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at id'] = this.updatedAtId;
    return data;
  }
}