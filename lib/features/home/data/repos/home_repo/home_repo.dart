import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/home/data/models/ads_model/Ads_model.dart';
import 'package:bitvest/features/home/data/models/news_model/News_model.dart';
import 'package:bitvest/features/home/data/models/search_model/Search_model.dart';
import 'package:dartz/dartz.dart';

import '../../models/coins_list/Coin_list_model.dart';
import '../../models/popular_coins_model/Popular_coins_model.dart';

abstract class HomeRepo {
  Future<Either<Failure,NewsModel>> fetchNews();
  Future<Either<Failure,PopularCoinsModel>> fetchPopular();
  Future<Either<Failure,CoinsListModel>> fetchHighestVolume();
  Future<Either<Failure,CoinsListModel>> fetchHighestChangeUp();
  Future<Either<Failure,CoinsListModel>> fetchHighestChangeDown();
  Future<Either<Failure,AdsModel>> fetchAds();
  Future<Either<Failure, List<SearchModel>>> search(String query);
}
