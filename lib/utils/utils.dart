import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pulse/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String baseUrl = 'https://cloud.umami.is';
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
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
