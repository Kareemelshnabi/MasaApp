class PaymentModel {
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

  PaymentModel(
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

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  Item? item;

  OrderItems({this.id, this.quantity, this.price, this.item});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    if (item != null) {
      data['item'] = item!.toJson();
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
  Null specification;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['rating'] = rating;
    data['price'] = price;
    data['image'] = image;
    data['specification'] = specification;
    return data;
  }
}
