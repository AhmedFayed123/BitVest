
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/server_failures.dart';
import '../../data/models/accept_ad_model/Accept_ad_model.dart';
import '../../data/models/edit/edit_request/Edit_request.dart';
import '../../data/models/get_ads_model/Data.dart';
import '../../data/models/p2p_ad_response/P2p_ad_response.dart';
import '../../data/models/p2p_request/P2p_request.dart';
import '../../data/repo/p2p_repo_impl.dart';
import '../views/widgets/trade_confirmation_screen.dart';

class P2pController extends GetxController {
  final RxBool isBuying = true.obs;
  final RxString selectedPayment = 'Bank Transfer'.obs;
  final RxString selectedCurrency = 'USDT'.obs;
  final RxBool isAdPosting = false.obs;
  final RxString amount = ''.obs;
  final RxString price = ''.obs;
  final RxList<AdsData> filteredTraders = <AdsData>[].obs;
  final RxList<AdsData> userBuyAds = <AdsData>[].obs;
  final RxList<AdsData> userSellAds = <AdsData>[].obs;
  final RxString paymentDetails = ''.obs;
  final List<String> availablePayments = ['All', 'Bank Transfer', 'Vodafone Cash', 'Orange Cash'];
  final List<String> postAdPayments = ['Bank Transfer', 'Vodafone Cash', 'Orange Cash'];
  final List<String> currencies = ['USDT', 'BTC', 'ETH'];
  final RxBool isEditingAd = false.obs;

  var tradeAmount = ''.obs;
  var paymentProofUrl = ''.obs;

  final P2pRepoImpl _repo = P2pRepoImpl();

  // أصل الإعلانات اللي بنجيبها من الـ API
  List<AdsData> allAds = [];


  Future<void> fetchUserAds() async {
    final result = await _repo.getUserAds();

    result.fold(
          (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
          (data) {
        final ads = data.data ?? [];

        userBuyAds.assignAll(
          ads.where((ad) => ad.tradeType?.toLowerCase() == 'buy').toList(),
        );
        userSellAds.assignAll(
          ads.where((ad) => ad.tradeType?.toLowerCase() == 'sell').toList(),
        );
      },
    );
  }
  Future<bool> editBuyAd(EditRequest editRequest) async {
    isEditingAd.value = true;
    final result = await _repo.editBuyAd(editRequest);
    isEditingAd.value = false;

    return result.fold(
          (failure) {
        Get.snackbar("Error", failure.message);
        return false;
      },
          (response) {
        Get.snackbar("Success", "Buy ad updated successfully!");
        fetchUserAds();
        return true;
      },
    );
  }

  Future<bool> editSellAd(EditRequest editRequest) async {
    isEditingAd.value = true;
    final result = await _repo.editSellAd(editRequest);
    isEditingAd.value = false;

    return result.fold(
          (failure) {
        Get.snackbar("Error", failure.message);
        return false;
      },
          (response) {
        Get.snackbar("Success", "Sell ad updated successfully!");
        fetchUserAds();
        return true;
      },
    );
  }

  Future<void> deleteBuyAd(int adId) async {
    final result = await _repo.deleteBuyAd(adId);
    result.fold(
          (failure) => Get.snackbar("Error", failure.message),
          (message) {
        Get.snackbar("Deleted", message);
        fetchUserAds();
      },
    );
  }

  Future<void> deleteSellAd(int adId) async {
    final result = await _repo.deleteSellAd(adId);
    result.fold(
          (failure) => Get.snackbar("Error", failure.message),
          (message) {
        Get.snackbar("Deleted", message);
        fetchUserAds();
      },
    );
  }

  void startTrade() {
    Get.to(() => TradeConfirmationScreen());
  }

  void submitPayment() {
    if (paymentProofUrl.value.isEmpty) {
      Get.snackbar("Error", "Please upload payment proof");
      return;
    }
    startTrade();
  }

  void toggleTradeType(bool buying) {
    isBuying.value = buying;
    fetchAds(); // نعمل تحديث للبيانات عند تغيير النوع
  }

  void changePaymentMethod(String? method) {
    if (method != null) {
      selectedPayment.value = method;
      _filterTraders();
    }
  }

  void changeCurrency(String? currency) {
    if (currency != null) {
      selectedCurrency.value = currency;
      _filterTraders();
    }
  }

  Future<void> postAd() async {
    if (amount.value.isEmpty || price.value.isEmpty) {
      Get.snackbar("Error", "Amount and Price are required");
      return;
    }

    isAdPosting.value = true;

    final request = P2pRequest(
      currency: selectedCurrency.value,
      amount: int.tryParse(amount.value),
      fiatAmount: int.tryParse(price.value),
      fiatCurrency: 'EGP',
      paymentMethod: selectedPayment.value,
      paymentDetails: paymentDetails.value,
    );


    final result = isBuying.value
        ? await _repo.createBuyAd(request)
        : await _repo.createSellAd(request);

    result.fold(
          (Failure failure) {
        isAdPosting.value = false;
        Get.snackbar("Error", failure.message);
      },
          (P2pAdResponse response) {
        isAdPosting.value = false;
        Get.snackbar("Success", "Ad posted successfully!");
        amount.value = '';
        price.value = '';
        fetchAds(); // بعد ما ينشر إعلان، يعمل تحديث للإعلانات
      },
    );
  }

  Future<void> fetchAds() async {
    final result = isBuying.value
        ? await _repo.getSellAd()
        : await _repo.getBuyAd(); // عكس العملية لأنك بتشوف الطرف الآخر

    result.fold(
          (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
          (data) {
        allAds = data.data??[];
        _filterTraders();
          },
    );
  }
  void _filterTraders() {
    filteredTraders.assignAll(
      allAds.where((ad) {
        final paymentMatch = selectedPayment.value == 'All' || ad.paymentMethod == selectedPayment.value;
        final currencyMatch = ad.currency == selectedCurrency.value;
        return paymentMatch && currencyMatch;
      }).toList(),
    );
  }

  Future<bool> acceptAd({required double amount, required int adId}) async {
    final result = await _repo.postAcceptAd(amount, adId);

    bool accepted = false;

    result.fold(
          (Failure failure) {
        // لو جت رسالة الخطأ المحددة دي، نعرض رسالة مخصصة وما ننقلش
        if (failure.message.contains("already in progress")) {
          Get.snackbar("Notice", "This ad is already in progress.",
              backgroundColor: Colors.orange, colorText: Colors.white);
        } else {
          Get.snackbar("Error", failure.message,
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      },
          (AcceptAdModel response) {
        Get.snackbar("Success", "Ad accepted successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
        accepted = true;
      },
    );

    return accepted;
  }



  Future<void> completeAd({required int adId}) async {
    if (paymentProofUrl.value.isEmpty) {
      Get.snackbar("Error", "Please upload payment proof");
      return;
    }

    final file = File(paymentProofUrl.value);
    final result = await _repo.p2pCompleteAd(file, adId);

    result.fold(
          (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
          (response) {
        Get.snackbar("Success", "Payment submitted successfully!");
        Get.to(() => TradeConfirmationScreen());
      },
    );
  }


  Future<void> refreshTraders() async {
    await fetchAds(); // أو أي دالة بتحدث البيانات
  }


  @override
  void onInit() {
    super.onInit();
    fetchAds();// أول ما يفتح يعمل تحميل للإعلانات
    fetchUserAds();
  }
}
