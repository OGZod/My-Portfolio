import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_layout.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class ProjectsHeader extends StatelessWidget {
  final ResponsiveLayoutConfig config;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const ProjectsHeader({
    super.key,
    required this.config,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          crossAxisAlignment: config.headerAlignment,
          children: [
            Text(
              'My Projects',
              style: AppTextStyles.headerLarge.copyWith(
                fontSize: config.headerFontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
              textAlign: config.headerTextAlign,
            ),
            const SizedBox(height: 12),
            HeaderUnderline(),
            const SizedBox(height: 16),
            Text(
              'A showcase of innovative solutions across multiple platforms and technologies',
              style: AppTextStyles.body.copyWith(
                fontSize: config.subtitleFontSize,
                color: AppColors.textMuted,
                height: 1.5,
              ),
              textAlign: config.headerTextAlign,
            ),
          ],
        ),
      ),
    );
  }
}

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