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

  String get toOsIcon {
    if (contains('ios')) {
      return 'assets/images/brands/apple-logo.svg';
    } else if (contains('mac')) {
      return 'assets/images/brands/mac-logo.svg';
    } else if (contains('android')) {
      return 'assets/images/brands/android-os.svg';
    } else if (contains('windows 10')) {
      return 'assets/images/brands/windows-10.svg';
    } else if (contains('windows 11')) {
      return 'assets/images/brands/windows-11.svg';
    } else if (contains('windows 7') || contains('windows')) {
      return 'assets/images/brands/windows8.svg';
    } else if (contains('linux')) {
      return 'assets/images/brands/kali-linux.svg';
    } else {
      return 'assets/images/brands/mac-logo.svg';
    }
  }

  String get toBrowserIcon {
    if (contains('chrome')) {
      return 'assets/images/brands/chrome.svg';
    } else if (contains('ios') || contains('safari')) {
      return 'assets/images/brands/safari.svg';
    } else if (contains('opera')) {
      return 'assets/images/brands/opera.svg';
    } else if (contains('chromium')) {
      return 'assets/images/brands/chromium.svg';
    } else if (contains('samsung')) {
      return 'assets/images/brands/samsung.svg';
    } else if (contains('instagram')) {
      return 'assets/images/brands/instagram.svg';
    } else {
      return 'assets/images/brands/chromium.svg';
    }
  }
}
