import 'package:flutter/material.dart';

import '../widgets/theme_consumer.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      builder:
          (context, isDarkMode) => Container(
        constraints: const BoxConstraints(
          minHeight: 500, // Set a minimum height to prevent layout issues
        ),
      ),
    );
  }
}
