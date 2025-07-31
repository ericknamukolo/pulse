import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/sessions/cubit/sessions_cubit.dart';
import 'package:pulse/features/sessions/widget/session_card.dart';
import 'package:pulse/features/websites/models/website.dart';

import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/drop_down_btn.dart';
import '../../../widgets/title_card.dart';

class SessionsScreen extends StatefulWidget {
  final Website web;
  const SessionsScreen({super.key, required this.web});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  DateTimeRange? range;
  @override
  void initState() {
    context.read<SessionsCubit>().getSessions(id: widget.web.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsCubit, SessionsState>(
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
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            context.read<SessionsCubit>().getSessions(
                id: widget.web.id, end: range?.end, start: range?.start);
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
                    context.read<SessionsCubit>().getSessions(
                        id: widget.web.id,
                        end: range?.end,
                        start: range?.start);
                  },
                  icon: Iconsax.timer_1_bold,
                  title: range == null
                      ? 'Last 24 hours'
                      : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
                ),
                TitleCard(title: 'Sessions'),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    color: kGreyColor.withOpacity(.2),
                    height: 20,
                    endIndent: 20,
                    indent: 20,
                  ),
                  itemBuilder: (_, i) => state.appState == AppState.loading
                      ? FadeShimmer(
                          height: 80,
                          width: double.infinity,
                          radius: 8,
                          fadeTheme: FadeTheme.light,
                        )
                      : SessionCard(session: state.sessions[i]),
                  itemCount: state.appState == AppState.loading
                      ? 6
                      : state.sessions.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
