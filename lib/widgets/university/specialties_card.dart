import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/mode.dart';
import 'package:unimatch/screens/university/uni_specialties_screen.dart';
import 'package:unimatch/widgets/common/custom_container.dart';
import 'package:unimatch/widgets/common/text.dart';

class SpecialtiesCard extends StatelessWidget {
  const SpecialtiesCard({
    super.key,
    required this.name,
    required this.priority,
    required this.fees,
    required this.duration,
    required this.mode,
    this.index,
  });

  final String name;
  final int priority;
  final int fees;
  final int duration;
  final Mode mode;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.white,
      children: [
        CustomContainer(
          color: primaryColor.withOpacity(0.15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CupertinoText(name),
                    CustomContainer(
                        padding: const EdgeInsets.all(8),
                        color: primaryColor.withOpacity(0.15),
                        children: [CupertinoText(toHumanLanguage(priority))])
                  ],
                ),
                if (mode != Mode.idle)
                  GestureDetector(
                    onTap: () => speciatiesController.deleteSpecialty(index!),
                    child:
                        const Icon(Icons.delete_rounded, color: primaryColor),
                  ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        CustomContainer(
          color: scaffoldColor,
          children: [
            Row(
              children: [
                CupertinoText('\$$fees'),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        CustomContainer(
          color: scaffoldColor,
          children: [
            Row(
              children: [
                CupertinoText('$duration years'),
              ],
            )
          ],
        ),
      ],
    );
  }
}
