import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';

class DropDownBtn extends StatelessWidget {
  const DropDownBtn({
    super.key,
    required this.click,
    required this.icon,
    this.title,
    this.hint,
  });

  final String? title;
  final String? hint;

  final VoidCallback click;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: kPrimaryColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title ?? hint ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kBodyTextStyle.copyWith(
                  color: title == null
                      ? kGreyColor.withOpacity(.5)
                      : kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
