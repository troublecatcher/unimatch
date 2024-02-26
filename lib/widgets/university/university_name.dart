import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/university.dart';

class UniversityName extends StatelessWidget {
  const UniversityName({
    super.key,
    required this.university,
    required this.textColor,
    required this.iconColor,
    this.mainAxisAlignment,
  });

  final University university;
  final Color textColor;
  final Color iconColor;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/icons/edu.svg', color: iconColor),
        const SizedBox(width: 10),
        Text(university.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: textColor)),
      ],
    );
  }
}
