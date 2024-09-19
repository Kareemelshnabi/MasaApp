class AllChatsModel {
  int? id;
  String? name;
  int? active;
  String? createdAt;
  Client? client;
  LastMessage? lastMessage;
  String? messages;

  AllChatsModel(
      {this.id,
      this.name,
      this.active,
      this.createdAt,
      this.client,
      this.lastMessage,
      this.messages});

  AllChatsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    createdAt = json['created_at'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    messages = json['messages'];
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
    data['messages'] = messages;
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
  String? country;
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
      this.lat,
      this.lng});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    country = json['country'];
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
    data['country'] = country;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class LastMessage {
  int? id;
  String? content;
  String? type;
  String? attachment;
  int? seen;
  String? sender;
  String? createdAt;

  LastMessage(
      {this.id,
      this.content,
      this.seen,
      this.sender,
      this.createdAt,
      this.attachment,
      this.type});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    attachment = json['attachment'];
    type = json['type'];
    seen = json['seen'];
    sender = json['sender'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['seen'] = seen;
    data['attachment'] = attachment;
    data['type']=type;
    data['sender'] = sender;
    data['created_at'] = createdAt;
    return data;
  }
}
