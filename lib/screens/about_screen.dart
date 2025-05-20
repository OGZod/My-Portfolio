import 'package:flutter/material.dart';
import 'package:my_portfolio_app/widgets/theme_consumer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
