import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';

class CustomContainerWithTitleAndAddButton extends StatelessWidget {
  final String title;
  final List<Widget>? children;
  final String? buttonTitle;
  final Function(dynamic)? callback;

  const CustomContainerWithTitleAndAddButton(
      {super.key,
      required this.title,
      this.children,
      this.callback,
      this.buttonTitle});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(child: Text(title)),
                ),
                if (callback != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => callback!(1),
                      child: Text(buttonTitle!),
                    ),
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
