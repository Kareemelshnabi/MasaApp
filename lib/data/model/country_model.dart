class CountryMoodel {
  int? id;
  String? name;
  List<Governorates>? governorates;

  CountryMoodel({this.id, this.name, this.governorates});

  CountryMoodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['governorates'] != null) {
      governorates = <Governorates>[];
      json['governorates'].forEach((v) {
        governorates!.add(Governorates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (governorates != null) {
      data['governorates'] = governorates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Governorates {
  int? id;
  String? name;
  int? countryId;

  Governorates({this.id, this.name, this.countryId});

  Governorates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    return data;
  }
}
