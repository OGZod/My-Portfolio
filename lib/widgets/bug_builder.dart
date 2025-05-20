
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

Widget bugBuilder(FlutterErrorDetails details) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SvgPicture.asset(
            'assets/svg/bug.svg',
          ),
        ),
        Text(
          'Oops...an unknown error occurred!!!',
        ),
        SizedBox(
          height: 100,
        )
      ],
    ),
  );
}
