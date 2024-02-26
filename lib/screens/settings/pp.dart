import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:unimatch/const.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: scaffoldColor,
        child: CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: scaffoldColor,
              largeTitle: Text(
                'Privacy Policy',
              ),
            ),
            SliverToBoxAdapter(
              child: Container(),
            ),
          ],
        ));
  }
}
