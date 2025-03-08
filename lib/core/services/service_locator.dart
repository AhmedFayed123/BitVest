import 'package:bitvest/features/home/data/repos/home_repo/home_repo.dart';
import 'package:bitvest/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:bitvest/features/market/data/repos/market_repo/market_repo.dart';
import 'package:bitvest/features/market/data/repos/market_repo/market_repo_impl.dart';
import 'package:bitvest/features/profile/data/repo/profile_repo.dart';
import 'package:bitvest/features/profile/data/repo/profile_repo_impl.dart';
import 'package:bitvest/features/trade/data/repos/trade_repo.dart';
import 'package:bitvest/features/trade/data/repos/trade_repo_impl.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/login/data/repos/login_repo/login_repo.dart';
import '../../features/auth/login/data/repos/login_repo/login_repo_impl.dart';
import '../../features/auth/register/data/repos/signup_repo/signup_repo.dart';
import '../../features/auth/register/data/repos/signup_repo/signup_repo_impl.dart';
import 'storage_service.dart';


final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    await _initSharedPref();
    _initServices();
    _initRepositories();
  }

  Future<void> _initSharedPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPref);
  }

  void _initServices() {
    sl.registerLazySingleton<StorageService>(() => StorageService());
  }

  void _initRepositories() {
    sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
    sl.registerLazySingleton<SignupRepo>(() => SignupRepoImpl());
    sl.registerLazySingleton<MarketRepo>(() => MarketRepoImpl());
    sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
    sl.registerLazySingleton<WalletRepo>(() => WalletRepoImpl());
    sl.registerLazySingleton<TradeRepo>(() => TradeRepoImpl());
    sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(dio: Dio()));

  }
}
