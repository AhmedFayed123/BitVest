import 'package:get/get.dart';

class SwapController extends GetxController {
  var sendCurrency = "BTC".obs;
  var receiveCurrency = "ETH".obs;

  var sendAmount = 0.8.obs;
  var receiveAmount = 12.190.obs;

  var sendBalance = 0.09681609.obs;
  var receiveBalance = 0.00821543.obs;

  final currencies = ["BTC", "ETH", "USDT", "BNB"].obs;

  void swapCurrencies() {
    var temp = sendCurrency.value;
    sendCurrency.value = receiveCurrency.value;
    receiveCurrency.value = temp;

    sendAmount.value = 0.0;
    receiveAmount.value = 0.0;
  }
}
