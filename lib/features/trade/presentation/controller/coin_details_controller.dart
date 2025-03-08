import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/Coin_data_model.dart';
import '../../data/repos/trade_repo.dart';

class CoinDetailsController extends GetxController {
  final TradeRepo tradeRepo = sl<TradeRepo>();
  final String coinId;

  CoinDetailsController(this.coinId);

  var isLoading = true.obs;
  var coinData = Rxn<CoinDataModel>();
  var selectedPeriod = '7D'.obs;

  Future<void> fetchCoinDetails() async {
    try {
      isLoading.value = true;
      final result = await tradeRepo.getCoinDetails(coinId);
      result.fold(
            (failure) {
          Get.snackbar("Error", failure.message);
        },
            (data) {
          coinData.value = data;
          update();
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
  List<List<dynamic>>? get selectedChartData {
    switch (selectedPeriod.value) {
      case '7D':
        return coinData.value?.original?.chartData?.sevenDays
            ?.map((e) => [e.timestamp, e.price])
            .toList();
      case '30D':
        return coinData.value?.original?.chartData?.thirtyDays
            ?.map((e) => [e.timestamp, e.price])
            .toList();
      case '90D':
        return coinData.value?.original?.chartData?.ninetyDays
            ?.map((e) => [e.timestamp, e.price])
            .toList();
      default:
        return null;
    }
  }



  void changePeriod(String period) {
    selectedPeriod.value = period;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCoinDetails();
  }
}
