import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';

class CustomContainerWithTitle extends StatelessWidget {
  final String title;
  final List<Widget>? children;

  const CustomContainerWithTitle(
      {super.key, required this.title, this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding,
      child: Container(
        padding: appPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: appBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(child: Text(title)),
                ),
              ],
            ),
            if (children != null)
              Column(
                children: [...children!],
              )
          ],
        ),
      ),
    );
  }
}
