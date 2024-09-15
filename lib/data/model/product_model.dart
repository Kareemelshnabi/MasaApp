class ProductModel {
  int? id;
  String? name;
  String? description;
  String? brand;
  List<String>? images;
  String? price;
  int? discountValue;
  String? discountType;
  String? priceAfterDiscount;
  int? rating;
  int? ratingCount;
  List<Details>? details;
  String? freeDeliveryStartDate;
  String? freeDeliveryEndDate;
  List<Specifications>? specifications;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.brand,
      this.images,
      this.price,
      this.discountValue,
      this.discountType,
      this.priceAfterDiscount,
      this.rating,
      this.ratingCount,
      this.details,
      this.freeDeliveryStartDate,
      this.freeDeliveryEndDate,
      this.specifications});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brand = json['brand'];
    images = json['images'].cast<String>();
    price = json['price'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    priceAfterDiscount = json['price_after_discount'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    freeDeliveryStartDate = json['free_delivery_start_date'];
    freeDeliveryEndDate = json['free_delivery_end_date'];
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(Specifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['brand'] = brand;
    data['images'] = images;
    data['price'] = price;
    data['discount_value'] = discountValue;
    data['discount_type'] = discountType;
    data['price_after_discount'] = priceAfterDiscount;
    data['rating'] = rating;
    data['rating_count'] = ratingCount;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['free_delivery_start_date'] = freeDeliveryStartDate;
    data['free_delivery_end_date'] = freeDeliveryEndDate;
    if (specifications != null) {
      data['specifications'] =
          specifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? key;
  String? value;

  Details({this.key, this.value});

  Details.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class Specifications {
  int? id;
  String? image;
  String? title;
  String? price;
  String? priceAfterDiscount;
  int? available;

  Specifications(
      {this.id,
      this.image,
      this.title,
      this.price,
      this.priceAfterDiscount,
      this.available});

  Specifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['price_after_discount'] = priceAfterDiscount;
    data['available'] = available;
    return data;
  }
}
