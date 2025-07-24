import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ContainerWrapper extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double padding;
  final Color? color;
  final Color? borderColor;
  const ContainerWrapper({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.padding = 15.0,
    this.color,
    this.borderColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: borderColor ?? kGreyColor.withOpacity(.2),
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: child,
    );
  }
}
