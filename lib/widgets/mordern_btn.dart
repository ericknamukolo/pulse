import 'package:pulse/utils/text.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class MordernBtn extends StatelessWidget {
  final VoidCallback? click;
  final Color btnColor;
  final Color? textColor;
  final IconData icon;
  final String title;
  final bool isCentered;
  final bool isLoading;
  final bool removeBg;
  const MordernBtn({
    super.key,
    this.click,
    required this.icon,
    required this.title,
    this.isCentered = false,
    this.isLoading = false,
    this.removeBg = false,
    this.btnColor = kPrimaryColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : click,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: removeBg ? null : btnColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: btnColor,
            width: 2.0,
          ),
        ),
        alignment: isCentered ? Alignment.center : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: btnColor),
            const SizedBox(width: 10),
            Text(title,
                style: kBodyTextStyle.copyWith(
                  color: textColor ?? kBodyTextStyle.color,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
