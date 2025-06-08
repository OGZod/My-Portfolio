// experience_screen.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/experience/widgets/experience_item.dart';
import '../../constants/app_colors.dart';
import '../../functions/helpers.dart';
import '../../models/experience.dart';
import '../../widgets/theme_consumer.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

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
            mainAxisSize: MainAxisSize.min, // Important to prevent infinite height
            children: [
              Text(
                'My Experience',
                style: TextStyle(
                  fontSize: config.headerFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 40),
              _buildExperienceTimeline(isDarkMode),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceTimeline(bool isDarkMode) {
    final experiences = [
      Experience(
        position: 'Senior Flutter Developer',
        company: 'Tech Innovations Inc.',
        period: '2023 - Present',
        description: 'Leading the mobile development team in creating cross-platform applications. Implemented CI/CD pipelines and improved app performance by 40%.',
      ),
      Experience(
        position: 'Flutter Developer',
        company: 'Mobile Solutions Ltd.',
        period: '2021 - 2023',
        description: 'Developed and maintained multiple Flutter applications. Collaborated with design and backend teams to deliver high-quality products.',
      ),
      Experience(
        position: 'Junior Mobile Developer',
        company: 'StartUp Ventures',
        period: '2019 - 2021',
        description: 'Started as an intern and progressed to a full-time position. Worked on various projects using Flutter and React Native.',
      ),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: ListView.builder(
        shrinkWrap: true, // Important to prevent infinite height issues
        physics: const NeverScrollableScrollPhysics(),
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return ExperienceItem(
            experience: experiences[index],
            isDarkMode: isDarkMode,
            isLast: index == experiences.length - 1,
          );
        },
      ),
    );
  }
}