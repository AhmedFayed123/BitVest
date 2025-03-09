import 'package:bitvest/features/market/data/repos/market_repo/market_repo.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/favourites_model/Favourites_Data.dart';
import '../../data/models/market_model/Market_model.dart';

class MarketController extends GetxController {
  final MarketRepo marketRepo = sl<MarketRepo>();

  var isLoading = false.obs;
  var marketData = <CoinModel>[].obs;
  var newData = <CoinModel>[].obs;
  RxList<FavouritesData> favouritesData = RxList<FavouritesData>();

  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoinsList();
    fetchNewList();
    fetchFavouritesList();
  }


  Future<void> refreshData() async {
    errorMessage.value = '';

      await fetchCoinsList();
      await fetchNewList();
      await fetchFavouritesList();

  }

  Future<void> fetchCoinsList() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final result = await marketRepo.getCoinsList();
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (marketModel) {
          print(marketModel);
          marketData.value = marketModel.coins;
        },
      );
    } catch (e) {
      errorMessage.value = "Error loading coins list: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNewList() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final result = await marketRepo.getNewList();
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (marketModel) {
          newData.value = marketModel.coins;
        },
      );
    } catch (e) {
      errorMessage.value = "Error fetching new list: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFavouritesList() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final result = await marketRepo.getFavouriteList();
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          print("❌ Error fetchFavouritesList: ${failure.message}");
        },
        (marketModel) {
          print("trueeeeee: ${marketModel.data}");

          favouritesData.assignAll(marketModel.data ?? []);
        },
      );
    } catch (e) {
      errorMessage.value = "Error loading favourites list: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
