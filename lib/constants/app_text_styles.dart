
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static var headerLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextColor(false),
  );
  
  static var headerMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextColor(false),
  );
  
  static var body = TextStyle(
    fontSize: 16.0,
    color: AppColors.getTextColor(false),
  );
}