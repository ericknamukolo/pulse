import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/features/events/models/event.dart';
import 'package:intl/intl.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';
import '../../../widgets/container_wrapper.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    bool isEvent = event.eventName.isNotEmpty;
    return ContainerWrapper(
      padding: 12.0,
      child: Row(
        spacing: 15,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: BoringAvatar(
              name: event.sessionId,
              type: BoringAvatarType.beam,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                spacing: 4,
                children: [
                  Icon(
                    isEvent ? Icons.bolt_rounded : Bootstrap.eye_fill,
                    color: kGreyColor.withOpacity(.5),
                    size: 20,
                  ),
                  Text('${isEvent ? 'Triggered event' : 'Viewed page'} - ',
                      style: kBodyTitleTextStyle),
                  Text(
                    isEvent ? event.eventName : event.urlPath,
                    style: kBodyTitleTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                '${DateFormat('EEE, MMM d y').format(event.createdAt)} at ${DateFormat('HH:mm').format(event.createdAt)} hrs',
                style: kBodyTitleTextStyle.copyWith(color: kGreyColor),
              )
            ],
          )
        ],
      ),
    );
  }
}
