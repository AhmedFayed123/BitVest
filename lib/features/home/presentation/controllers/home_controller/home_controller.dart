import 'package:get/get.dart';
import 'package:bitvest/features/home/data/models/news_model/News_model.dart';

import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../data/repos/home_repo/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo = sl<HomeRepo>();
  Rx<NewsModel?> news = Rx<NewsModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  HomeController();

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;
    final result = await homeRepo.fetchNews();

    result.fold(
          (failure) {
        isLoading.value = false;
        if (failure is ServerFailure) {
          errorMessage.value = failure.message;
        } else {
          errorMessage.value = 'An unknown error occurred';
        }
      },
          (newsData) {
        isLoading.value = false;
        news.value = newsData;
      },
    );
  }
}
