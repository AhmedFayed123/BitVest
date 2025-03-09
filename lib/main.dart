import 'package:bitvest/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Locale/Locale_Controller.dart';
import 'Locale/locale.dart';
import 'core/constant/colors.dart';
import 'core/constant/sizes.dart';
import 'core/constant/strings.dart';
import 'core/network/dio_helper/dio_helper.dart';
import 'core/services/service_locator.dart';
import 'features/connectivity/presentation/controllers/connectivity_controller.dart';
import 'features/connectivity/presentation/views/no_internet_screen.dart';
import 'features/connectivity/presentation/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await ServiceLocator().init();
  await DioHelper.init();

  await GetStorage.init();

  Get.put(MyLocaleController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController =
        Get.put(ConnectivityController());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: kPrimaryColor,
            ),
            scaffoldBackgroundColor: kBackgroundColor,
            appBarTheme: AppBarTheme(
              color: kBackgroundColor,
              iconTheme: IconThemeData(color: kWhiteColor),
              titleTextStyle: AppStyles.textStyle16regular,
            ),
            fontFamily: Strings.kPoppins,
            useMaterial3: true,
          ),
          translations: LocaleStrings(),
          // إضافة الترجمة
          locale: Get.locale ?? const Locale('en'),
          // استخدام لغة الجهاز أو الإنجليزية
          fallbackLocale: const Locale('en'),
          // اللغة الافتراضية
          home: Obx(() {
            if (connectivityController.isOnline.value) {
              // Navigate to the SplashScreen after a delay
              Future.delayed(const Duration(milliseconds: 300), () {
                if (connectivityController.isOnline.value) {
                  Get.off(() => const SplashScreen());
                }
              });

              // Return an empty scaffold while waiting
              return Scaffold(
                body: Center(
                  child: SpinKitFadingCircle(
                    color: kAmberColor,
                    size: Sizes.buttonHeightMedium,
                  ),
                ),
              );
            } else {
              // Show the no internet screen if offline
              return NoInternetScreen(
                onRetry: () => connectivityController.retryConnectivityCheck(),
              );
            }
          }),
        );
      },
    );
  }
}
