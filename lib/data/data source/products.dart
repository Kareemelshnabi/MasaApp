
import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

import '../../core/class/api.dart';

class ProductsRemoteData {
  Api api;
  ProductsRemoteData(this.api);
  getData(catId) async {
    var response = await api.getData("${AppLinks.getProductByCategory}?category_id=$catId", {"Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"});
    return response.fold((l) => l, (r) => r);
  }
getMoreProducts(token,link) async {
    var response = await api.getData(link, {
      "authorization": "Bearer $token",
    "Accept": "application/json", 
    "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }
}
