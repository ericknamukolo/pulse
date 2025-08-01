import 'package:country_flags/country_flags.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:icons_launcher/cli_commands.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/events/widgets/event_card.dart';
import 'package:pulse/features/overview/widgets/stat_card.dart';
import 'package:pulse/features/sessions/cubit/sessions_cubit.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/features/sessions/repo/sessions_repo.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/extensions.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:country_codes/country_codes.dart';
import 'package:pulse/widgets/title_card.dart';

import '../../../widgets/drop_down_btn.dart';

class SessionDetailsScreen extends StatefulWidget {
  final Session session;
  const SessionDetailsScreen({super.key, required this.session});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  Session? _session;
  DateTimeRange? range;

  @override
  void initState() {
    context.read<SessionsCubit>().getSessionEvents(
          websiteId: widget.session.websiteId,
          id: widget.session.id,
        );
    Future.delayed(Duration.zero).then((_) async {
      try {
        var res = await SessionsRepo()
            .getSession(widget.session.websiteId, widget.session.id);

        setState(() {
          _session = res;
        });
      } catch (e, st) {
        logger.i(st);
        Toast.showToast(message: e.toString(), context: context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session'),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Hero(
                tag: widget.session.id,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: BoringAvatar(
                          name: widget.session.id,
                          type: BoringAvatarType.beam,
                          shape: CircleBorder(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CountryFlag.fromCountryCode(
                          widget.session.country,
                          shape: const RoundedRectangle(30),
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                spacing: 15,
                children: [
                  Expanded(
                    child: StatCard(
                      stat: MapEntry(
                          'views', {'value': widget.session.views, 'prev': -1}),
                    ),
                  ),
                  Expanded(
                    child: StatCard(
                      stat: MapEntry('visits',
                          {'value': widget.session.visits, 'prev': -1}),
                    ),
                  )
                ],
              ),
              _session == null
                  ? FadeShimmer(
                      height: 100,
                      width: double.infinity,
                      radius: 16,
                      fadeTheme: FadeTheme.light,
                    )
                  : Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: StatCard(
                            stat: MapEntry('events',
                                {'value': _session!.events, 'prev': -1}),
                          ),
                        ),
                        Expanded(
                          child: StatCard(
                            stat: MapEntry('totaltime',
                                {'value': _session!.totaltime, 'prev': -1}),
                          ),
                        )
                      ],
                    ),
              getData(
                title: 'First Seen',
                icon: Icon(
                  Icons.timer_rounded,
                  color: kPrimaryColor.withOpacity(.8),
                  size: 18,
                ),
                des:
                    '${DateFormat('EEE, MMM d y').format(widget.session.firstAt.toLocal())} at ${DateFormat('HH:mm').format(widget.session.firstAt.toLocal())} hrs',
              ),
              getData(
                title: 'Last Seen',
                icon: Icon(
                  Icons.timer_rounded,
                  color: kPrimaryColor.withOpacity(.8),
                  size: 18,
                ),
                des:
                    '${DateFormat('EEE, MMM d y').format(widget.session.lastAt.toLocal())} at ${DateFormat('HH:mm').format(widget.session.lastAt.toLocal())} hrs',
              ),
              getData(
                title: 'Region',
                icon: Icon(
                  Icons.pin_drop_rounded,
                  color: kPrimaryColor.withOpacity(.8),
                  size: 18,
                ),
                des:
                    '${CountryCodes.name(locale: Locale(widget.session.language, widget.session.country))}, ${widget.session.city}',
              ),
              getData(
                title: 'Device',
                icon: Icon(
                  widget.session.device.toDeviceIcon,
                  color: kPrimaryColor.withOpacity(.8),
                  size: 18,
                ),
                des: widget.session.device.capitalize(),
              ),
              getData(
                title: 'OS',
                icon: Brand(
                  widget.session.os.toLowerCase().toOsIcon,
                  size: 18,
                ),
                des: widget.session.os.capitalize(),
              ),
              getData(
                title: 'Browser',
                icon: Brand(
                  widget.session.browser.toLowerCase().toBrowserIcon,
                  size: 18,
                ),
                des: widget.session.browser.capitalize(),
              ),
              TitleCard(title: 'Recent Activity'),
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
                  context.read<SessionsCubit>().getSessionEvents(
                        websiteId: widget.session.websiteId,
                        id: widget.session.id,
                        end: range?.end,
                        start: range?.start,
                      );
                },
                icon: Iconsax.timer_1_bold,
                title: range == null
                    ? 'Last 24 hours'
                    : 'From ${DateFormat('EEE, MMM dd, yyyy').format(range!.start)} - ${DateFormat('EEE, MMM dd, yyyy').format(range!.end)}',
              ),
              BlocConsumer<SessionsCubit, SessionsState>(
                listener: (context, state) {
                  if (state.appState == AppState.error) {
                    Toast.showToast(
                      message: state.errorMessage ?? 'An error occurred',
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  return ListView.separated(
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
                        : EventCard(event: state.events[i]),
                    itemCount: state.appState == AppState.loading
                        ? 6
                        : state.events.length,
                    shrinkWrap: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column getData({
    required String title,
    required String des,
    Widget? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: kBodyTitleTextStyle.copyWith(fontWeight: FontWeight.bold)),
        Row(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) icon,
            Text(
              des,
              style: kBodyTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
