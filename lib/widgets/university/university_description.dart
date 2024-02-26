import 'package:flutter/cupertino.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/university.dart';

class UniversityDescription extends StatelessWidget {
  const UniversityDescription({
    super.key,
    required this.university,
    required this.textColor,
  });

  final University university;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(university.description == null ? '' : university.description!,
        style: TextStyle(color: textColor));
  }
}
