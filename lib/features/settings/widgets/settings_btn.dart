import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';

import '../screens/model/btn.dart';

class SettingsBtn extends StatelessWidget {
  final Btn btn;
  const SettingsBtn({super.key, required this.btn});

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (btn.title.toLowerCase().contains('logout')) {
        return kErrorColor;
      }
      return kGreyColor;
    }

    return InkWell(
      onTap: btn.click,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: getColor().withOpacity(.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                btn.icon,
                color: getColor(),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(btn.title,
                      style: kBodyTitleTextStyle.copyWith(
                        color: getColor() == kErrorColor
                            ? kErrorColor
                            : Colors.black,
                      )),
                  Text(btn.des ?? '-',
                      style: kBodyTextStyle.copyWith(color: getColor())),
                ],
              ),
            ),
            if (btn.child != null)
              btn.child!
            else
              Icon(Icons.chevron_right_rounded, color: getColor()),
          ],
        ),
      ),
    );
  }
}
