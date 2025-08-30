import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
      return Brands.apple_logo;
    } else if (contains('mac')) {
      return Brands.mac_logo;
    } else if (contains('android')) {
      return Brands.android_os;
    } else if (contains('windows 10')) {
      return Brands.windows_10;
    } else if (contains('windows 11')) {
      return Brands.windows_11;
    } else if (contains('windows 7') || contains('windows')) {
      return Brands.windows8;
    } else if (contains('linux')) {
      return Brands.kali_linux;
    } else {
      return Brands.mac_logo;
    }
  }

  String get toBrowserIcon {
    if (contains('chrome')) {
      return Brands.chrome;
    } else if (contains('ios') || contains('safari')) {
      return Brands.safari;
    } else if (contains('opera')) {
      return Brands.opera;
    } else if (contains('chromium')) {
      return Brands.chromium;
    } else if (contains('samsung')) {
      return Brands.samsung;
    } else if (contains('instagram')) {
      return Brands.instagram;
    } else {
      return Brands.chromium;
    }
  }
}
