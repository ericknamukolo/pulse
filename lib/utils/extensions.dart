import 'package:flutter/material.dart';

extension StringExtensions on String {
  IconData get toDeviceIcon {
    switch (toLowerCase()) {
      case 'laptop':
        return Icons.laptop_mac_rounded;
      case 'desktop':
        return Icons.desktop_windows_rounded;
      case 'mobile':
        return Icons.phone_android_rounded;
      default:
        return Icons.phone_android_rounded;
    }
  }
}
