import 'package:country_codes/country_codes.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/overview/cubit/overview_cubit.dart';
import 'package:pulse/features/overview/repo/overview_repo.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/utils/utils.dart';

import '../../../utils/colors.dart';
import '../../../widgets/container_wrapper.dart';
import '../models/metric.dart';

class MetricCard extends StatelessWidget {
  final Metric met;
  final int i;
  const MetricCard({
    super.key,
    required this.met,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewCubit, OverviewState>(
      builder: (context, state) {
        return ContainerWrapper(
          child: Row(
            spacing: 10,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: getColorFromIndex(i),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              if (state.metric == 'Country')
                Row(
                  spacing: 10,
                  children: [
                    CountryFlag.fromCountryCode(
                      met.x,
                      width: 30,
                      height: 20,
                      shape: const RoundedRectangle(2),
                    ),
                    Text(
                      '${CountryCodes.name(locale: Locale('en-GB', met.x))}',
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '(${NumberFormat.compact().format(met.y)})',
                      style: kBodyTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  '${met.x} (${NumberFormat.compact().format(met.y)})',
                  style: kBodyTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              const Spacer(),
              Text(
                '${OverviewRepo().getMetricPercentage(met.y, state.metrics.map((e) => e.y).toList()).toStringAsFixed(1)} %',
                style: kBodyTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor.withOpacity(.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
