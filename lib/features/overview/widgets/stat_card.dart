import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/utils/text.dart';

import '../../../utils/colors.dart';
import '../../../widgets/container_wrapper.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWrapper(
      padding: 15.0,
      bRadius: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Visitors',
              style: kBodyTitleTextStyle.copyWith(color: kGreyColor)),
          Text('3052',
              style: kTitleTextStyle.copyWith(
                  fontSize: kTitleTextStyle.fontSize! + 8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
            decoration: BoxDecoration(
              color: kSuccessColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: kSuccessColor.withOpacity(.5),
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Icon(
                  Bootstrap.arrow_up_right_circle_fill,
                  color: kSuccessColor,
                  size: 18,
                ),
                Text(
                  '25%',
                  style: kBodyTextStyle.copyWith(
                    color: kSuccessColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
