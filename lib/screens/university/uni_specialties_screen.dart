import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unimatch/db/box.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/db/specialty.dart';
import 'package:unimatch/db/university.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/university/uni_details_screen.dart';
import 'package:unimatch/widgets/common/custom_container_with_title_and_add_button.dart';
import 'package:unimatch/widgets/common/custom_container.dart';
import 'package:unimatch/widgets/common/custom_text_field.dart';
import 'package:unimatch/widgets/university/specialties_card.dart';

import '../../const.dart';
import '../../widgets/common/text.dart';

late SpeciatiesController speciatiesController;
late TextEditingController nameController;
late TextEditingController feesController;
late TextEditingController durationController;

class UniSpecialtiesScreen extends StatefulWidget {
  final University university;
  final int? index;
  final Mode mode;

  const UniSpecialtiesScreen(
      {super.key, required this.university, required this.mode, this.index});

  @override
  State<UniSpecialtiesScreen> createState() => _UniSpecialtiesScreenState();
}

class _UniSpecialtiesScreenState extends State<UniSpecialtiesScreen> {
  @override
  void initState() {
    super.initState();
    speciatiesController = SpeciatiesController();
    nameController = TextEditingController();
    feesController = TextEditingController();
    durationController = TextEditingController();
    if (widget.mode == Mode.edit) {
      for (var element in widget.university.specialties!) {
        speciatiesController.createSpecialty(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: scaffoldColor,
        border: null,
        previousPageTitle: 'Back',
        trailing: CupertinoText(widget.mode.title),
      ),
      child: SafeArea(
        child: Container(
          padding: appPadding,
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomContainerWithTitleAndAddButton(
                      title: 'List of specialties',
                      buttonTitle: 'Add',
                      callback: (_) {
                        if (nameController.text != '' &&
                            feesController.text != '' &&
                            durationController.text != '') {
                          speciatiesController.createSpecialty(Specialty(
                            name: nameController.text,
                            priority: speciatiesController.priority,
                            fees: int.parse(feesController.text),
                            duration: int.parse(durationController.text),
                          ));
                          nameController.clear();
                          feesController.clear();
                          durationController.clear();
                          speciatiesController.changePriority(0);
                        }
                      }),
                  CustomContainer(color: Colors.white, children: [
                    CustomTextField(
                        placeholder: 'Name of the specialization',
                        controller: nameController,
                        color: scaffoldColor),
                    const Material(child: Text('Priority')),
                    const SizedBox(height: 10),
                    GetBuilder(
                        init: speciatiesController,
                        builder: (_) {
                          return Row(
                            children: [
                              ...List.generate(3, (index) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: CupertinoButton(
                                        borderRadius: appBorderRadius,
                                        color: speciatiesController.priority ==
                                                index
                                            ? primaryColor
                                            : CupertinoColors
                                                .quaternarySystemFill,
                                        padding: EdgeInsets.zero,
                                        child: Text(toHumanLanguage(index),
                                            style: TextStyle(
                                              color: speciatiesController
                                                          .priority ==
                                                      index
                                                  ? Colors.white
                                                  : greyColor,
                                            )),
                                        onPressed: () {
                                          speciatiesController
                                              .changePriority(index);
                                        }),
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                    const SizedBox(height: 10),
                    CustomTextField(
                      placeholder: 'Tuition fees (\$)',
                      controller: feesController,
                      color: scaffoldColor,
                      textInputType: TextInputType.number,
                    ),
                    CustomTextField(
                      placeholder: 'Duration of study (years)',
                      controller: durationController,
                      color: scaffoldColor,
                      textInputType: TextInputType.number,
                    ),
                  ]),
                  const SizedBox(height: 10),
                  GetBuilder(
                      init: speciatiesController,
                      builder: (_) {
                        return Column(children: [
                          ...List.generate(
                              speciatiesController.specialties.length, (index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Column(
                                  children: [
                                    SpecialtiesCard(
                                      name: speciatiesController
                                          .specialties[index].name,
                                      priority: speciatiesController
                                          .specialties[index].priority,
                                      fees: speciatiesController
                                          .specialties[index].fees,
                                      duration: speciatiesController
                                          .specialties[index].duration,
                                      mode: Mode.edit,
                                      index: index,
                                    ),
                                  ],
                                ));
                          }),
                        ]);
                      }),
                  const SizedBox(height: 60),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder(
                init: speciatiesController,
                builder: (_) {
                  return CupertinoButton.filled(
                    onPressed: (speciatiesController.specialties.isEmpty)
                        ? null
                        : () {
                            switch (widget.mode) {
                              case Mode.create:
                                universitiesController.createUniversity(
                                    widget.university.copyWith(
                                        specialties:
                                            speciatiesController.specialties));
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                break;
                              case Mode.edit:
                                universitiesController.updateUniversity(
                                    widget.university.copyWith(
                                      specialties:
                                          speciatiesController.specialties,
                                    ),
                                    widget.index!);
                                final newUni = uniBox.getAt(widget.index!);
                                Navigator.of(context)
                                  ..pop()
                                  ..pop()
                                  ..push(CupertinoPageRoute(
                                      builder: (context) => UniDetailsScreen(
                                          university: newUni,
                                          index: widget.index!)));
                                break;
                              default:
                            }
                          },
                    child: Text(widget.mode.buttonTitle),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class SpeciatiesController extends GetxController {
  final List<Specialty> specialties = [];
  int priority = 0;

  SpeciatiesController();

  changePriority(int value) {
    priority = value;
    update();
  }

  createSpecialty(Specialty specialty) {
    specialties.add(specialty);
    update();
  }

  deleteSpecialty(int index) {
    specialties.removeAt(index);
    update();
  }
}

toHumanLanguage(int value) {
  switch (value) {
    case 0:
      return 'First';
    case 1:
      return 'Second';
    case 2:
      return 'Third';
    default:
  }
}
