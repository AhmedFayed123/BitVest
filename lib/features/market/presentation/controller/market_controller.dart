import 'package:bitvest/features/market/data/repos/market_repo/market_repo.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/market_model/Market_model.dart';

class MarketController extends GetxController {
  final MarketRepo marketRepo = sl<MarketRepo>();

  var isLoading = true.obs;
  var marketData = <CoinModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoinsList();
  }

  Future<void> fetchCoinsList() async {

    isLoading.value = true;
    final result = await marketRepo.getCoinsList();

    result.fold(
          (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
        print("Fetching coins list...");

          },
          (marketModel) {
            marketData.value = marketModel.coins;
        isLoading.value = false;

          },
    );
  }
}
