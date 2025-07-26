import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/container_wrapper.dart';
import 'package:pulse/widgets/drop_down_btn.dart';

import 'widgets/stat_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        DropDownBtn(
          click: () {},
          icon: Iconsax.timer_1_bold,
          title: 'Last 24 hours',
        ),
        StatCard(),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (_, i) => StatCard(),
          itemCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      ],
    );
  }
}
