import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final double bottomSpacing;
  final VoidCallback? seeAll;
  const TitleCard({
    super.key,
    required this.title,
    this.seeAll,
    this.bottomSpacing = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: kBodyTextStyle.copyWith(
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(height: bottomSpacing),
            ],
          ),
          const Spacer(),
          if (seeAll != null)
            TextButton(
                onPressed: seeAll,
                child: Text('See All',
                    style: kBodyTitleTextStyle.copyWith(color: kPrimaryColor)))
        ],
      ),
    );
  }
}
