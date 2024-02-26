import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/box.dart';
import 'package:unimatch/screens/home_screen.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/university/uni_pros_and_cons_screen.dart';
import 'package:unimatch/screens/university/uni_details_screen.dart';
import 'package:unimatch/widgets/common/text.dart';
import 'package:unimatch/widgets/common/custom_text_field.dart';
import 'package:unimatch/db/university.dart';
import 'package:unimatch/widgets/common/custom_container.dart';

late StarsController starsController;
late TextEditingController nameController;
late TextEditingController locationController;
late TextEditingController descriptionController;

class UniMainInfoScreen extends StatefulWidget {
  const UniMainInfoScreen(
      {super.key, this.university, required this.mode, this.index});

  final University? university;
  final Mode mode;
  final int? index;

  @override
  State<UniMainInfoScreen> createState() => _UniMainInfoScreenState();
}

class _UniMainInfoScreenState extends State<UniMainInfoScreen> {
  @override
  void initState() {
    super.initState();
    starsController = StarsController();
    nameController = TextEditingController(
        text: widget.university == null ? '' : widget.university!.name);
    locationController = TextEditingController(
        text: widget.university == null ? '' : widget.university!.location);
    descriptionController = TextEditingController(
        text: widget.university == null ? '' : widget.university!.description);
    if (widget.mode == Mode.edit) {
      starsController.updateStars(widget.university!.stars!);
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
            Column(
              children: [
                CustomTextField(
                    placeholder: 'University name', controller: nameController),
                CustomTextField(
                    placeholder: 'University location',
                    controller: locationController),
                CustomTextField(
                    placeholder: 'Description of the University',
                    controller: descriptionController,
                    maxLines: 10),
                CustomContainer(
                  children: [
                    const Row(
                      children: [
                        Material(child: Text('Rating of university reviews')),
                      ],
                    ),
                    GetBuilder(
                        init: starsController,
                        builder: (_) {
                          return Row(
                            children: [
                              ...List.generate(6, (index) {
                                return GestureDetector(
                                  onTap: () =>
                                      starsController.updateStars(index),
                                  child: SvgPicture.asset(
                                    'assets/icons/${index <= starsController.stars ? '' : 'un'}star.svg',
                                    color: primaryColor,
                                    width: 30,
                                    height: 30,
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder(
                init: starsController,
                builder: (_) {
                  return CupertinoButton.filled(
                    onPressed: (nameController.text != '' &&
                            locationController.text != '' &&
                            starsController.stars != -1)
                        ? () {
                            switch (widget.mode) {
                              case Mode.create:
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            UniProsAndConsScreen(
                                                university: University(
                                                  name: nameController.text,
                                                  location:
                                                      locationController.text,
                                                  description:
                                                      descriptionController
                                                          .text,
                                                  stars: starsController.stars,
                                                ),
                                                mode: Mode.create)));
                                break;
                              case Mode.edit:
                                universitiesController.updateUniversity(
                                    widget.university!.copyWith(
                                      name: nameController.text,
                                      location: locationController.text,
                                      description: descriptionController.text,
                                      stars: starsController.stars,
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
                          }
                        : null,
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

class StarsController extends GetxController {
  int stars = -1;

  StarsController();

  updateStars(int value) {
    stars = value;
    update();
  }
}
