import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/screens/university/uni_main_info_screen.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final int? maxLines;
  final Color? color;
  final TextInputType? textInputType;

  const CustomTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.maxLines,
    this.color,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding,
      child: CupertinoTextField(
        keyboardType: textInputType,
        onChanged: (_) => starsController.update(),
        controller: controller,
        decoration: BoxDecoration(
            border: null,
            borderRadius: appBorderRadius,
            color: color ?? Colors.white),
        padding: appPadding,
        placeholder: placeholder,
        minLines: 1,
        maxLines: maxLines ?? 1,
      ),
    );
  }
}
