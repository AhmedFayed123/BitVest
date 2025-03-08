import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> isFingerPrintAvailable() async {
    try {
      bool isDeviceSupported = await _localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
      return isDeviceSupported && canCheckBiometrics;
    } catch (error) {
      debugPrint('خطأ أثناء التحقق من دعم البصمة: $error');
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await isFingerPrintAvailable();
    if (!isAvailable) return false;

    try {
      return await _localAuthentication.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (error) {
      debugPrint('خطأ أثناء المصادقة: ${error.message}');
      return false;
    } catch (error) {
      debugPrint('حدث خطأ غير متوقع: $error');
      return false;
    }
  }
}
