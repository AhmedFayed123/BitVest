import 'package:dartz/dartz.dart';

import '../../../../../core/errors/server_failures.dart';
import '../../models/market_model/Market_model.dart';

abstract class MarketRepo {
  Future<Either<Failure, AllMarketModel>> getCoinsList();
  Future<Either<Failure, MarketModel>> getNewList();

}