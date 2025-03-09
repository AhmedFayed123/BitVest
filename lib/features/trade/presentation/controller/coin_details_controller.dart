import 'package:get/get.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/models/Coin_data_model.dart';
import '../../data/repos/trade_repo.dart';

class CoinDetailsController extends GetxController {
  final TradeRepo tradeRepo = sl<TradeRepo>();

  var coinId = ''.obs;
  var isLoading = false.obs;
  var coinData = Rxn<CoinDataModel>();
  var selectedPeriod = '7D'.obs;

  Future<void> fetchCoinDetails() async {
    if (coinId.value.isEmpty || isLoading.value) return;
    try {
      isLoading.value = true;
      update();

      final result = await tradeRepo.getCoinDetails(coinId.value);
      result.fold(
            (failure) => Get.snackbar("Error", failure.message),
            (data) {
          coinData.value = data;
          update();
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> refreshData() async {
    if (isLoading.value) return;
    await fetchCoinDetails();
  }

  void changeCoin(String newCoinId) {
    if (coinId.value != newCoinId) {
      coinId.value = newCoinId;
      fetchCoinDetails();
    }
  }

  List<List<dynamic>>? get selectedChartData {
    final chart = coinData.value?.original?.chartData;
    if (chart == null) return null;

    switch (selectedPeriod.value) {
      case '7D':
        return chart.sevenDays?.map((e) => [e.timestamp, e.price]).toList();
      case '30D':
        return chart.thirtyDays?.map((e) => [e.timestamp, e.price]).toList();
      case '90D':
        return chart.ninetyDays?.map((e) => [e.timestamp, e.price]).toList();
      default:
        return null;
    }
  }

  void changePeriod(String period) {
    if (selectedPeriod.value != period) {
      selectedPeriod.value = period;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (coinId.value.isNotEmpty) {
      fetchCoinDetails();
    }
  }
}
