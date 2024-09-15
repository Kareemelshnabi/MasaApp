// class ChatModel {
//   int? id;
//   String? name;
//   int? active;
//   String? createdAt;
//   Client? client;
//   LastMessage? lastMessage;
//   List<Messages>? messages;

//   ChatModel(
//       {this.id,
//       this.name,
//       this.active,
//       this.createdAt,
//       this.client,
//       this.lastMessage,
//       this.messages});

//   ChatModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     active = json['active'];
//     createdAt = json['created_at'];
//     client =
//         json['client'] != null ? new Client.fromJson(json['client']) : null;
//     lastMessage = json['last_message'] != null
//         ? new LastMessage.fromJson(json['last_message'])
//         : null;
//     if (json['messages'] != null) {
//       messages = <Messages>[];
//       json['messages'].forEach((v) {
//         messages!.add(new Messages.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['active'] = this.active;
//     data['created_at'] = this.createdAt;
//     if (this.client != null) {
//       data['client'] = this.client!.toJson();
//     }
//     if (this.lastMessage != null) {
//       data['last_message'] = this.lastMessage!.toJson();
//     }
//     if (this.messages != null) {
//       data['messages'] = this.messages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Client {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   String? address;
//   String? country;
//   String? lat;
//   String? lng;

//   Client(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.image,
//       this.address,
//       this.country,
//       this.lat,
//       this.lng});

//   Client.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     address = json['address'];
//     country = json['country'];
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }

// class LastMessage {
//   int? id;
//   String? content;
//   int? seen;
//   //Client? sender;
//   String? createdAt;

//   LastMessage({this.id, this.content, this.seen, this.createdAt});

//   LastMessage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     content = json['content'];
//     seen = json['seen'];
//     // sender =
//     //     json['sender'] != null ? new Client.fromJson(json['sender']) : null;
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['content'] = this.content;
//     data['seen'] = this.seen;
//     // if (this.sender != null) {
//     //   data['sender'] = this.sender!.toJson();
//     // }
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

// class Messages {
//   int? id;
//   String? content;
//   int? seen;
//   Sender? sender;
//   String? createdAt;

//   Messages({this.id, this.content, this.seen, this.createdAt});

//   Messages.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     content = json['content'];
//     seen = json['seen'];
//     if (this.sender != null) {
//       json['sender'] = this.sender!.toJson();
//     }
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['content'] = this.content;
//     data['seen'] = this.seen;

//     data['sender'] = this.sender;

//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
// class Sender {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   String? address;
//   String? country;
//   int? lat;
//   int? lng;

//   Sender(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.image,
//       this.address,
//       this.country,
//       this.lat,
//       this.lng});

//   Sender.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     address = json['address'];
//     country = json['country'];
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }
class ChatModel {
  int? id;
  String? name;
  String? merchantAssigned;
  int? active;
  String? createdAt;
  Client? client;
  LastMessage? lastMessage;
  List<Messages>? messages;

  ChatModel(
      {this.id,
      this.name,
      this.active,
      this.merchantAssigned,
      this.createdAt,
      this.client,
      this.lastMessage,
      this.messages});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    merchantAssigned = json['merchant_assigned'].toString();
    active = json['active'];
    createdAt = json['created_at'];

    client = json['client'] != null ? Client.fromJson(json['client']) : null;
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
    data['merchant_assigned'] = merchantAssigned.toString();
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

class Messages {
  int? id;
  String? content;
  int? seen;
  String? sender;
  String? createdAt;

  Messages({this.id, this.content, this.seen, this.sender, this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
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

// class Sender {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   String? address;
//   String? country;
//   String? lat;
//   String? lng;

//   Sender(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.image,
//       this.address,
//       this.country,
//       this.lat,
//       this.lng});

//   Sender.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     address = json['address'];
//     country = json['country'];
//     lat = json['lat'].toString();
//     lng = json['lng'].toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }

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
