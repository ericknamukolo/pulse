import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:icons_launcher/cli_commands.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/overview/widgets/stat_card.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/custom_appbar.dart';
import 'package:country_codes/country_codes.dart';

class SessionDetailsScreen extends StatelessWidget {
  final Session session;
  const SessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Session'),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Hero(
              tag: session.id,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: BoringAvatar(
                        name: session.id,
                        type: BoringAvatarType.beam,
                        shape: CircleBorder(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CountryFlag.fromCountryCode(
                        session.country,
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
                    stat:
                        MapEntry('views', {'value': session.views, 'prev': -1}),
                  ),
                ),
                Expanded(
                  child: StatCard(
                    stat: MapEntry(
                        'visits', {'value': session.visits, 'prev': -1}),
                  ),
                )
              ],
            ),
            getData(
              title: 'First Seen',
              des:
                  '${DateFormat('EEE, MMM d y').format(session.firstAt.toLocal())} at ${DateFormat('HH:mm').format(session.firstAt.toLocal())} hrs',
            ),
            getData(
              title: 'Last Seen',
              des:
                  '${DateFormat('EEE, MMM d y').format(session.lastAt.toLocal())} at ${DateFormat('HH:mm').format(session.lastAt.toLocal())} hrs',
            ),
            getData(
              title: 'Region',
              des:
                  '${CountryCodes.name(locale: Locale(session.language, session.country))}, ${session.city}',
            ),
            getData(
              title: 'Device',
              des: session.device.capitalize(),
            ),
            getData(
              title: 'OS',
              des: session.os.capitalize(),
            ),
            getData(
              title: 'Browser',
              des: session.browser.capitalize(),
            ),
          ],
        ),
      ),
    );
  }

  Column getData({
    required String title,
    required String des,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: kBodyTitleTextStyle.copyWith(fontWeight: FontWeight.bold)),
        Text(
          des,
          style: kBodyTextStyle,
        ),
      ],
    );
  }
}
