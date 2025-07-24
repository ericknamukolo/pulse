import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/screens/splash_screen.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const Pulse());
}

class Pulse extends StatelessWidget {
  const Pulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffF5F5F5),
          fontFamily: 'Montserrat',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
