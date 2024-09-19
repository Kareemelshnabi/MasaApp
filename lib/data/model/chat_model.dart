import 'package:mas_app/data/model/order_model.dart';

class ChatModel {
  int? id;
  String? name;
  int? active;
  String? createdAt;
  bool? merchantAssigned;
  Client? client;
  OrderModel? order;
  LastMessage? lastMessage;
  List<Messages>? messages;

  ChatModel(
      {this.id,
      this.name,
      this.active,
      this.createdAt,
      this.merchantAssigned,
      this.client,
      this.order,
      this.lastMessage,
      this.messages});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    createdAt = json['created_at'];
    merchantAssigned = json['merchant_assigned'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    order = json['order'] != null ? new OrderModel.fromJson(json['order']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['merchant_assigned'] = this.merchantAssigned;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Messages {
  int? id;
  String? content;
  int? seen;
  String? type;
  String? attachment;
  String? sender;
  String? createdAt;

  Messages(
      {this.id,
      this.content,
      this.seen,
      this.type,
      this.attachment,
      this.sender,
      this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    seen = json['seen'];
    type = json['type'];
    attachment = json['attachment'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['seen'] = this.seen;
    data['type'] = this.type;
    data['attachment'] = this.attachment;
    data['sender'] = this.sender;
    data['created_at'] = this.createdAt;
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
  String? lat;
  String? lng;

  Client(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.address,
      this.lat,
      this.lng});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Order {
  int? id;
  String? status;
  String? paymentMethod;
  String? code;
  String? tax;
  String? deliveryFee;
  String? subTotal;
  String? total;
  String? userAddress;
  List<OrderItems>? orderItems;
  String? createdAt;

  Order(
      {this.id,
      this.status,
      this.paymentMethod,
      this.code,
      this.tax,
      this.deliveryFee,
      this.subTotal,
      this.total,
      this.userAddress,
      this.orderItems,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    paymentMethod = json['payment_method'];
    code = json['code'];
    tax = json['tax'];
    deliveryFee = json['delivery_fee'];
    subTotal = json['sub_total'];
    total = json['total'];
    userAddress = json['user_address'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['payment_method'] = this.paymentMethod;
    data['code'] = this.code;
    data['tax'] = this.tax;
    data['delivery_fee'] = this.deliveryFee;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['user_address'] = this.userAddress;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class OrderItems {
  int? id;
  int? quantity;
  String? price;
  Item? item;

  OrderItems({this.id, this.quantity, this.price, this.item});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? description;
  int? rating;
  String? price;
  String? image;
  Null? specification;

  Item(
      {this.id,
      this.name,
      this.description,
      this.rating,
      this.price,
      this.image,
      this.specification});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    rating = json['rating'];
    price = json['price'];
    image = json['image'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['image'] = this.image;
    data['specification'] = this.specification;
    return data;
  }
}

class LastMessage {
  int? id;
  String? content;
  int? seen;
  String? type;
  String? attachment;
  String? sender;
  String? createdAt;

  LastMessage(
      {this.id,
      this.content,
      this.seen,
      this.type,
      this.attachment,
      this.sender,
      this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    seen = json['seen'];
    type = json['type'];
    attachment = json['attachment'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['seen'] = this.seen;
    data['type'] = this.type;
    data['attachment'] = this.attachment;
    data['sender'] = this.sender;
    data['created_at'] = this.createdAt;
    return data;
  }
}
