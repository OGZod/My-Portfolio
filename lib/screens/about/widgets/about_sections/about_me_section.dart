import 'package:flutter/material.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_text_styles.dart';
import '../../../../functions/helpers.dart';
import '../animated_section_wrapper.dart';


class AboutMeSection extends StatelessWidget {
  final LayoutType layoutType;

  const AboutMeSection({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'My Journey',
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.secondary.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              context,
              Icons.psychology_rounded,
              'Passion-Driven Engineer',
              AppColors.primary,
            ),
            const SizedBox(height: 16),
            _buildDescription(
              context,
              'With a Master\'s in Engineering from the University of Buea, I blend academic rigor with practical innovation. My approach to software engineering is rooted in creating solutions that not only meet technical requirements but also deliver exceptional user experiences.',
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(
              context,
              Icons.school_rounded,
              'Educator & Mentor',
              AppColors.secondary,
            ),
            const SizedBox(height: 16),
            _buildDescription(
              context,
              'As a part-time university lecturer across multiple institutions, I\'m committed to nurturing the next generation of engineers. I believe in the power of knowledge sharing and the importance of bridging the gap between academic theory and industry practice.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Text(
          title,
          softWrap: true,
          style: AppTextStyles.headerSmall.copyWith(
            fontSize: ResponsiveUtils.getSmallTitleFontSize(layoutType),
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(
        fontSize: ResponsiveUtils.getBodyFontSize(layoutType),
        height: 1.7,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }
}
