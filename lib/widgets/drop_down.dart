// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pulse/utils/colors.dart';
import 'package:pulse/utils/text.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.preIcon,
    this.fillColor = Colors.white,
    this.title,
    this.removePadding = false,
    this.isRequired = false,
    this.maxHeight = 50,
  });

  final String? selectedItem;
  final String hint;
  final String? title;
  final Function(String?) onChanged;
  final List<String> items;
  final IconData? preIcon;
  final Color? fillColor;
  final double? maxHeight;
  final bool removePadding;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(title!, style: kBodyTitleTextStyle),
              ),
            ],
          ),
        Container(
          margin: EdgeInsets.only(
              bottom: removePadding ? 0 : 15.0, top: title == null ? 0.0 : 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: maxHeight,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: kGreyColor.withOpacity(.3), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Visibility(
                visible: preIcon != null,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    preIcon,
                    color: kGreyColor,
                  ),
                ),
              ),
              Expanded(
                child: DropdownButton(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: kGreyColor,
                  ),
                  value: selectedItem,
                  hint: Text(hint, style: kHintTextStyle),
                  isExpanded: true,
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: kBodyTitleTextStyle.copyWith(
                          color: value == selectedItem
                              ? kPrimaryColor
                              : kGreyColor.withOpacity(.8),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
