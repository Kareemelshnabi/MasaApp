class AppLinks {
  static String serverLink = "https://dashboard.almasia-online.com/app";

  //auth
  static String registerLink = "$serverLink/domains/auth/register";
  static String loginLink = "$serverLink/domains/auth/login";
  static String forgetPassLink = "$serverLink/domains/auth/reset-password";
  static String logOutLink = "$serverLink/domains/auth/logout";
  static String getCountries = "$serverLink/data/countries";
  static String verifySign = "$serverLink/domains/auth/verify-otp";
  static String reSendOtp = "$serverLink/domains/auth/resend-otp";
  static String sendOtpToREsetPassLink = "$serverLink/domains/auth/send-otp";
  static String verifyForgetPass = "$serverLink/domains/auth/verify-Phone";
  static String deletAccountLink = "$serverLink/domains/auth/delete-account";

 
  //services
  static String getServicesLink = "$serverLink/domains/product/services";

  //product
  static String getProductByCategory = "$serverLink/domains/product/products";
  //search
  static String getSearchItem = "$serverLink/domains/product/products";
  //update profile
  static String updateProfile = "$serverLink/actions/update-profile";
  //store order
  static String storeOrder = "$serverLink/domains/order/store";

  //get canceled order
  static String canceledOrder =
      "$serverLink/domains/order/orders?status=canceled";
//get pending order
  static String pendingOrder = "$serverLink/domains/order/orders";
  // get done order
  static String completedOrder =
      "$serverLink/domains/order/orders?status=completed";

//getAllOrders
  static String allOrders = "$serverLink/domains/order/orders";
  //confirm
  static String confirm = "$serverLink/domains/order/orders/";

  //cancel
  static String cancel = "$serverLink/domains/order/orders/";

  //chats
  static String getAllChats = "$serverLink/domains/chat/chats";
  static String getChatById = "$serverLink/domains/chat/chats/";
  static String sendMessageLink = "$serverLink/domains/chat/chats/";
}
