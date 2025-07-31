import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/utils/utils.dart';
import 'package:pulse/widgets/container_wrapper.dart';

import '../../../widgets/icon_btn.dart';

class SessionCard extends StatelessWidget {
  final Session session;
  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ContainerWrapper(
      child: Row(
        spacing: 15,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: BoringAvatar(
                  name: session.id,
                  type: BoringAvatarType.beam,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                right: -5,
                child: CountryFlag.fromCountryCode(
                  session.country,
                  shape: const RoundedRectangle(30),
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${session.country}, ${session.city} -- ${session.os}',
                  style: kBodyTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${DateFormat('EEE, MMM d y').format(session.createdAt.toLocal())} at ${DateFormat('HH:mm').format(session.createdAt.toLocal())} hrs',
                  style: kBodyTextStyle,
                ),
              ],
            ),
          ),
          IconBtn(
            bRadius: 100,
            icon: Icons.remove_red_eye_rounded,
            click: () {
              Toast.showToast(message: 'Coming Soon', context: context);
            },
            iconColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
