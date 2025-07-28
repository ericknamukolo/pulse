import 'package:pulse/features/auth/screens/sign_in_screen.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/utils/navigation.dart';
import 'package:pulse/utils/requests.dart';
import 'package:pulse/utils/utils.dart';

class AuthRepo {
  Future<Map<String, dynamic>?> signIn(
      {required String email, required String pwd}) async {
    var res = await Requests.post(
      endpoint: Endpoints.authLogin,
      body: {
        'email': email,
        'password': pwd,
      },
      noAuth: true,
    );
    if (res == null) {
      throw Exception('Failed to sign in');
    }
    prefs.setString(LocalStorage.jwt, res['token']);
    return res;
  }

  Future<void> signOut(context) async {
    await prefs.clear();
    Navigation.go(screen: SignInScreen(), context: context, replace: true);
  }
}
