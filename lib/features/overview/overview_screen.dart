import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/container_wrapper.dart';

import 'widgets/stat_card.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (_, i) => StatCard(),
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      ],
    );
  }
}
