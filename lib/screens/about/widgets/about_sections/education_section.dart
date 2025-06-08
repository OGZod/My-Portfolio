import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../functions/helpers.dart';
import '../animated_section_wrapper.dart';

class EducationSection extends StatelessWidget {
  final LayoutType layoutType;

  const EducationSection({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Education',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ResponsiveLayoutConfig(layoutType).gridSpacing,
        children: [
          _buildEducationItem(
            context,
            'Master of Science in Engineering',
            'University of Buea, Cameroon',
            'Advanced coursework in software engineering, systems design, and research methodologies',
          ),
          _buildEducationItem(
            context,
            'Bachelor of Engineering',
            'University of Buea, Cameroon',
            'General coursework in computer engineering, telecommunications, and electronics',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
    BuildContext context,
    String degree,
    String institution,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: AppTextStyles.headerSmall.copyWith(
              fontSize: ResponsiveUtils.getTitleFontSize(layoutType),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            institution,
            style: AppTextStyles.body.copyWith(
              fontSize: ResponsiveUtils.getBodyFontSize(layoutType),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTextStyles.body.copyWith(
              fontSize: ResponsiveUtils.getBodyFontSize(layoutType) - 1,
              height: 1.5,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
