//function use to handle status request


import '../class/status_request.dart';

handlingData(response) {
  if (response is StatuesRequest) {
    return response;
  } else {
    return StatuesRequest.success;
  }
}
