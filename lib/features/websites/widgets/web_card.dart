import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/nav_bar.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/features/websites/screens/edit_website_screen.dart';
import 'package:pulse/utils/navigation.dart';
import 'package:pulse/widgets/icon_btn.dart';

import '../../../utils/colors.dart';
import '../../../utils/text.dart';
import '../../../utils/utils.dart';

class WebCard extends StatelessWidget {
  final Website website;
  const WebCard({super.key, required this.website});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigation.go(screen: NavBar(web: website), context: context),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: shadows,
        ),
        child: Row(
          spacing: 15,
          children: [
            Icon(Iconsax.global_bold,
                color: kGreyColor.withOpacity(.5), size: 30),
            Expanded(
              child: Column(
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
            ),
            IconBtn(
              icon: Icons.edit_rounded,
              click: () => Navigation.go(
                  screen: EditWebsiteScreen(web: website), context: context),
              iconColor: kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
