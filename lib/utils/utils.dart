import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:logger/logger.dart';
import 'package:pulse/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late SharedPreferences prefs;
String? userTimeZone;

enum AppState {
  initial,
  loading,
  secondaryLoading,
  secondaryComplete,
  complete,
  success,
  error,
  secondaryError,
}

var logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
  ),
);

class Toast {
  static void showToast(
      {required String message, required BuildContext context}) {
    String errMessage = message;
    if (message.contains(':')) {
      errMessage = message.split(':').last;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: message.contains('App Update')
            ? SnackBarAction(
                label: 'Update!',
                onPressed: () async {
                  await InAppUpdate.performImmediateUpdate();
                })
            : null,
        behavior: SnackBarBehavior.floating,
        content: Text(
          errMessage.trim(),
          style: kBodyTextStyle.copyWith(color: Colors.white),
        ),
        showCloseIcon: true,
        duration: Duration(seconds: 6),
      ),
    );
  }
}

class Links {
  static void goToLink(String url,
      {LaunchMode mode = LaunchMode.inAppBrowserView}) async {
    await launchUrl(Uri.parse(url), mode: mode);
  }
}

List<BoxShadow> shadows = [
  BoxShadow(
    color: const Color(0xff000000).withOpacity(0.010),
    blurRadius: 4.0,
    offset: const Offset(0.0, 3.0),
  )
];

Color getColorFromIndex(int index) {
  final hue = (index * 40) % 360; // 40° step for visual distinction
  final hslColor = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.6, 0.5);
  return hslColor.toColor();
}

String formatDuration(int seconds) {
  final duration = Duration(seconds: seconds);
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final secs = duration.inSeconds.remainder(60);

  if (hours > 0) {
    return '${_twoDigits(hours)}h ${_twoDigits(minutes)}m ${_twoDigits(secs)}s';
  } else if (minutes > 0) {
    return '${_twoDigits(minutes)}m ${_twoDigits(secs)}s';
  } else {
    return '${secs}s';
  }
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');
