import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/screens/settings/pp.dart';
import 'package:unimatch/screens/settings/tou.dart';

bool isAbleToCallShareWindow = true;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                'Settings',
              ),
            ),
            SliverToBoxAdapter(
              child: CupertinoListSection(
                backgroundColor: Colors.transparent,
                children: [
                  Builder(builder: (ctx) {
                    return CupertinoListTile(
                      title: const Text('Share with friends'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: primaryColor),
                      onTap: () async {
                        if (isAbleToCallShareWindow) {
                          isAbleToCallShareWindow = false;
                          final box = ctx.findRenderObject() as RenderBox?;
                          await Share.shareWithResult(
                            'Check out UniMatch!',
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size,
                          ).whenComplete(() => isAbleToCallShareWindow = true);
                        }
                      },
                    );
                  }),
                  CupertinoListTile(
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: primaryColor),
                    onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                            builder: (context) => const PrivacyPolicyScreen())),
                  ),
                  CupertinoListTile(
                    title: const Text('Terms of use'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: primaryColor),
                    onTap: () => Navigator.of(context).push(
                        CupertinoPageRoute<void>(
                            builder: (context) => const TermsOfUseScreen())),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
