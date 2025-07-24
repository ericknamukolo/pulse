import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../utils/text.dart';

class EmptyState extends StatelessWidget {
  final String? message;
  final IconData? icon;
  const EmptyState({super.key, this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(
            icon ?? Iconsax.chart_1_outline,
            color: Colors.amber,
            size: 60,
          ),
          Text(message ?? 'Nothing to show', style: kBodyTitleTextStyle),
        ],
      ),
    );
  }
}
