import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/features/theme/cubit/theme_cubit.dart';

class LoadingShimmer extends StatelessWidget {
  final double height;
  final double radius;
  final double width;
  const LoadingShimmer(
      {super.key,
      this.height = 80,
      this.radius = 8,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FadeShimmer(
          height: height,
          width: width,
          radius: radius,
          fadeTheme: state.darkMode ? FadeTheme.dark : FadeTheme.light,
        );
      },
    );
  }
}
