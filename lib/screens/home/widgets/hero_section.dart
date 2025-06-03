import 'package:flutter/material.dart';
import 'package:my_portfolio_app/functions/get_time_of_day.dart';
import 'package:my_portfolio_app/screens/home/widgets/social_links_widget.dart';
import 'package:my_portfolio_app/widgets/animated_dot_widget.dart';
import 'package:my_portfolio_app/widgets/typing_animation.dart';
import '../../../../../constants/app_colors.dart';
import 'action_buttons_widget.dart';

class HeroSection extends StatelessWidget {
  final TextStyle nameStyle;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final bool showSocialLinks;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isFullWidthButtons;

  const HeroSection({
    super.key,
    required this.nameStyle,
    required this.titleStyle,
    required this.descriptionStyle,
    this.showSocialLinks = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.isFullWidthButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCentered = crossAxisAlignment == CrossAxisAlignment.center;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        GreetingPillWidget(),
        SizedBox(height: isCentered ? 16 : 24),
        Text(
          'Oben Ayuk Gilbert',
          style: nameStyle,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
        SizedBox(height: isCentered ? 12 : 16),
        Row(
          mainAxisAlignment: isCentered 
              ? MainAxisAlignment.center 
              : MainAxisAlignment.start,
          children: [
            Text('Software Engineer', style: titleStyle),
            SizedBox(width: isCentered ? 8 : 16),
            AnimatedDotWidget(),
          ],
        ),
        SizedBox(height: isCentered ? 24 : 24),
        TypingAnimation(
          style: descriptionStyle,
          text: 'I build beautiful, responsive and feature-rich mobile and web and desktop applications that deliver exceptional user experiences.',
        ),
        SizedBox(height: isCentered ? 32 : 40),
        ActionButtonsWidget(
          isFullWidth: isFullWidthButtons,
          isCentered: isCentered,
        ),
        if (showSocialLinks) ...[
          SizedBox(height: isCentered ? 40 : 60),
          SocialLinksWidget(
            alignment: isCentered 
                ? MainAxisAlignment.center 
                : MainAxisAlignment.start,
          ),
        ],
      ],
    );
  }
}

class GreetingPillWidget extends StatelessWidget {
  const GreetingPillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '${getTimeOfDay()}, I\'m',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}