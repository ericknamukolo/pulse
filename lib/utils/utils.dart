import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pulse/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late SharedPreferences prefs;

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
      {LaunchMode mode = LaunchMode.externalApplication}) async {
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
