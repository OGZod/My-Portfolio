enum LayoutType { mobile, tablet, desktop }

class ResponsiveUtils {
  static double getTitleFontSize(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
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