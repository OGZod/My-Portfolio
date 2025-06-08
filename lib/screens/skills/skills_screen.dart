import 'package:flutter/material.dart';
import 'package:my_portfolio_app/functions/helpers.dart';
import 'package:my_portfolio_app/screens/skills/widgets/skill_card.dart';
import 'package:my_portfolio_app/widgets/header_underline.dart';
import '../../constants/app_colors.dart';
import '../../models/skill.dart';
import '../../widgets/theme_consumer.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ResponsiveUtils.getConfig(MediaQuery.of(context).size.width);
    return ThemeConsumer(
      builder: (context, isDarkMode) {
        return Container(
          constraints: const BoxConstraints(
            minHeight: 500, // Set a minimum height to prevent layout issues
          ),
          width: double.infinity,
          padding: config.screenPadding,
          color: AppColors.getBackgroundColor(isDarkMode),
          child: Column(
            crossAxisAlignment: config.headerAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My Skills',
                textAlign: config.headerTextAlign,
                style: TextStyle(
                  fontSize: ResponsiveUtils.getTitleFontSize(
                    ResponsiveUtils.getLayoutType(
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextColor(isDarkMode),
                ),
              ),
              HeaderUnderline(),
              const SizedBox(height: 40),
              _buildSkillsGrid(isDarkMode),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillsGrid(bool isDarkMode) {
    final skills = [
      Skill(name: 'Flutter', percentage: 90),
      Skill(name: 'Dart', percentage: 85),
      Skill(name: 'UI/UX Design', percentage: 80),
      Skill(name: 'React Native', percentage: 70),
      Skill(name: 'Firebase', percentage: 75),
      Skill(name: 'State Management', percentage: 85),
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children:
          skills
              .map((skill) => SkillCard(skill: skill, isDarkMode: isDarkMode))
              .toList(),
    );
  }
}
