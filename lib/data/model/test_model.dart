import 'dart:convert';

class TestModel{
  late List products;
  late String id;
  late String name;
  late String slug;
  TestModel({
    required this.products,required this.id,required this.name,required this.slug
});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      products: List.of(json["products"]).map((i) => json["products"]).toList(),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "products": jsonEncode(products),
      "id": id,
      "name": name,
      "slug": slug,
    };
  }
}