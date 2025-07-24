import 'package:flutter/material.dart';
import '../../../utils/text.dart';
import '../../../widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) async {
      // Navigation.go(
      //   screen: isSignedIn ? const NavBar() : const SignInScreen(),
      //   context: context,
      //   replace: true,
      // );
    });
    super.initState();
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
