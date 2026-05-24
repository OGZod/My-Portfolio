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
            mainAxisSize: MainAxisSize.min,
            // Important to prevent infinite height
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
        position: 'Mobile Software Engineer - Android',
        company: 'AfroVisioN Group LTD, Buea',
        period: '2026 - Present',
        description: "Designing, developing, testing, and maintaining Android mobile applications. Collaborating with backend and product teams to deliver high-quality solutions"
      ),
      Experience(
        position: 'Fullstack Developer',
        company: 'Dohtech Solutions, Remote',
        period: '2023 - 2026',
        description:
        'Contributed to mobile and web applications like Buzme, an e-commerce platform available on Play Store and App Store, enhancing functionality and user experience.',
      ),
      Experience(
        position: 'Part-time Lecturer',
        company: 'BIAKA University, Buea',
        period: '2025 - Present',
        description:
            'Deliver lectures on engineering related courses under the School of Engineering. ',
      ),
      Experience(
        position: 'Part-time Lecturer',
        company: 'HIBES, Buea',
        period: '2024 - Present',
        description:
            'Deliver engaging lectures on engineering-related courses, guiding students in understanding complex concepts and applying practical skills in technology and development.',
      ),
      Experience(
        position: 'Part-time Lecturer',
        company: 'DEX University, Limbe',
        period: '2024 - Present',
        description:
            'Teach engineering-related courses, fostering critical thinking and problem-solving skills in students through hands-on projects and theoretical instruction.',
      ),
      Experience(
        position: 'Part-time Lecturer',
        company: 'TRUSTECH University, Buea',
        period: '2024 - 2025',
        description:
        'Instructed students in engineering disciplines, emphasizing real-world applications and innovative approaches to technology and system design.',
      ),
      Experience(
        position: 'Part-time Lecturer',
        company: 'VHIT, Buea',
        period: '2023 - 2024',
        description:
            'Led lectures in General Mathematics, equipping students with foundational knowledge for mathematical reasoning.',
      ),
      Experience(
        position: 'Mobile Developer',
        company: 'Ajuoza, Remote',
        period: '2023 - Present',
        description:
            'Volunteered as a Flutter developer, making significant contributions to mobile applications like Ajuoza mobile application, improving features, performance, and user interface design.',
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
