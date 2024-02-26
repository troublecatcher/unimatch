import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unimatch/db/box.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/settings/settings_screen.dart';
import 'package:unimatch/screens/university/uni_main_info_screen.dart';
import 'package:unimatch/db/university.dart';
import 'package:unimatch/screens/university/uni_details_screen.dart';
import 'package:unimatch/widgets/common/custom_container.dart';
import 'package:unimatch/widgets/university/university_location.dart';
import 'package:unimatch/widgets/university/university_name.dart';
import 'package:unimatch/widgets/university/university_stars.dart';

final universitiesController = UniversitiesController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: scaffoldColor,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: scaffoldColor,
              leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const SettingsScreen())),
                  child: const Text('Settings')),
              largeTitle: const Text(
                'Your education',
              ),
            ),
            GetBuilder(
              init: universitiesController,
              builder: (_) {
                return SliverList.builder(
                    itemCount: uniBox.length,
                    itemBuilder: (context, index) {
                      University university = uniBox.getAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => UniDetailsScreen(
                                      university: university, index: index))),
                          child:
                              CustomContainer(color: Colors.white, children: [
                            CupertinoListTile(
                              padding: const EdgeInsets.all(10),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UniversityName(
                                    university: university,
                                    iconColor: primaryColor,
                                    textColor: primaryColor.withOpacity(0.5),
                                  ),
                                  UniversityLocation(
                                      university: university,
                                      textColor: greyColor),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    universityStars(university, primaryColor),
                              ),
                              additionalInfo: const Text('Open',
                                  style: TextStyle(color: primaryColor)),
                              trailing: SvgPicture.asset(
                                  'assets/icons/forward.svg',
                                  color: primaryColor),
                            ),
                          ]),
                        ),
                      );
                    });
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: CupertinoButton.filled(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.add), Text('Add new university')],
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const UniMainInfoScreen(
                                  mode: Mode.create))))),
            ),
          ],
        ));
  }
}

class UniversitiesController extends GetxController {
  createUniversity(University university) {
    uniBox.put(university.name, university);
    update();
  }

  updateUniversity(University university, int index) {
    uniBox.putAt(index, university);
    update();
  }

  deleteUniversity(int index) {
    uniBox.deleteAt(index);
    update();
  }
}
