import 'package:get/get.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../data/models/ads_model/Ads.dart';
import '../../../data/models/coins_list/Coin_list_model.dart';
import '../../../data/models/news_model/News_model.dart';
import '../../../data/models/notifications_model/notifications_response.dart';
import '../../../data/models/popular_coins_model/Popular_coins_model.dart';
import '../../../data/models/search_model/Search_model.dart';
import '../../../data/repos/home_repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo = sl<HomeRepo>();

  // DATA MODELS
  Rx<NewsModel?> news = Rx<NewsModel?>(null);
  Rxn<PopularCoinsModel> popularCoins = Rxn<PopularCoinsModel>();
  Rxn<CoinsListModel> highestVolume = Rxn<CoinsListModel>();
  Rxn<CoinsListModel> highestChangeUp = Rxn<CoinsListModel>();
  Rxn<CoinsListModel> highestChangeDown = Rxn<CoinsListModel>();
  Rxn<List<Ads>> adsList = Rxn<List<Ads>>();
  RxList<SearchModel> searchResults = <SearchModel>[].obs;
  Rxn<NotificationsResponse> notifications = Rxn<NotificationsResponse>();

  // UI STATE
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    errorMessage.value = '';

    await Future.wait([
      fetchPopularList(),
      fetchHighestVolumeList(),
      fetchHighestChangeDownList(),
      fetchHighestChangeUpList(),
      fetchAds(),
      fetchNews(),
      fetchNotifications(),
    ]);

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await fetchAllData();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    isLoading.value = true;
    errorMessage.value = '';

    final result = await homeRepo.search(query);
    result.fold(
          (failure) {
        errorMessage.value = _getErrorMessage(failure);
        searchResults.clear();
      },
          (data) {
        searchResults.value = data;
      },
    );

    isLoading.value = false;
  }

  Future<void> fetchAds() async {
    try {
      final result = await homeRepo.fetchAds();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (ads) => adsList.value = ads.ads,
      );
    } catch (e) {
      errorMessage.value = "Error loading ads: ${e.toString()}";
    }
  }

  Future<void> fetchNews() async {
    try {
      final result = await homeRepo.fetchNews();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (newsData) => news.value = newsData,
      );
    } catch (e) {
      errorMessage.value = "Error loading news: ${e.toString()}";
    }
  }

  Future<void> fetchPopularList() async {
    try {
      final result = await homeRepo.fetchPopular();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (popularCoinsModel) => popularCoins.value = popularCoinsModel,
      );
    } catch (e) {
      errorMessage.value = "Error loading popular coins: ${e.toString()}";
    }
  }

  Future<void> fetchHighestVolumeList() async {
    try {
      final result = await homeRepo.fetchHighestVolume();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (coinsListModel) => highestVolume.value = _validateCoinsList(coinsListModel),
      );
    } catch (e) {
      errorMessage.value = "Error loading highest volume: ${e.toString()}";
    }
  }

  Future<void> fetchHighestChangeDownList() async {
    try {
      final result = await homeRepo.fetchHighestChangeDown();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (coinsListModel) => highestChangeDown.value = _validateCoinsList(coinsListModel),
      );
    } catch (e) {
      errorMessage.value = "Error loading highest change down: ${e.toString()}";
    }
  }

  Future<void> fetchHighestChangeUpList() async {
    try {
      final result = await homeRepo.fetchHighestChangeUp();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (coinsListModel) => highestChangeUp.value = _validateCoinsList(coinsListModel),
      );
    } catch (e) {
      errorMessage.value = "Error loading highest change up: ${e.toString()}";
    }
  }

  Future<void> fetchNotifications() async {
    try {
      final result = await homeRepo.fetchNotification();
      result.fold(
            (failure) => errorMessage.value = _getErrorMessage(failure),
            (notificationsData) => notifications.value = notificationsData,
      );
    } catch (e) {
      errorMessage.value = "Error loading notifications: ${e.toString()}";
    }
  }

  String _getErrorMessage(dynamic failure) {
    return (failure is ServerFailure)
        ? failure.message
        : 'An unknown error occurred';
  }

  CoinsListModel? _validateCoinsList(CoinsListModel coinsListModel) {
    return coinsListModel.coins.isEmpty ? null : coinsListModel;
  }
}
