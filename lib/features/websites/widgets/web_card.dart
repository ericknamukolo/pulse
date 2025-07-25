import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/colors.dart';
import '../../../utils/text.dart';
import '../../../utils/utils.dart';

class WebCard extends StatelessWidget {
  const WebCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: shadows,
          ),
          child: Row(
            spacing: 15,
            children: [
              Icon(Iconsax.global_bold, color: kPrimaryColor, size: 30),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Website',
                    style: kBodyTitleTextStyle,
                  ),
                  Text(
                    'erick-website.com',
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
