import 'package:flutter/material.dart';

import 'features/auth/screens/splash_screen.dart';
import 'utils/colors.dart';

void main() {
  runApp(const Pulse());
}

class Pulse extends StatelessWidget {
  const Pulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF5F5F5),
        fontFamily: 'Montserrat',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
      ),
      home: SplashScreen(),
    );
  }
}
