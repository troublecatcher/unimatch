import 'package:flutter/material.dart';

class CupertinoText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CupertinoText(this.text, {super.key, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent, child: Text(text, style: textStyle));
  }
}
