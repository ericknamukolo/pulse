import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/events/cubit/events_cubit.dart';
import 'package:pulse/features/websites/models/website.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/loading_shimmer.dart';
import '../../../utils/colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/drop_down_btn.dart';
import '../../../widgets/title_card.dart';
import '../widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  final Website web;
  const EventsScreen({super.key, required this.web});

  @override
  State<EventsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<EventsScreen> {
  DateTimeRange? range;
  @override
  void initState() {
    context.read<EventsCubit>().getEvents(id: widget.web.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsCubit, EventsState>(
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
            context.read<EventsCubit>().getEvents(
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
                    context.read<EventsCubit>().getEvents(
                        id: widget.web.id,
                        end: range?.end,
                        start: range?.start);
                  },
                  icon: Iconsax.timer_1_bold,
                  title: range == null
                      ? 'Last 24 hours'
                      : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
                ),
                TitleCard(title: 'Events'),
                state.events.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 200),
                          child: Text(
                            'No Events'.toUpperCase(),
                            style:
                                kBodyTitleTextStyle.copyWith(color: kGreyColor),
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
                                ? LoadingShimmer()
                                : EventCard(event: state.events[i]),
                        itemCount: state.appState == AppState.loading
                            ? 6
                            : state.events.length,
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
