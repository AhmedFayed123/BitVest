
import 'package:bitvest/core/errors/server_failures.dart';

import 'package:bitvest/features/home/data/models/news_model/News_model.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final Dio dio;

  HomeRepoImpl({required this.dio});

  @override
  Future<Either<Failure, NewsModel>> fetchNews() async{
      try {
        final response = await dio.get('https://min-api.cryptocompare.com/data/v2/news/');

        if (response.statusCode == 200) {
          final newsModel = NewsModel.fromJson(response.data);
          return Right(newsModel);
        } else {
          return Left(ServerFailure('Failed: ${response.statusCode}'));
        }
      } catch (e) {
        return Left(ServerFailure('Error: ${e.toString()}'));
      }
    }
}
