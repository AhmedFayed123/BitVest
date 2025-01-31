import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  // متغير لمتابعة حالة الاتصال
  var isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  // التحقق من الاتصال عند بداية التطبيق
  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isOnline.value = _isOnline(connectivityResult);
  }

  // متابعة حالة الاتصال
  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      isOnline.value = _isOnline(connectivityResult);
    });
  }

  // التحقق إذا كان هناك اتصال بالإنترنت بناءً على نتيجة واحدة
  bool _isOnline(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile);
  }

  // دالة عامة لإعادة التحقق من الاتصال بالإنترنت
  void retryConnectivityCheck() {
    _checkInitialConnectivity();
  }

  // إلغاء الاشتراك عند التخلص من الكلاس
  @override
  void onClose() {
    Connectivity().onConnectivityChanged.drain();
    super.onClose();
  }
}
