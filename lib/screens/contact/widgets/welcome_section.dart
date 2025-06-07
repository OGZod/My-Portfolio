
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../functions/helpers.dart';


class WelcomeSection extends StatelessWidget {
  final LayoutType layoutType;
  final double titleSize;
  final double bodySize;

  const WelcomeSection({
    super.key,
    required this.layoutType,
    required this.titleSize,
    required this.bodySize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          layoutType == LayoutType.mobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.7),
                ],
              ).createShader(bounds),
          child: Text(
            "Let's Connect!",
            style: AppTextStyles.headerLarge.copyWith(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign:
                layoutType == LayoutType.mobile
                    ? TextAlign.center
                    : TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ready to bring your ideas to life? Reach out through any of the platforms below and let\'s start a conversation!',
          style: AppTextStyles.body.copyWith(
            fontSize: bodySize,
            height: 1.6,
            color: Theme.of(
              context,
            ).textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
          ),
          textAlign:
              layoutType == LayoutType.mobile
                  ? TextAlign.center
                  : TextAlign.left,
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.schedule, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Usually responds within 24 hours',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}