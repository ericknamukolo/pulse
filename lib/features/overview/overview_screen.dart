import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/overview/repo/overview_repo.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/container_wrapper.dart';
import 'package:pulse/widgets/drop_down.dart';
import 'package:pulse/widgets/drop_down_btn.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:pulse/widgets/title_card.dart';
import '../../utils/utils.dart';
import 'cubit/overview_cubit.dart';
import 'widgets/stat_card.dart';
import 'package:collection/collection.dart';

class OverviewScreen extends StatefulWidget {
  final Website web;
  const OverviewScreen({super.key, required this.web});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  DateTimeRange? range;
  @override
  void initState() {
    context.read<OverviewCubit>().getStats(id: widget.web.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OverviewCubit, OverviewState>(
      listener: (context, state) {
        if (state.appState == AppState.error) {
          Toast.showToast(
            message: state.errorMessage ?? 'An error occurred',
            context: context,
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<OverviewCubit>().getStats(id: widget.web.id);
          },
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              children: [
                DropDownBtn(
                  click: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      initialDateRange: range ??
                          DateTimeRange(
                              start: DateTime.now().subtract(Duration(days: 3)),
                              end: DateTime.now()),
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      saveText: 'Done',
                    );
                    if (picked == null) return;
                    setState(() => range = picked);
                    context.read<OverviewCubit>().getStats(
                        id: widget.web.id,
                        start: picked.start,
                        end: picked.end);
                  },
                  icon: Iconsax.timer_1_bold,
                  title: range == null
                      ? 'Last 24 hours'
                      : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
                ),
                TitleCard(title: 'Summary'),
                state.stats == null || state.appState == AppState.loading
                    ? FadeShimmer(
                        height: 100,
                        width: double.infinity,
                        radius: 16,
                        fadeTheme: FadeTheme.light,
                      )
                    : StatCard(stat: state.stats!.entries.toList()[0]),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (_, i) =>
                      state.stats == null || state.appState == AppState.loading
                          ? FadeShimmer(
                              height: 8,
                              width: 150,
                              radius: 16,
                              fadeTheme: FadeTheme.light,
                            )
                          : StatCard(
                              stat: state.stats!.entries
                                  .toList()
                                  .getRange(1, state.stats!.length)
                                  .toList()[i],
                            ),
                  itemCount: (state.stats?.length ?? 5) - 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
                TitleCard(title: 'Metrics'),
                CustomDropDown(
                  removePadding: true,
                  selectedItem: state.metric,
                  items: [
                    'Url',
                    'Referrer',
                    'Browser',
                    'OS',
                    'Device',
                    'Country',
                    'Event'
                  ],
                  hint: 'Select metric',
                  onChanged: (val) {
                    context.read<OverviewCubit>().getMetrics(
                          id: widget.web.id,
                          metric: val,
                          start: range?.start,
                          end: range?.end,
                        );
                  },
                ),
                SizedBox(
                  height: 250,
                  child: PieChart(
                    curve: Curves.easeInOutSine,
                    duration: Duration(seconds: 1),
                    PieChartData(
                      sections: state.metrics
                          .mapIndexed(
                            (i, e) => PieChartSectionData(
                              value: (e.y).toDouble(),
                              color: colors[i],
                              title:
                                  '${OverviewRepo().getMetricPercentage(e.y, state.metrics.map((e) => e.y).toList()).toStringAsFixed(1)} %',
                              radius: 50,
                              showTitle: true,
                              titleStyle: kBodyTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Column(
                  spacing: 10,
                  children: state.metrics
                      .mapIndexed(
                        (i, e) => ContainerWrapper(
                          child: Row(
                            spacing: 10,
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: colors[i],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              Text(
                                '${e.x} (${NumberFormat.compact().format(e.y)})',
                                style: kBodyTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${OverviewRepo().getMetricPercentage(e.y, state.metrics.map((e) => e.y).toList()).toStringAsFixed(1)} %',
                                style: kBodyTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor.withOpacity(.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
