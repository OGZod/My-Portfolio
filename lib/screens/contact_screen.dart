import 'package:flutter/material.dart';

import '../widgets/theme_consumer.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
