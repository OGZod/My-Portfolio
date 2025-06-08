import 'package:flutter/material.dart';

import '../constants/app_colors.dart';


class HeaderUnderline extends StatelessWidget {
  const HeaderUnderline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
