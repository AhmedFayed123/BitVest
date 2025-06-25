import 'package:get/get.dart';

import '../../data/models/available_coins/Available_coins.dart';
import '../../data/models/future_wallet/Future_wallet.dart';
import '../../data/models/futures_position_response/futures_position.dart';
import '../../data/models/position_open_request/Position_open_request.dart';
import '../../data/repos/future_repo.dart';

class FutureController extends GetxController {
  final FutureRepo repo;

  FutureController(this.repo);

  var isLoading = false.obs;
  var wallet = FutureWallet().obs;
  var availableCoins = AvailableCoins().obs;
  var error = ''.obs;
  var openPositions = <FuturesPosition>[].obs;
  var closedPositions = <FuturesPosition>[].obs;
  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchAllData();
  }
  Future<void> fetchPositions() async {
    final result = await repo.fetchFuturePositions();

    result.fold(
          (failure) => error.value = failure.message,
          (data) {
        openPositions.value = data.openPositions;
        closedPositions.value = data.closedPositions;
      },
    );
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    error.value = '';

    final walletResult = await repo.fetchFutureWallet();
    walletResult.fold(
      (failure) => error.value = failure.message,
      (data) => wallet.value = data,
    );

    final coinsResult = await repo.fetchAvailableCoins();
    coinsResult.fold(
      (failure) => error.value = failure.message,
      (data) => availableCoins.value = data,
    );
    await fetchPositions();

    isLoading.value = false;
  }
  Future<Map<String, dynamic>> transferFutures({
    required String currency,
    required double amount,
  }) async {
    final result = await repo.transferFutures(
         currency: currency,
        amount: amount,
    );

    return result.fold(
          (failure) {
        return {"success": false, "message": failure.message};
      },
          (data) {
        return {
          "success": data['message']?.toString().toLowerCase().trim() == "transfer successful",
          "message": data['message'] ?? ''
        };
      },
    );
  }

  Future<Map<String, dynamic>> transferFuturesSpot({
    required String currency,
    required double amount,
  }) async {
    final result = await repo.transferFuturesSpot(
      currency: currency,
      amount: amount,
    );

    return result.fold(
          (failure) {
        return {"success": false, "message": failure.message};
      },
          (data) {
        return {
          "success": data['message']?.toString().toLowerCase().trim() == "transfer successful",
          "message": data['message'] ?? ''
        };
      },
    );
  }
  Future<Map<String, dynamic>> openPosition(PositionOpenRequest request) async {
    final result = await repo.openPosition(request);

    return await result.fold(
          (failure) async => {
        "success": false,
        "message": failure.message,
      },
          (data) async {
        final success = data['message']?.toString().toLowerCase().contains("success") ?? false;
        if (success) {
          await fetchPositions();
        }
        return {
          "success": success,
          "message": data['message'] ?? '',
        };
      },
    );
  }

  Future<Map<String, dynamic>> closePosition(int positionId) async {
    final result = await repo.closePosition(positionId);

    return await result.fold(
          (failure) async => {
        "success": false,
        "message": failure.message,
      },
          (data) async {
        final success = RegExp(r'(position closed|closed successfully|success)',
            caseSensitive: false)
            .hasMatch(data['message'] ?? '');

        if (success) {
          await fetchPositions();
        }
        return {
          "success": success,
          "message": data['message'] ?? '',
          "pnl": data['pnl'],
        };
      },
    );
  }

  Future<Map<String, dynamic>> updatePosition(int positionId) async {
    final result = await repo.updatePosition(positionId);

    return await result.fold(
          (failure) async => {
        "success": false,
        "message": failure.message,
      },
          (data) async {
        final success = RegExp(r'(PnL updated|updated successfully|success)',
            caseSensitive: false)
            .hasMatch(data['message'] ?? '');

        if (success) {
          await fetchPositions();
        }

        return {
          "success": success,
          "message": data['message'] ?? '',
          "positions": data['positions'] ?? [],
        };
      },
    );
  }



}
