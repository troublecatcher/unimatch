import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/university.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/university/uni_main_info_screen.dart';
import 'package:unimatch/screens/university/uni_pros_and_cons_screen.dart';
import 'package:unimatch/screens/university/uni_specialties_screen.dart';
import 'package:unimatch/widgets/common/custom_container.dart';
import 'package:unimatch/widgets/common/custom_container_with_title.dart';
import 'package:unimatch/widgets/university/specialties_card.dart';
import 'package:unimatch/widgets/university/university_description.dart';
import 'package:unimatch/widgets/university/university_location.dart';
import 'package:unimatch/widgets/university/university_name.dart';
import 'package:unimatch/widgets/university/university_stars.dart';

class UniDetailsScreen extends StatelessWidget {
  final University university;
  final int index;

  const UniDetailsScreen(
      {super.key, required this.university, required this.index});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: scaffoldColor,
        border: null,
        middle: const Text('University'),
        previousPageTitle: 'Back',
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('Edit'),
            onPressed: () {
              showEditModal(context);
            }),
      ),
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Padding(
              padding: appPadding,
              child: Column(
                children: [
                  CustomContainer(
                    color: primaryColor,
                    children: [
                      Column(
                        children: [
                          UniversityName(
                            university: university,
                            iconColor: Colors.white.withOpacity(0.5),
                            textColor: Colors.white,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          UniversityLocation(
                              university: university,
                              textColor: Colors.white.withOpacity(0.5)),
                          UniversityDescription(
                              university: university,
                              textColor: Colors.white.withOpacity(0.5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: universityStars(university, Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomContainerWithTitle(
                    title: 'Pros',
                    children: List.generate(
                        university.pros!.length,
                        (index) => CustomContainer(
                              margin: const EdgeInsets.only(bottom: 8),
                              color: scaffoldColor,
                              children: [
                                Row(
                                  children: [
                                    Text(university.pros![index]),
                                  ],
                                ),
                              ],
                            )),
                  ),
                  CustomContainerWithTitle(
                    title: 'Cons',
                    children: List.generate(
                        university.cons!.length,
                        (index) => CustomContainer(
                              margin: const EdgeInsets.only(bottom: 8),
                              color: scaffoldColor,
                              children: [
                                Row(
                                  children: [
                                    Text(university.cons![index]),
                                  ],
                                )
                              ],
                            )),
                  ),
                  CustomContainerWithTitle(
                    title: 'Specialties',
                    children: List.generate(
                        university.specialties!.length,
                        (index) => SpecialtiesCard(
                            name: university.specialties![index].name,
                            priority: university.specialties![index].priority,
                            fees: university.specialties![index].fees,
                            duration: university.specialties![index].duration,
                            mode: Mode.idle)),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showEditModal(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      showEditEditModal(context);
                    },
                    child: const Text('Edit')),
                CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                      showAlertDialog(context);
                    },
                    child: const Text('Delete'))
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ));
  }

  showEditEditModal(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UniMainInfoScreen(
                                    university: university,
                                    mode: Mode.edit,
                                    index: index,
                                  )));
                    },
                    child: const Text('Main info')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UniProsAndConsScreen(
                                    university: university,
                                    mode: Mode.edit,
                                    index: index,
                                  )));
                    },
                    child: const Text('Pros and Cons')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => UniSpecialtiesScreen(
                                    university: university,
                                    mode: Mode.edit,
                                    index: index,
                                  )));
                    },
                    child: const Text('Specialties'))
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ));
  }

  showAlertDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: ((BuildContext context) => CupertinoAlertDialog(
              title: const Text('Delete university?'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Yes'),
                  onPressed: () {
                    universitiesController.deleteUniversity(index);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            )));
  }
}
