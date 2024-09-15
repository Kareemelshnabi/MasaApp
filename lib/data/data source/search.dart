
import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

import '../../core/class/api.dart';

class SearchRemoteData {
  Api api;
  SearchRemoteData(this.api);
  getData(searchText) async {
    var response = await api.getData("${AppLinks.getSearchItem}?q=$searchText", {"Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"});
    return response.fold((l) => l, (r) => r);
  }

}
