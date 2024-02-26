import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/db/university.dart';

List<Widget> universityStars(University university, Color color) {
  return [
    ...List.generate(
        6,
        (index) => SvgPicture.asset(
            'assets/icons/${index <= university.stars! ? '' : 'un'}star.svg',
            color: color)),
  ];
}
