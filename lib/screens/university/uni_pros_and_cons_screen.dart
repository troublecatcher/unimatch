import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unimatch/db/box.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/university/uni_specialties_screen.dart';
import 'package:unimatch/screens/university/uni_details_screen.dart';
import 'package:unimatch/widgets/common/text.dart';
import 'package:unimatch/widgets/common/custom_container_with_title_and_add_button.dart';
import 'package:unimatch/widgets/common/custom_text_field.dart';
import 'package:unimatch/db/university.dart';
import 'package:unimatch/widgets/common/custom_container.dart';

import '../../const.dart';

late ProsConsController prosConsController;
late TextEditingController prosController;
late TextEditingController consController;

class UniProsAndConsScreen extends StatefulWidget {
  final University university;
  final int? index;
  final Mode mode;
  const UniProsAndConsScreen(
      {super.key, required this.university, required this.mode, this.index});

  @override
  State<UniProsAndConsScreen> createState() => _UniProsAndConsScreenState();
}

class _UniProsAndConsScreenState extends State<UniProsAndConsScreen> {
  @override
  void initState() {
    super.initState();
    prosConsController = ProsConsController();
    prosController = TextEditingController();
    consController = TextEditingController();
    if (widget.mode == Mode.edit) {
      for (var element in widget.university.pros!) {
        prosConsController.pros.add(element);
      }
      for (var element in widget.university.cons!) {
        prosConsController.cons.add(element);
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
                  GetBuilder(
                    init: prosConsController,
                    builder: (_) {
                      return CustomContainerWithTitleAndAddButton(
                        title: 'Pros',
                        buttonTitle: 'Add',
                        children: [
                          CustomTextField(
                            placeholder: 'Pros name',
                            controller: prosController,
                            color: scaffoldColor,
                          ),
                          Column(
                            children: [
                              ...List.generate(
                                  prosConsController.pros.length,
                                  (index) => Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: itemPadding,
                                              child: CustomContainer(
                                                  color: scaffoldColor,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CupertinoText(
                                                            prosConsController
                                                                .pros[index]),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              prosConsController
                                                                  .deletePros(
                                                                      index),
                                                          child: const Icon(
                                                              Icons
                                                                  .delete_rounded,
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ))
                            ],
                          )
                        ],
                        callback: (_) {
                          if (prosController.text.isNotEmpty) {
                            prosConsController.createPros(prosController.text);
                            prosController.clear();
                          }
                        },
                      );
                    },
                  ),
                  GetBuilder(
                    init: prosConsController,
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: CustomContainerWithTitleAndAddButton(
                          title: 'Cons',
                          buttonTitle: 'Add',
                          children: [
                            CustomTextField(
                              placeholder: 'Cons name',
                              controller: consController,
                              color: scaffoldColor,
                            ),
                            Column(
                              children: [
                                ...List.generate(
                                    prosConsController.cons.length,
                                    (index) => Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: itemPadding,
                                                child: CustomContainer(
                                                    color: scaffoldColor,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CupertinoText(
                                                              prosConsController
                                                                  .cons[index]),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                prosConsController
                                                                    .deleteCons(
                                                                        index),
                                                            child: const Icon(
                                                                Icons
                                                                    .delete_rounded,
                                                                color:
                                                                    primaryColor),
                                                          ),
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ))
                              ],
                            )
                          ],
                          callback: (_) {
                            if (consController.text.isNotEmpty) {
                              prosConsController
                                  .createCons(consController.text);
                              consController.clear();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder(
                init: prosConsController,
                builder: (_) {
                  return CupertinoButton.filled(
                    onPressed: (prosConsController.pros.isEmpty &&
                            prosConsController.cons.isEmpty)
                        ? null
                        : () {
                            switch (widget.mode) {
                              case Mode.create:
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            UniSpecialtiesScreen(
                                                university: widget.university
                                                    .copyWith(
                                                        pros: prosConsController
                                                            .pros,
                                                        cons: prosConsController
                                                            .cons),
                                                mode: Mode.create)));
                                break;
                              case Mode.edit:
                                universitiesController.updateUniversity(
                                    widget.university.copyWith(
                                      pros: prosConsController.pros,
                                      cons: prosConsController.cons,
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

class ProsConsController extends GetxController {
  List<String> pros = [];
  List<String> cons = [];
  ProsConsController();

  createPros(String value) {
    pros.add(value);
    update();
  }

  deletePros(int index) {
    pros.removeAt(index);
    update();
  }

  createCons(String value) {
    cons.add(value);
    update();
  }

  deleteCons(int index) {
    cons.removeAt(index);
    update();
  }
}
