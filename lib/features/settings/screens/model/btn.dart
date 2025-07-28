import 'package:flutter/material.dart';

class Btn {
  String title;
  String? des;
  String? type;
  int number;
  IconData icon;
  VoidCallback? click;
  Widget? child;

  Btn({
    required this.title,
    required this.icon,
    this.click,
    this.des,
    this.type,
    this.child,
    this.number = 0,
  });
}
