import 'package:mas_app/core/constant/api_linkes.dart';
import 'package:mas_app/main.dart';

import '../../core/class/api.dart';

class OrdersRemoteData {
  Api api;
  OrdersRemoteData(this.api);
  storeOrder(token,orderId,orderType,quantity,governorateId,lat,lng) async {
    var response = await api.postData(AppLinks.storeOrder, {
      "authorization": "Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',

       "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    },{
      "orderable_id":orderId,
      "orderable_type":orderType,
      "quantity":quantity,
      "governorate_id":governorateId,
      "user_lat":lat,
      "user_lng":lng
    });
    return response.fold((l) => l, (r) => r);
  }

  //cancel
 cancel(token,orderId) async {
    var response = await api.updateData("${AppLinks.cancel}$orderId/cancel", {
      "authorization": "Bearer $token",
       "Accept": "application/json",
             'Content-Type': 'application/json; charset=UTF-8',

        "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    },{});
    return response.fold((l) => l, (r) => r);
  }
  //confirm
 confirm(token,orderId,typeMethod) async {
    var response = await api.updateData("${AppLinks.confirm}$orderId/confirm?payment_method=$typeMethod", {
      "authorization": "Bearer $token",
       "Accept": "application/json", 
             'Content-Type': 'application/json; charset=UTF-8',

       
       "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    },{});
    return response.fold((l) => l, (r) => r);
  }


  //order canceled
 canceledOrder(token) async {
    var response = await api.getData(AppLinks.canceledOrder, {
      "authorization": "Bearer $token",
 "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"    });
    return response.fold((l) => l, (r) => r);
  }

  //pending order
   pendingOrder(token) async {
    var response = await api.getData(AppLinks.pendingOrder, {
      "authorization": "Bearer $token",
       "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }
  //order done 
    doneOrder(token) async {
    var response = await api.getData(AppLinks.completedOrder, {
      "authorization": "Bearer $token",
       "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }
  //
//all orders
   getAllOrders(token) async {
    var response = await api.getData(AppLinks.allOrders, {
      "authorization": "Bearer $token",
    "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }

  //getOrderById
   getOrderById(token,id) async {
    var response = await api.getData("${AppLinks.allOrders}/$id", {
      "authorization": "Bearer $token",
    "Accept": "application/json", "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }

getMoreOrders(token,link) async {
    var response = await api.getData(link, {
      "authorization": "Bearer $token",
    "Accept": "application/json", 
    "Accept-Language":sharedPreferences!.getString("local")=="ar"?"ar": "en"
    });
    return response.fold((l) => l, (r) => r);
  }

}
