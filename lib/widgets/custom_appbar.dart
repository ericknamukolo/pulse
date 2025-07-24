import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/icon_btn.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLeading;
  final List<Widget> actions;
  final IconData? leading;
  final VoidCallback? leadingClick;

  const CustomAppBar({
    super.key,
    this.title,
    this.showLeading = true,
    this.actions = const [],
    this.leading,
    this.leadingClick,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      leadingWidth: showLeading ? 60 : 100,
      leading: showLeading
          ? Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: IconBtn(
                icon: leading == null ? Icons.chevron_left_rounded : leading!,
                click: leadingClick == null
                    ? () => Navigator.of(context).pop()
                    : leadingClick!,
              ),
            )
          : null,
      actions: actions,
      title: title == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                title!.toUpperCase(),
                style: kTitleTextStyle,
              ),
            ),
    );
  }
}
