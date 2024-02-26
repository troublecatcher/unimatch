import 'package:flutter/cupertino.dart';
import 'package:unimatch/const.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

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
                'Terms of use',
              ),
            ),
            SliverToBoxAdapter(
              child: Container(),
            ),
          ],
        ));
  }
}
