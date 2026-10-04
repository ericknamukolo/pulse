import 'package:pulse/features/auth/screens/splash_screen.dart';
import 'package:pulse/main.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/utils/navigation.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class AuthRepo {
  Future<Map<String, dynamic>?> signIn(
      {required String email, required String pwd, required String url}) async {
    final isCloud = url == umamiUrl;
    String? sessionCookie;
    var res = await Requests.post(
      endpoint: isCloud ? '$url/api/auth/sign-in/email' : '$url/api/auth/login',
      body: {
        isCloud ? 'email' : 'username': email,
        'password': pwd,
      },
      noAuth: true,
      onResponse: (res) => sessionCookie = RegExp('$cloudSessionCookie=[^;,]+')
          .firstMatch(res.headers['set-cookie'] ?? '')
          ?.group(0),
    );

    if (res == null || (isCloud && sessionCookie == null)) {
      throw Exception('Failed to sign in');
    }
    baseUrl = url;
    prefs.setString(LocalStorage.jwt, sessionCookie ?? res['token']);
    prefs.setString(LocalStorage.host, url);
    prefs.setString(LocalStorage.email, email);
    return res;
  }

  Future<void> signOut(context) async {
    await prefs.clear();
    Navigation.go(screen: SplashScreen(), context: context, replace: true);
  }

  static Future<void> tokenExpired() async {
    await prefs.clear();
    Toast.showToast(
        message: 'Token Expired', context: navigatorKey.currentContext!);
    Navigation.go(
        screen: SplashScreen(),
        context: navigatorKey.currentContext!,
        replace: true);
  }
}
