import 'package:bitvest/features/future/data/models/available_coins/Available_coins.dart';
import 'package:bitvest/features/future/data/models/future_wallet/Future_wallet.dart';
import 'package:bitvest/features/future/data/models/futures_position_response/futures_position_response.dart';
import 'package:bitvest/features/future/data/models/position_open_request/Position_open_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class FutureRepo {
  Future<Either<Failure, AvailableCoins>> fetchAvailableCoins();

  Future<Either<Failure, FutureWallet>> fetchFutureWallet();
  Future<Either<Failure, FuturesPositionResponse>> fetchFuturePositions();

  Future<Either<Failure, Map<String, dynamic>>> transferFutures({
    required String currency,
    required double amount,
  });
  Future<Either<Failure, Map<String, dynamic>>> transferFuturesSpot({
    required String currency,
    required double amount,
  });
  Future<Either<Failure, Map<String, dynamic>>> openPosition(PositionOpenRequest positionOpenRequest);
  Future<Either<Failure, Map<String, dynamic>>> closePosition(int positionId);
  Future<Either<Failure, Map<String, dynamic>>> updatePosition(int positionId);
}
