// ignore_for_file: prefer_collection_literals

class CategoriesModel {
  int? id;
  String? name;
  String? image;
  String? description;

  CategoriesModel({this.id, this.name, this.image, this.description});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
