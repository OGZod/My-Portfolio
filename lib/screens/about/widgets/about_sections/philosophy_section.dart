import 'package:flutter/material.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_text_styles.dart';
import '../../../../functions/helpers.dart';
import '../animated_section_wrapper.dart';

class PhilosophySection extends StatelessWidget {
  final LayoutType layoutType;

  const PhilosophySection({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'My Philosophy',
      child: Column(
        children: [
          _buildPhilosophyCard(
            context,
            Icons.lightbulb_outline_rounded,
            'Innovation Through Quality',
            'I believe that exceptional software emerges from the intersection of technical excellence and creative problem-solving. Every project is an opportunity to push boundaries while maintaining the highest standards of quality.',
          ),
          const SizedBox(height: 16),
          _buildPhilosophyCard(
            context,
            Icons.groups_rounded,
            'Knowledge Multiplier',
            'Teaching has taught me that the greatest impact comes from empowering others. Whether mentoring students or collaborating with teams, I strive to be a catalyst for growth and learning.',
          ),
          const SizedBox(height: 16),
          _buildPhilosophyCard(
            context,
            Icons.trending_up_rounded,
            'Continuous Evolution',
            'Technology evolves rapidly, and so must we. I\'m committed to lifelong learning, staying current with emerging technologies, and adapting to new challenges with enthusiasm and expertise.',
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophyCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headerSmall.copyWith(
                    fontSize: ResponsiveUtils.getSmallTitleFontSize(layoutType),
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(
                    fontSize: ResponsiveUtils.getSmallBodyFontSize(layoutType),
                    height: 1.6,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
