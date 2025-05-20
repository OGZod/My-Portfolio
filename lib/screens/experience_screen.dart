import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/theme_consumer.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      builder: (context, isDarkMode) {
        return Container(
          constraints: const BoxConstraints(
            minHeight: 500, // Set a minimum height to prevent layout issues
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          color: AppColors.getBackgroundColor(isDarkMode),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Important to prevent infinite height
            children: [
              Text(
                'My Experience',
                style: TextStyle(
                  fontSize: 32,
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
      {
        'position': 'Senior Flutter Developer',
        'company': 'Tech Innovations Inc.',
        'period': '2023 - Present',
        'description': 'Leading the mobile development team in creating cross-platform applications. Implemented CI/CD pipelines and improved app performance by 40%.'
      },
      {
        'position': 'Flutter Developer',
        'company': 'Mobile Solutions Ltd.',
        'period': '2021 - 2023',
        'description': 'Developed and maintained multiple Flutter applications. Collaborated with design and backend teams to deliver high-quality products.'
      },
      {
        'position': 'Junior Mobile Developer',
        'company': 'StartUp Ventures',
        'period': '2019 - 2021',
        'description': 'Started as an intern and progressed to a full-time position. Worked on various projects using Flutter and React Native.'
      },
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: ListView.builder(
        shrinkWrap: true, // Important to prevent infinite height issues
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling within ListView
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return _buildExperienceItem(experiences[index], isDarkMode, index == experiences.length - 1);
        },
      ),
    );
  }

  Widget _buildExperienceItem(Map<String, String> experience, bool isDarkMode, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 3,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 100,
                color: AppColors.primary.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      experience['position']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.getTextColor(isDarkMode),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      experience['period']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                experience['company']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                experience['description']!,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}