import 'dart:developer';

class MessageModel {
  int id;
  int from;
  int to;
  int tripId;
  String content;

  MessageModel({this.id, this.from, this.to, this.tripId, this.content});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      id = 0;
    } else {
      id = json['id'];
    }
    from = int.parse(json['from'].toString());
    to = int.parse(json['to'].toString());
    if (json["tripId"] != null) {
      tripId = int.parse(json['tripId'].toString());
    } else {
      tripId = int.parse(json['trip_id'].toString());
    }
    content = json['content'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['trip_id'] = this.tripId;
    data['content'] = this.content;
    return data;
  }
}
