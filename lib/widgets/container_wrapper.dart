import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';

import '../utils/utils.dart';

class ContainerWrapper extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double padding;
  final double bRadius;

  const ContainerWrapper({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.padding = 15.0,
    this.height,
    this.bRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(bRadius),
          boxShadow: shadows,
          border: Border.all(
            color: kGreyColor.withOpacity(.09),
            width: 2.0,
          )),
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: child,
    );
  }
}
