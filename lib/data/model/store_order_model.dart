import 'package:mas_app/data/model/chat_model.dart';

class StoreOrderModel {
  int? id;
  String? name;
  int? active;
  String? createdAt;
  Client? client;
  LastMessage? lastMessage;
  List<Messages>? messages;

  StoreOrderModel(
      {this.id,
      this.name,
      this.active,
      this.createdAt,
      this.client,
      this.lastMessage,
      this.messages});

  StoreOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    createdAt = json['created_at'];
    client =
        json['client'] != null ? Client.fromJson(json['client']) : null;
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active'] = active;
    data['created_at'] = createdAt;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? address;
  Country? country;
  Country? governorate;
  String? lat;
  String? lng;

  Client(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.address,
      this.country,
      this.governorate,
      this.lat,
      this.lng});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null
        ? Country.fromJson(json['governorate'])
        : null;
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['address'] = address;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (governorate != null) {
      data['governorate'] = governorate!.toJson();
    }
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LastMessage {
  int? id;
  String? content;
  int? seen;
  String? sender;
  String? createdAt;

  LastMessage({this.id, this.content, this.seen, this.sender, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    seen = json['seen'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['seen'] = seen;
    data['sender'] = sender;
    data['created_at'] = createdAt;
    return data;
  }
}
