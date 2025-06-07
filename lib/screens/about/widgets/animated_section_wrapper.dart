import 'package:flutter/material.dart';

import '../../../constants/app_text_styles.dart';

class AnimatedSectionWrapper extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const AnimatedSectionWrapper({
    super.key,
    required this.animation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}



class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headerMedium.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        const SizedBox(height: 20),
        child,
      ],
    );
  }
}
