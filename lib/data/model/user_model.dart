class UserModel {
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
  String? token;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.address,
      this.country,
      this.governorate,
      this.lat,
      this.lng,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    country =
        json['country'] != null ?  Country.fromJson(json['country']) : null;
    governorate = json['governorate'] != null
        ?  Country.fromJson(json['governorate'])
        : null;
    lat = json['lat'];
    lng = json['lng'];
    token = json['token'];
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
    data['token'] = token;
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
