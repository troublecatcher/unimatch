import 'package:flutter/cupertino.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/university.dart';

class UniversityLocation extends StatelessWidget {
  const UniversityLocation({
    super.key,
    required this.university,
    required this.textColor,
  });

  final University university;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(university.location, style: TextStyle(color: textColor));
  }
}
