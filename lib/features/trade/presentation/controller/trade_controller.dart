import 'package:flutter/material.dart';
import 'package:bitvest/features/trade/data/repos/trade_repo.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/models/buy_sell_model/Buy_sell_model.dart';
import '../../data/models/put_favourites_model/Put_favourites_model.dart';

class TradeController extends GetxController {
  final TradeRepo tradeRepo = sl<TradeRepo>();

  var isLoading = false.obs;
  var errorMessage = RxnString();
  var tradeResponse = Rxn<BuySellModel>();
  var favourites = <String, bool>{}.obs;
  var favouriteIds = <String, int?>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavourites();
  }

  void clearResponse() {
    tradeResponse.value = null;
    errorMessage.value = null;
  }

  bool isFavourite(String currency) {
    return favourites[currency] ?? false;
  }

  Future<void> toggleFavourite(String currency) async {
    if (isFavourite(currency)) {
      await removeFromFavourites(currency);
    } else {
      await addToFavourites(currency);
    }
  }

  Future<void> addToFavourites(String currency) async {
    try {
      Either<Failure, PutFavouritesModel> result =
      await tradeRepo.putFavourites(currency);

      result.fold(
            (failure) {
          Get.snackbar("Error", failure.message ?? "Failed to add to favourites",
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
            (data) async {
          favourites[currency] = true;
          favouriteIds[currency] = data.data?.favouritecurrency?.id;

          await saveFavourites();
          Get.snackbar("Success", "Added to favourites",
              backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Unexpected error",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> removeFromFavourites(String currency) async {
    if (favouriteIds[currency] == null) return;

    try {
      Either<Failure, Map<String, dynamic>> result =
      await tradeRepo.deleteFavourite(favouriteIds[currency].toString());

      result.fold(
            (failure) {
          Get.snackbar("Error", failure.message ?? "Failed to remove from favourites",
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
            (data) async {
          favourites[currency] = false;
          favouriteIds.remove(currency);

          await saveFavourites();
          Get.snackbar("Success", "Removed from favourites",
              backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Unexpected error",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, int?> favouritesMap = {};
    favourites.forEach((key, value) {
      if (value) {
        favouritesMap[key] = favouriteIds[key];
      }
    });

    await prefs.setString(
        'favouriteCurrencies',
        favouritesMap.entries.map((e) => '${e.key}:${e.value}').toList().join(','));
  }

  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedFavourites = prefs.getString('favouriteCurrencies');

    if (storedFavourites != null && storedFavourites.isNotEmpty) {
      favourites.clear();
      favouriteIds.clear();

      for (String entry in storedFavourites.split(',')) {
        List<String> parts = entry.split(':');
        if (parts.length == 2) {
          String currency = parts[0];
          int? id = int.tryParse(parts[1]);

          favourites[currency] = true;
          favouriteIds[currency] = id;
        }
      }
    }
  }

  Future<void> buyCrypto(String currency, num amount) async {
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

  Future<void> sellCrypto(String currency, num amount) async {
    isLoading.value = true;
    clearResponse();

    try {
      Either<Failure, BuySellModel> result =
      await tradeRepo.sellCrypto(currency, amount);

      result.fold(
            (failure) {
          errorMessage.value = failure.message ?? "Unexpected error";
          Get.snackbar("Error", errorMessage.value!,
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
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
