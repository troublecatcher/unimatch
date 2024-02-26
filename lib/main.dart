import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unimatch/db/specialty.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/db/university.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:unimatch/screens/onboarding.dart';

import 'db/box.dart';

bool firstRun = true;

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UniversityAdapter());
  Hive.registerAdapter(SpecialtyAdapter());
  uniBox = await Hive.openBox<University>('uniBox');
  firstRun = await IsFirstRun.isFirstRun();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: firstRun ? const OnboardingScreen() : const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
