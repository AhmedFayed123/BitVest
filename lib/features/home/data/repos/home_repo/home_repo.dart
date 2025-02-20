import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/home/data/models/news_model/News_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure,NewsModel>> fetchNews();
}
