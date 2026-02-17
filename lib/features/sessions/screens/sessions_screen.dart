import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/sessions/cubit/sessions_cubit.dart';
import 'package:pulse/features/sessions/widget/session_card.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/loading_indicator.dart';
import 'package:pulse/widgets/loading_shimmer.dart';

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
  int pageNumber = 2;
  DateTimeRange? range;
  @override
  void initState() {
    context.read<SessionsCubit>().getSessions(id: widget.web.id);
    super.initState();
  }

  void loadMore() {
    context.read<SessionsCubit>().getSessions(
          id: widget.web.id,
          end: range?.end,
          start: range?.start,
          pageNumber: pageNumber,
        );
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
        if (state.appState == AppState.secondaryComplete) {
          setState(() {
            pageNumber++;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: state.appState == AppState.secondaryLoading
              ? FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: LoadingIndicator(),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              final currentScroll = scrollEnd.metrics.pixels;
              double maxScroll = scrollEnd.metrics.maxScrollExtent;
              double threshold = maxScroll * 0.96;

              if (currentScroll >= threshold) {
                if (state.appState != AppState.secondaryLoading) {
                  loadMore();
                }
              }
              return true;
            },
            child: RefreshIndicator(
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
                                  start: DateTime.now()
                                      .subtract(Duration(days: 3)),
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
                              start: range?.start,
                            );
                      },
                      icon: Iconsax.timer_1_bold,
                      title: range == null
                          ? 'Last 24 hours'
                          : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
                    ),
                    TitleCard(title: 'Sessions'),
                    state.sessions.isEmpty
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 200),
                              child: Text(
                                'No Sessions'.toUpperCase(),
                                style: kBodyTitleTextStyle.copyWith(
                                    color: kGreyColor),
                              ),
                            ),
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                              color: kGreyColor.withOpacity(.2),
                              height: 20,
                              endIndent: 20,
                              indent: 20,
                            ),
                            itemBuilder: (_, i) =>
                                state.appState == AppState.loading
                                    ? LoadingShimmer(
                                        height: 80,
                                        radius: 8,
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
            ),
          ),
        );
      },
    );
  }
}
