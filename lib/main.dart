import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/events/cubit/events_cubit.dart';
import 'package:pulse/features/overview/cubit/overview_cubit.dart';
import 'package:pulse/features/sessions/cubit/sessions_cubit.dart';
import 'package:pulse/features/websites/cubit/website_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/screens/splash_screen.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CountryCodes.init();
  prefs = await SharedPreferences.getInstance();
  userTimeZone = await FlutterTimezone.getLocalTimezone();
  runApp(const Pulse());
}

class Pulse extends StatelessWidget {
  const Pulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => WebsiteCubit()),
        BlocProvider(create: (_) => OverviewCubit()),
        BlocProvider(create: (_) => EventsCubit()),
        BlocProvider(create: (_) => SessionsCubit()),
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
