import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/theme_consumer.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

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
                'My Skills',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextColor(isDarkMode),
                ),
              ),
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
      {'name': 'Flutter', 'percentage': 90},
      {'name': 'Dart', 'percentage': 85},
      {'name': 'UI/UX Design', 'percentage': 80},
      {'name': 'React Native', 'percentage': 70},
      {'name': 'Firebase', 'percentage': 75},
      {'name': 'State Management', 'percentage': 85},
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: skills.map((skill) => _buildSkillCard(skill, isDarkMode)).toList(),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, bool isDarkMode) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.getTextColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: (260 * (skill['percentage'] / 100)).toDouble(),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${skill['percentage']}%',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}