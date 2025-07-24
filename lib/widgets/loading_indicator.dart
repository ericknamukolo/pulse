import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final Color spinnerColor;
  const LoadingIndicator({
    super.key,
    this.spinnerColor = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          strokeWidth: 1.8,
          color: spinnerColor,
        ),
      ),
    );
  }
}
