import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/helpers.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/responsive_wrapper.dart';
import 'widgets/about_screen_layout.dart';
import 'widgets/about_animations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin {
  late AboutAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animations = AboutAnimations(vsync: this);
    _animations.startAnimations();
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveWrapper(
          mobile: AboutScreenLayout(
            layoutType: LayoutType.mobile,
            animations: _animations,
          ),
          tablet: AboutScreenLayout(
            layoutType: LayoutType.tablet,
            animations: _animations,
          ),
          desktop: AboutScreenLayout(
            layoutType: LayoutType.desktop,
            animations: _animations,
          ),
        );
      },
    );
  }}
