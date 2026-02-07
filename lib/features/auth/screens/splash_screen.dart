import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pulse/features/theme/cubit/theme_cubit.dart';
import 'package:pulse/features/websites/screens/websites_screen.dart';
import 'package:pulse/utils/endpoints.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/utils/navigation.dart';
import '../../../utils/text.dart';
import '../../../utils/utils.dart';
import '../../../widgets/loading_indicator.dart';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) async {
      checkForUpdate();
      baseUrl = prefs.getString(LocalStorage.host) ?? umamiUrl;
      String? token = prefs.getString(LocalStorage.jwt);
      await context.read<ThemeCubit>().setDarkMode();
      Navigation.go(
        screen: token != null ? WebsitesScreen() : SignInScreen(),
        context: context,
        replace: true,
      );
    });
    super.initState();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        Toast.showToast(
            message: 'New App Update Available! 🎉', context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            SizedBox(),
            Column(
              spacing: 10,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                ),
                Text('Pulse - Umami Client', style: kTitleTextStyle),
              ],
            ),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
