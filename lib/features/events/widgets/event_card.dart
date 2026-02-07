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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (event.sessionId != null)
            SizedBox(
              width: 50,
              height: 50,
              child: BoringAvatar(
                name: event.sessionId!,
                type: BoringAvatarType.beam,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isEvent ? Icons.bolt_rounded : Bootstrap.eye_fill,
                      color: kGreyColor.withOpacity(.5),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${isEvent ? 'event' : 'view'} - ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextSpan(
                              text: isEvent ? event.eventName : event.urlPath,
                              style: kBodyTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('EEE, MMM d y').format(event.createdAt.toLocal())} at ${DateFormat('HH:mm').format(event.createdAt.toLocal())} hrs',
                  style: kBodyTextStyle,
                ),
              ],
            ),
          ),
          // IconBtn(
          //   bRadius: 100,
          //   icon: Icons.remove_red_eye_rounded,
          //   click: () {},
          //   iconColor: kPrimaryColor,
          // ),
        ],
      ),
    );
  }
}
