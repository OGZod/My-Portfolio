import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/about/widgets/about_sections/philosophy_section.dart';
import '../../../functions/helpers.dart';
import 'about_animations.dart';
import 'about_sections/about_me_section.dart';
import 'about_sections/education_section.dart';
import 'about_sections/values_section.dart';
import '../../../widgets/animated_header.dart';
import 'animated_section_wrapper.dart';

class AboutScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final AboutAnimations animations;

  const AboutScreenLayout({
    super.key,
    required this.layoutType,
    required this.animations,
  });

  @override
  Widget build(BuildContext context) {
    switch (layoutType) {
      case LayoutType.mobile:
        return _buildMobileLayout(context);
      case LayoutType.tablet:
        return _buildTabletLayout(context);
      case LayoutType.desktop:
        return _buildDesktopLayout(context);
    }
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Column(
        crossAxisAlignment: ResponsiveLayoutConfig(layoutType).headerAlignment,
        children: [
          AnimatedHeader(
            layoutType: layoutType,
            fadeInAnimation: animations.fadeInAnimation,
            slideAnimation: animations.slideAnimation,
            title: 'About Me',
          ),
          const SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AnimatedSectionWrapper(
                      animation: animations.staggeredAnimations[0],
                      child: AboutMeSection(layoutType: layoutType),
                    ),
                    const SizedBox(height: 40),
                    AnimatedSectionWrapper(
                      animation: animations.staggeredAnimations[1],
                      child: EducationSection(layoutType: layoutType),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AnimatedSectionWrapper(
                      animation: animations.staggeredAnimations[2],
                      child: PhilosophySection(layoutType: layoutType),
                    ),
                    const SizedBox(height: 40),
                    AnimatedSectionWrapper(
                      animation: animations.staggeredAnimations[3],
                      child: ValuesSection(layoutType: layoutType),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedHeader(
            layoutType: layoutType,
            fadeInAnimation: animations.fadeInAnimation,
            slideAnimation: animations.slideAnimation,
            title: 'About Me',
          ),
          const SizedBox(height: 50),
          ...List.generate(
            4,
            (index) => [
              AnimatedSectionWrapper(
                animation: animations.staggeredAnimations[index],
                child: _getSectionByIndex(index),
              ),
              if (index < 3) const SizedBox(height: 40),
            ],
          ).expand((element) => element),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: ResponsiveLayoutConfig(layoutType).headerAlignment,
        children: [
          AnimatedHeader(
            layoutType: layoutType,
            fadeInAnimation: animations.fadeInAnimation,
            slideAnimation: animations.slideAnimation,
            title: 'About Me',
          ),
          const SizedBox(height: 40),
          ...List.generate(
            4,
            (index) => [
              AnimatedSectionWrapper(
                animation: animations.staggeredAnimations[index],
                child: _getSectionByIndex(index),
              ),
              if (index < 3) const SizedBox(height: 30),
            ],
          ).expand((element) => element),
        ],
      ),
    );
  }

  Widget _getSectionByIndex(int index) {
    switch (index) {
      case 0:
        return AboutMeSection(layoutType: layoutType);
      case 1:
        return EducationSection(layoutType: layoutType);
      case 2:
        return PhilosophySection(layoutType: layoutType);
      case 3:
        return ValuesSection(layoutType: layoutType);
      default:
        return const SizedBox.shrink();
    }
  }
}
