import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/screens/settings/pp.dart';
import 'package:unimatch/screens/settings/tou.dart';

late PageController pageController;
int page = 0;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/onboarding/icon.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'UniMatch',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    )
                  ],
                )),
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Add the appropriate educational institutions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                              fontSize: 24),
                        ),
                        Text(
                          'Add the universities that interest you for admission and highlight key information about them.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: primaryColor.withOpacity(0.5),
                              fontSize: 16),
                        ),
                        Image.asset('assets/onboarding/1.png',
                            width: MediaQuery.of(context).size.width - 50,
                            height: MediaQuery.of(context).size.width - 50),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose the most suitable university',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                              fontSize: 24),
                        ),
                        Text(
                          'Analyze the conditions of all universities and choose the most suitable option for you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: primaryColor.withOpacity(0.5),
                              fontSize: 16),
                        ),
                        Image.asset('assets/onboarding/2.png',
                            width: MediaQuery.of(context).size.width - 50,
                            height: MediaQuery.of(context).size.width - 50),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton.filled(
                    child: Text(page == 0 ? 'Next' : 'Get started'),
                    onPressed: () {
                      if (page != 1) {
                        setState(() {
                          page++;
                          pageController.animateToPage(page,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                        });
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        child: Text('Terms of use'),
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => TermsOfUseScreen()))),
                    const Text(' / ', style: TextStyle(color: primaryColor)),
                    CupertinoButton(
                        child: Text('Privacy Policy'),
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => PrivacyPolicyScreen()))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
