import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/websites/models/website.dart';

import '../../../utils/colors.dart';
import '../../../utils/text.dart';
import '../../../utils/utils.dart';

class WebCard extends StatelessWidget {
  final Website website;
  const WebCard({super.key, required this.website});

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
                    website.name,
                    style: kBodyTitleTextStyle,
                  ),
                  Text(
                    website.domain,
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
