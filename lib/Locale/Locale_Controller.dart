import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyLocaleController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    String? savedLang = box.read('lang');
    if (savedLang != null) {
      Get.updateLocale(Locale(savedLang));
    }
  }

  void changeLang(String codelang) {
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
    box.write('lang', codelang); 
  }
}
