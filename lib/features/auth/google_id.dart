import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    // أضف scopes لو محتاج
  ],
);

Future<String?> googleSignIn() async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) {
      // المستخدم ألغى تسجيل الدخول
      return null;
    }
    final GoogleSignInAuthentication auth = await account.authentication;
    final idToken = auth.idToken;
    return idToken; // هذا هو الـ id_token
  } catch (error) {
    print('Error signing in with Google: $error');
    return null;
  }
}
class GoogleLoginRequest {
  final String idToken;

  GoogleLoginRequest({required this.idToken});

  Map<String, dynamic> toJson() => {
    'id_token': idToken,
  };
}
