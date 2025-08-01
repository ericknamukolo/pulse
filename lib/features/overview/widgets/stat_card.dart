import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/overview/repo/overview_repo.dart';
import 'package:pulse/utils/text.dart';
import 'package:intl/intl.dart';
import 'package:pulse/utils/utils.dart';
import '../../../utils/colors.dart';
import '../../../widgets/container_wrapper.dart';

class StatCard extends StatelessWidget {
  final MapEntry<String, dynamic> stat;
  const StatCard({
    super.key,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = OverviewRepo().getPercentage(
        current: stat.value['value'], previous: stat.value['prev']);
    return ContainerWrapper(
      padding: 15.0,
      bRadius: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(stat.key.toUpperCase(),
              style: kBodyTitleTextStyle.copyWith(color: kGreyColor)),
          if (stat.key.toLowerCase() == 'totaltime')
            FittedBox(
              child: Text(formatDuration((stat.value as Map)['value']),
                  style: kTitleTextStyle.copyWith(
                      fontSize: kTitleTextStyle.fontSize! + 8)),
            )
          else
            Text(NumberFormat.compact().format((stat.value as Map)['value']),
                style: kTitleTextStyle.copyWith(
                    fontSize: kTitleTextStyle.fontSize! + 8)),
          if (stat.value['prev'] != -1)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
              decoration: BoxDecoration(
                color: percentage.isNegative
                    ? kErrorColor.withOpacity(.2)
                    : kSuccessColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: percentage.isNegative
                      ? kErrorColor.withOpacity(.5)
                      : kSuccessColor.withOpacity(.5),
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Visibility(
                    visible: percentage != 0,
                    child: Icon(
                      percentage.isNegative
                          ? Bootstrap.arrow_down_left_circle_fill
                          : Bootstrap.arrow_up_right_circle_fill,
                      color:
                          percentage.isNegative ? kErrorColor : kSuccessColor,
                      size: 18,
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1).replaceAll('-', '')} %',
                    style: kBodyTextStyle.copyWith(
                      color:
                          percentage.isNegative ? kErrorColor : kSuccessColor,
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
