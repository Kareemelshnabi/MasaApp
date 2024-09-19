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
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
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
    data['merchant_assigned'] = merchantAssigned;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
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
  String? type;
  String? attachment;
  int? seen;
  String? sender;
  String? createdAt;

  Messages(
      {this.id,
      this.content,
      this.seen,
      this.sender,
      this.createdAt,
      this.type,
      this.attachment});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    type = json['type'];
    attachment = json['attachment'];
    seen = json['seen'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['type'] = type;
    data['attachment'] = attachment;
    data['seen'] = seen;
    data['sender'] = sender;
    data['created_at'] = createdAt;
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
    lat = json['lat'].toString();
    lng = json['lng'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
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
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['payment_method'] = paymentMethod;
    data['code'] = code;
    data['tax'] = tax;
    data['delivery_fee'] = deliveryFee;
    data['sub_total'] = subTotal;
    data['total'] = total;
    data['user_address'] = userAddress;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class OrderItems {
  int? id;
  int? quantity;
  String? price;

  OrderItems({this.id, this.quantity, this.price});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
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

  LastMessage({this.id, this.content, this.seen, this.sender, this.createdAt,this.attachment,this.type});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    type = json['type'];
    attachment = json['attachment'];
    seen = json['seen'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['type']=type;
    data['attachment']=attachment;
    data['seen'] = seen;
    data['sender'] = sender;
    data['created_at'] = createdAt;
    return data;
  }
}
