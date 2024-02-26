import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CustomContainer(
      {super.key,
      required this.children,
      this.color,
      this.padding,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? appPadding,
      decoration: BoxDecoration(
          color: color ?? Colors.white, borderRadius: appBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...children],
      ),
    );
  }
}
