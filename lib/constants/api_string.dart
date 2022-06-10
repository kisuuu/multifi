// ignore_for_file: non_constant_identifier_names, camel_case_types

class API_STRING {
  //------------------------- BASE URL --------------------------------------------------------------//
  static String BASE_URL = "https://prl.xceednetdemo.com/";

  //-------------------------- Subscriber login ----------------------------------------------------------//
  static String SUBSCRIBER_LOGIN = 'api/v2/sessions/subscriber_login';
  //-------------------------- Dashboard login ----------------------------------------------------------//
  static String SUBSCRIBER_DASHBOARD = 'api/v2/subscribers/dashboard';

  //--------------------------- Location Dashboard ----------------------------------------------------------------//
  static String lOCATION_PACKAGES = 'location_packages';

  //--------------------------- ADMIN Dashboard ----------------------------------------------------------------//
  static String ADMIN_LOGIN = 'api/v2/sessions/user_login';

  //---------------------------  -------------------------------------------------------------//
  static String SUBSCRIBER_UPDATE = "subscribers/:id";

  static String SUBSCRIBER_LOCATION = "/api/v2/subscribers/location";
  static String SUBSCRIBERS = "subscribers";
  static String PAYMENT_PARAMETERS = "subscribers";

  static String TESTBASEURL = "http://cleanions.bestweb.my";
  static String TESTURL2 = "/api/location/get_city_by_state_id";
  static String TESTURL1 = "/api/location/get_state";
}
