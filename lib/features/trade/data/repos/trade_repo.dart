import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/trade/data/models/Coin_data_model.dart';
import 'package:bitvest/features/trade/data/models/buy_sell_model/Buy_sell_model.dart';
import 'package:bitvest/features/trade/data/models/put_favourites_model/Put_favourites_model.dart';
import 'package:dartz/dartz.dart';

abstract class TradeRepo {
  Future<Either<Failure,CoinDataModel>> getCoinDetails(String id);
  Future<Either<Failure,BuySellModel>> buyCrypto(String currency, num amount);
  Future<Either<Failure,BuySellModel>> sellCrypto(String currency, num amount);
  Future<Either<Failure,PutFavouritesModel>> putFavourites(String currency);
  Future<Either<Failure,Map<String, dynamic>>>  deleteFavourite(String id);
}