import 'dart:io';

import 'package:bitvest/features/p2p/data/models/accept_ad_model/Accept_ad_model.dart';
import 'package:bitvest/features/p2p/data/models/edit/edit_model/Edit_model.dart';
import 'package:bitvest/features/p2p/data/models/edit/edit_request/Edit_request.dart';
import 'package:bitvest/features/p2p/data/models/get_ads_model/Get_ads_model.dart';
import 'package:bitvest/features/p2p/data/models/p2p_complete_model/P2p_complete_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/p2p_ad_response/P2p_ad_response.dart';
import '../models/p2p_request/P2p_request.dart';

abstract class P2pRepo {
  Future<Either<Failure, P2pAdResponse>> createBuyAd(P2pRequest p2pRequest);
  Future<Either<Failure, P2pAdResponse>> createSellAd(P2pRequest p2pRequest);
  Future<Either<Failure, GetAdsModel>> getSellAd();
  Future<Either<Failure, GetAdsModel>> getBuyAd();
  Future<Either<Failure, GetAdsModel>> getUserAds();
  Future<Either<Failure, AcceptAdModel>> postAcceptAd(double amount,int id);
  Future<Either<Failure, P2pCompleteModel>> p2pCompleteAd(File photo,int id);
  Future<Either<Failure, EditModel>> editBuyAd(EditRequest editRequest);
  Future<Either<Failure, EditModel>> editSellAd(EditRequest editRequest);
  Future<Either<Failure, String>> deleteBuyAd(int adId);
  Future<Either<Failure, String>> deleteSellAd(int adId);

}
