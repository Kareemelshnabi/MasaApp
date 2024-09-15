import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

import '../../core/class/api.dart';

class ServicesRemoteData {
  Api api;
  ServicesRemoteData(this.api);
  getData() async {
    var response = await api.getData(AppLinks.getServicesLink,
        {"Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"});
    return response.fold((l) => l, (r) => r);
  }
}
