import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../utils/text.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String? title;
  final IconData? preIcon;
  final String? prefixText;
  final IconButton? suffIcon;
  final bool ac;
  final bool disabled;
  final TextCapitalization tc;
  final int? lines;
  final List<TextInputFormatter>? formatters;
  final TextInputType? type;
  final bool obs;
  final TextEditingController? data;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String?)? onSubmit;
  final double? bottomSpace;

  final TextInputAction? action;
  const CustomTextField({
    super.key,
    required this.hint,
    this.preIcon,
    this.title,
    this.prefixText,
    this.bottomSpace = 15,
    this.data,
    this.lines = 1,
    this.onChanged,
    this.ac = true,
    this.disabled = false,
    this.obs = false,
    this.suffIcon,
    this.tc = TextCapitalization.none,
    this.type,
    this.validator,
    this.formatters,
    this.action,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomSpace!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: title != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(title ?? '', style: kBodyTitleTextStyle),
            ),
          ),
          TextFormField(
            enabled: !disabled,
            onFieldSubmitted: onSubmit,
            inputFormatters: formatters,
            validator: validator,
            onChanged: onChanged,
            controller: data,
            obscureText: obs,
            autocorrect: ac,
            textCapitalization: tc,
            keyboardType: type,
            textAlignVertical: TextAlignVertical.center,
            style: kBodyTextStyle,
            cursorColor: kPrimaryColor,
            maxLines: lines,
            textInputAction: action,
            decoration: InputDecoration(
              prefixText: prefixText,
              filled: true,
              fillColor: const Color(0xffF5F9FE),
              border: InputBorder.none,
              errorStyle:
                  kBodyTextStyle.copyWith(fontSize: 10, color: kErrorColor),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: preIcon == null ? 10 : 0.0),
              prefixStyle: kBodyTextStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  width: 1.5,
                  color: kGreyColor.withOpacity(.09),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 1.5,
                  color: kPrimaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  style: BorderStyle.solid,
                  width: 1.5,
                  color: kErrorColor,
                ),
              ),
              hintText: hint,
              hintStyle: kHintTextStyle,
              prefixIcon: preIcon == null
                  ? null
                  : Icon(
                      preIcon,
                      color: kGreyColor.withOpacity(.25),
                    ),
              suffixIcon: suffIcon,
            ),
          ),
        ],
      ),
    );
  }
}
