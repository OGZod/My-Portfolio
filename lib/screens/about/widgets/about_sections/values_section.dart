import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../functions/helpers.dart';
import '../animated_section_wrapper.dart';

class ValuesSection extends StatelessWidget {
  final LayoutType layoutType;

  const ValuesSection({super.key, required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'What Drives Me',
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).cardColor,
              Theme.of(context).cardColor.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainHeader(context),
            const SizedBox(height: 16),
            _buildMainDescription(context),
            const SizedBox(height: 20),
            _buildQuoteCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.favorite_rounded,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Impact Through Code & Education',
          style: AppTextStyles.headerSmall.copyWith(
            fontSize: ResponsiveUtils.getSmallTitleFontSize(layoutType),
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildMainDescription(BuildContext context) {
    return Text(
      'I\'m driven by the opportunity to make a meaningful difference through technology. Whether it\'s developing solutions that solve real-world problems or mentoring the next generation of engineers, my goal is to contribute to a future where technology serves humanity better.',
      style: AppTextStyles.body.copyWith(
        fontSize: ResponsiveUtils.getBodyFontSize(layoutType),
        height: 1.7,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.note_alt, color: AppColors.secondary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"Excellence is not a destination, it\'s a continuous journey of learning, growing, and giving back."',
              style: AppTextStyles.body.copyWith(
                fontSize: ResponsiveUtils.getBodyFontSize(layoutType),
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
