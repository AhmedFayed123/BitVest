import 'package:intl/intl.dart';

class AppConstant {
  static const String baseUrl = 'http://bitwest.online/api/';
  static const String kToken = 'token';

  static String currentLanguage =
  Intl.getCurrentLocale() == 'en_US' ? 'en' : 'ar';
}