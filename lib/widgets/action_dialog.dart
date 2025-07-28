import 'package:pulse/utils/text.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'custom_button.dart';

class ActionDialog extends StatefulWidget {
  final String title;
  final String des;
  final Function() fn;
  final IconData icon;
  final Widget? child;

  final Color color;
  final Color? btnColor;
  final String? btnText;
  const ActionDialog({
    super.key,
    required this.fn,
    required this.title,
    required this.des,
    required this.color,
    required this.icon,
    this.btnColor,
    this.btnText,
    this.child,
  });

  @override
  State<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withOpacity(.2),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: 28,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: kTitleTextStyle.copyWith(
                              fontSize: 16, color: Colors.black87)),
                      SizedBox(height: 5),
                      Text(widget.des,
                          style: kTitleTextStyle.copyWith(
                              fontSize: 14,
                              color: kGreyColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (widget.child != null) widget.child!,
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: kBodyTextStyle.copyWith(
                            color: kErrorColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: CustomButton(
                      isLoading: _isLoading,
                      btnText: widget.btnText ??
                          'Yes, ${widget.title.split(' ').first}',
                      click: () async {
                        setState(() => _isLoading = true);
                        try {
                          await widget.fn();
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
