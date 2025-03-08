import 'package:flutter/material.dart';
import 'package:bitvest/features/trade/data/repos/trade_repo.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/models/buy_sell_model/Buy_sell_model.dart';

class TradeController extends GetxController {
  final TradeRepo tradeRepo = sl<TradeRepo>();

  var isLoading = false.obs;
  var errorMessage = RxnString();
  var tradeResponse = Rxn<BuySellModel>();

  void clearResponse() {
    tradeResponse.value = null;
    errorMessage.value = null;
  }

  Future<void> buyCrypto(String currency, double amount) async {
    isLoading.value = true;
    clearResponse();

    try {
      Either<Failure, BuySellModel> result =
      await tradeRepo.buyCrypto(currency, amount);

      result.fold(
            (failure) {
          errorMessage.value = failure.message ?? "Unexpected error";
          Get.snackbar("Error", errorMessage.value!,
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
            (data) {
          if (data.success!) {
            tradeResponse.value = data;
            Get.snackbar("Success", "Successfully purchased $amount of $currency.",
                backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.snackbar("Error", data.message ?? "Purchase failed",
                backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sellCrypto(String currency, double amount) async {
    isLoading.value = true;
    clearResponse();

    try {
      Either<Failure, BuySellModel> result =
      await tradeRepo.sellCrypto(currency, amount);

      result.fold(
            (failure) {
          errorMessage.value = failure.message ?? "Unexpected error";
          Get.snackbar("Error", errorMessage.value!,
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);        },
            (data) {
          if (data.success!) {
            tradeResponse.value = data;
            Get.snackbar("Success", "Successfully sold $amount of $currency.",
                backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.snackbar("Error", data.message ?? "Sale failed",
                backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

}
