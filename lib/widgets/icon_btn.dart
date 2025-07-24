import 'package:pulse/utils/colors.dart';
import 'package:pulse/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback click;
  final bool isLoading;
  final Color? iconColor;
  final double? size;
  const IconBtn({
    super.key,
    required this.icon,
    required this.click,
    this.isLoading = false,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      borderRadius: BorderRadius.circular(60.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(14),
            border:
                Border.all(color: (iconColor ?? kGreyColor).withOpacity(.25))),
        child: isLoading
            ? const SizedBox(width: 23, height: 23, child: LoadingIndicator())
            : Icon(icon, color: iconColor ?? kGreyColor, size: size),
      ),
    );
  }
}
