import 'package:get/get.dart';

class TradeController extends GetxController {
  var tabIndex = 0.obs;

  void setTabIndex(int index) {
    tabIndex.value = index;
  }
}
