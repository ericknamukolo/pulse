import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/events/cubit/events_cubit.dart';
import 'package:pulse/features/overview/cubit/overview_cubit.dart';
import 'package:pulse/features/sessions/cubit/sessions_cubit.dart';
import 'package:pulse/features/theme/cubit/theme_cubit.dart';
import 'package:pulse/features/websites/cubit/website_cubit.dart';
import 'package:pulse/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/screens/splash_screen.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor:
                  state.darkMode ? Color(0xff141414) : Color(0xffF5F5F5),
              appBarTheme: AppBarTheme(
                backgroundColor: state.darkMode ? Color(0xff1A1A1A) : null,
              ),
              textTheme: TextTheme(
                  bodyMedium: kBodyTitleTextStyle.copyWith(
                      color: state.darkMode ? Colors.white : Colors.black87),
                  bodyLarge: kTitleTextStyle.copyWith(
                      color: state.darkMode ? Colors.white : Colors.black87)),
              cardColor: state.darkMode ? Color(0xff1A1A1A) : Colors.white,
              focusColor:
                  state.darkMode ? Color(0xff292929) : const Color(0xffF5F9FE),
              fontFamily: 'Montserrat',
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: kPrimaryColor,
                brightness: state.darkMode ? Brightness.dark : Brightness.light,
              ).copyWith(
                surface:
                    state.darkMode ? const Color(0xff1A1A1A) : Colors.white,
                onSurface: state.darkMode ? Colors.white : Colors.black87,
              ),
              datePickerTheme: DatePickerThemeData(
                backgroundColor:
                    state.darkMode ? const Color(0xff1A1A1A) : Colors.white,
                headerBackgroundColor:
                    state.darkMode ? const Color(0xff1A1A1A) : null,
                headerForegroundColor:
                    state.darkMode ? Colors.white : Colors.black87,
                dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return state.darkMode
                        ? Colors.white.withOpacity(.38)
                        : Colors.black.withOpacity(.38);
                  }
                  return state.darkMode ? Colors.white : Colors.black87;
                }),
                yearForegroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return state.darkMode
                        ? Colors.white.withOpacity(.38)
                        : Colors.black.withOpacity(.38);
                  }
                  return state.darkMode ? Colors.white : Colors.black87;
                }),
              ),
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
