
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeConsumer extends StatelessWidget {
  final Widget Function(BuildContext context, bool isDarkMode) builder;

  const ThemeConsumer({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return builder(context, themeProvider.currentThemeIsDark);
      },
    );
  }
}

// Extension method to easily access current theme mode
extension ThemeContextExtension on BuildContext {
  bool get isDarkMode => Provider.of<ThemeProvider>(this, listen: false).currentThemeIsDark;
  ThemeProvider get themeProvider => Provider.of<ThemeProvider>(this, listen: false);
}