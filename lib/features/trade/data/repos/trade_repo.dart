import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/trade/data/models/Coin_data_model.dart';
import 'package:bitvest/features/trade/data/models/buy_sell_model/Buy_sell_model.dart';
import 'package:dartz/dartz.dart';

abstract class TradeRepo {
  Future<Either<Failure,CoinDataModel>> getCoinDetails(String id);
  Future<Either<Failure,BuySellModel>> buyCrypto(String currency, double amount);
  Future<Either<Failure,BuySellModel>> sellCrypto(String currency, double amount);
}