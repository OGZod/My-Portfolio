import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../functions/helpers.dart';
import 'header_underline.dart';

class AnimatedHeader extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final String title;

  const AnimatedHeader({
    super.key,
    required this.layoutType,
    required this.fadeInAnimation,
    required this.slideAnimation, required this.title,

  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          crossAxisAlignment:
              layoutType == LayoutType.mobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.headerLarge.copyWith(
                fontSize: _getHeaderFontSize(),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
              textAlign:
                  layoutType == LayoutType.mobile
                      ? TextAlign.center
                      : TextAlign.left,
            ),
            const SizedBox(height: 12),
            HeaderUnderline(),
          ],
        ),
      ),
    );
  }

  double _getHeaderFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 32;
      case LayoutType.tablet:
        return 40;
      case LayoutType.desktop:
        return 48;
    }
  }
}
