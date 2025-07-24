import 'package:flutter/cupertino.dart';

class Navigation {
  static Future<dynamic> go(
      {required Widget screen,
      required BuildContext context,
      bool replace = false}) {
    if (replace) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (_) => screen));
    } else {
      return Navigator.of(context)
          .push(CupertinoPageRoute(builder: (_) => screen));
    }
  }
}
