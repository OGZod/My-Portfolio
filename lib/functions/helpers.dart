import 'package:flutter/material.dart';

enum LayoutType { mobile, tablet, desktop }

class ResponsiveUtils {

  static const double mobileBreakpoint = 650;
  static const double tabletBreakpoint = 1100;

  static LayoutType getLayoutType(double screenWidth) {
    if (screenWidth < mobileBreakpoint) {
      return LayoutType.mobile;
    } else if (screenWidth < tabletBreakpoint) {
      return LayoutType.tablet;
    } else {
      return LayoutType.desktop;
    }
  }

  static ResponsiveLayoutConfig getConfig(double screenWidth) {
    return ResponsiveLayoutConfig(getLayoutType(screenWidth));
  }

  static double getTitleFontSize(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.mobile:
        return 32;
      case LayoutType.tablet:
        return 40;
      case LayoutType.desktop:
        return 48;
    }
  }

  static double getBodyFontSize(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }

  static double getSmallTitleFontSize(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }

  static double getSmallBodyFontSize(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }
}

class ResponsiveLayoutConfig {
  final LayoutType layoutType;

  const ResponsiveLayoutConfig(this.layoutType);

  // Padding configurations
  EdgeInsets get screenPadding {
    switch (layoutType) {
      case LayoutType.mobile:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 30);
      case LayoutType.tablet:
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 30);
      case LayoutType.desktop:
        return const EdgeInsets.symmetric(horizontal: 80, vertical: 40);
    }
  }

  // Grid configurations
  int get gridCrossAxisCount {
    switch (layoutType) {
      case LayoutType.mobile:
        return 1;
      case LayoutType.tablet:
        return 2;
      case LayoutType.desktop:
        return 3;
    }
  }

  double get gridSpacing {
    switch (layoutType) {
      case LayoutType.mobile:
        return 20;
      case LayoutType.tablet:
        return 24;
      case LayoutType.desktop:
        return 30;
    }
  }

  double get gridAspectRatio {
    switch (layoutType) {
      case LayoutType.mobile:
        return 0.85;
      case LayoutType.tablet:
        return 0.9;
      case LayoutType.desktop:
        return 0.95;
    }
  }

  // Font size configurations
  double get headerFontSize {
    switch (layoutType) {
      case LayoutType.mobile:
        return 32;
      case LayoutType.tablet:
        return 40;
      case LayoutType.desktop:
        return 48;
    }
  }

  double get subtitleFontSize {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }

  double get categoryFontSize {
    switch (layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }

  double get cardTitleFontSize {
    switch (layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double get cardDescriptionFontSize {
    switch (layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }

  // Spacing configurations
  double get headerSpacing {
    switch (layoutType) {
      case LayoutType.mobile:
        return 30;
      case LayoutType.tablet:
        return 35;
      case LayoutType.desktop:
        return 40;
    }
  }

  double get categorySpacing {
    switch (layoutType) {
      case LayoutType.mobile:
        return 35;
      case LayoutType.tablet:
        return 40;
      case LayoutType.desktop:
        return 50;
    }
  }

  // Alignment configurations
  CrossAxisAlignment get headerAlignment =>
      layoutType == LayoutType.mobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start;

  TextAlign get headerTextAlign =>
      layoutType == LayoutType.mobile
          ? TextAlign.center
          : TextAlign.left;

  WrapAlignment get categoryWrapAlignment =>
      layoutType == LayoutType.mobile
          ? WrapAlignment.center
          : WrapAlignment.start;
}