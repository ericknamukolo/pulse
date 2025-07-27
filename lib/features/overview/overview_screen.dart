import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/widgets/drop_down.dart';
import 'package:pulse/widgets/drop_down_btn.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:pulse/widgets/title_card.dart';
import '../../utils/utils.dart';
import 'cubit/overview_cubit.dart';
import 'widgets/stat_card.dart';

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
        return SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              TitleCard(title: 'Summary'),
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
                      id: widget.web.id, start: picked.start, end: picked.end);
                },
                icon: Iconsax.timer_1_bold,
                title: range == null
                    ? 'Last 24 hours'
                    : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
              ),
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
              )
            ],
          ),
        );
      },
    );
  }
}
