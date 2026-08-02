import 'package:flutter/material.dart';
import 'package:my_portfolio_app/widgets/animated_header.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_grid.dart';

import '../../../functions/helpers.dart';
import '../../../models/project_model.dart';
import 'category_filter.dart';

class ProjectsScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final List<Animation<double>> staggeredAnimations;
  final String selectedCategory;
  final List<String> categories;
  final Function(String) onCategoryChanged;

  const ProjectsScreenLayout({
    super.key,
    required this.layoutType,
    required this.fadeInAnimation,
    required this.slideAnimation,
    required this.staggeredAnimations,
    required this.selectedCategory,
    required this.categories,
    required this.onCategoryChanged,
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
            fadeInAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
            title: 'My Projects',
          ),
          const SizedBox(height: 40),
          CategoryFilter(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategoryChanged: onCategoryChanged,
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
          ),
          const SizedBox(height: 50),
          ProjectsGrid(
            projects: _getFilteredProjects(),
            config: ResponsiveLayoutConfig(layoutType),
            staggeredAnimations: staggeredAnimations,
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: ResponsiveLayoutConfig(layoutType).headerAlignment,
        children: [
          AnimatedHeader(
            layoutType: layoutType,
            fadeInAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
            title: 'My Projects',
          ),
          const SizedBox(height: 35),
          CategoryFilter(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategoryChanged: onCategoryChanged,
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
          ),
          const SizedBox(height: 40),
          ProjectsGrid(
            projects: _getFilteredProjects(),
            config: ResponsiveLayoutConfig(layoutType),
            staggeredAnimations: staggeredAnimations,
          ),
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
            fadeInAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
            title: 'My Projects',
          ),
          const SizedBox(height: 30),
          CategoryFilter(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategoryChanged: onCategoryChanged,
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
          ),
          const SizedBox(height: 35),
          ProjectsGrid(
            projects: _getFilteredProjects(),
            config: ResponsiveLayoutConfig(layoutType),
            staggeredAnimations: staggeredAnimations,
          ),
        ],
      ),
    );
  }

  List<ProjectModel> _getFilteredProjects() {
    final allProjects = _getAllProjects();
    if (selectedCategory == 'All') {
      return allProjects;
    }
    return allProjects
        .where((project) => project.categories.contains(selectedCategory))
        .toList();
  }

  List<ProjectModel> _getAllProjects() {
    return [
      ProjectModel(
        title: 'Ann\'Tithe',
        description:
            "AnnTithe is a comprehensive eCommerce application designed to provide a seamless and reliable shopping experience."
                " The platform enables users to discover, compare, and purchase products across a wide range of categories, all within an intuitive and user-friendly interface.",
        categories: ['UI/UX', 'All', 'Mobile', ],
        technologies: ['Figma', 'Flutter', 'Spring Boot'],
        imageUrl:
            'https://lh3.googleusercontent.com/WmLk51TO0DSF25KvajVOnKC0jxL7iIfJr1I-Hwvc74oP_qHJ3K14e0BTlKvIq2oS2ofYSzUkmmzNjY4pXE13Jg',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Quesa',
        description:
            "An application to help GCE students access past questions and their solutions.",
        categories: ['All','Mobile',],
        technologies: ['Flutter', 'Firebase', "Laravel"],
        liveUrl: "https://play.google.com/store/apps/details?id=com.lambdaa.quesa",
        role: "Mobile Developer",
        imageUrl:
            'https://play-lh.googleusercontent.com/o3DorRD7MMNyHe5b8GFqKHOmLt0oG8WLehw0lfduNxakwG7EDjkpiMRuLUeqc3YVYTA=w480-h960-rw',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'AssessFlow',
        description:
            'Comprehensive application for continuous student assessment and roll call',
        categories: ['UI/UX', 'Web', 'All', 'Mobile', 'Desktop'],
        technologies: ['Figma', 'Flutter', 'Firebase'],
        imageUrl:
            'https://lh3.googleusercontent.com/vJycXzGDqq0UgkR9Q8R-mHVPF8ioniInz9amzw06d0nzmOT8xOVtuoHyx9qtV8p5giNoggeVqm5lRqBAzNgO',
        liveUrl:
            'https://play.google.com/store/apps/details?id=com.ogZod.assessflow',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'BakeEat',
        description:
            'A social application aimed at promoting pastries by creating fun environment'
            ' wherein pastry makers can share their work and get engagements from clients easily.',
        categories: ['UI/UX', 'Web', 'All', 'Mobile', 'Desktop'],
        technologies: ['Figma', 'Flutter', 'Firebase, SpringBoot'],
        imageUrl:
            'https://lh3.googleusercontent.com/UVwsrkduge5MfzD80IDD-A_-Jtgz05Msx7i7Eux0mvOXkt68f2YC_L11-yvujPY8LuT1N9QM2Q0pXnb3OBQ4zA',
        liveUrl:
            'https://play.google.com/store/apps/details?id=com.ogZod.bakeEat',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Buzme',
        description:
            'Buzme is Africa\'s trusted online marketplace featuring secure '
            'escrow payments, business tools, and logistics.'
            ' Buy safely and sell confidently.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase', 'NodeJS'],
        imageUrl: '',
        status: ProjectStatus.completed,
        role: 'Fullstack developer',
        liveUrl:
            'https://play.google.com/store/apps/details?id=com.dohtechsolutions.buzme',
      ),
      ProjectModel(
        title: 'Buzsmart Immigration Marketplace',
        description:
            'Buzsmart is a revolutionary marketplace that bridges the gap between'
            ' people living abroad and the authentic tastes of their home countries. '
            'We connect you with local stores that stock.',
        categories: ['All', 'Mobile'],
        technologies: ['Flutter', 'TypeScript', 'PostgreSQL'],
        imageUrl: 'https://play-lh.googleusercontent.com/SCDPi2uvPJ-cKCgtTiATOm441xhjsLJXXkSHhDEbLUn-dOylhWJCP_Tz5h2fy5QTmNU=w480-h960-rw',
        role: 'Frontend developer',
        liveUrl: "https://play.google.com/store/apps/details?id=com.dohtechsolutions.buzsmart",
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Buzsmart Delivery',
        description:
            'Delivery app for Buzsmart with turn by turn navigation for delivery agents to follow',
        categories: ['All', 'Mobile'],
        technologies: ['Flutter', 'TypeScript', 'PostgreSQL'],
        imageUrl: '',
        role: 'Frontend developer',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Ajuoza',
        description:
            'Ajuoza Is the App to find your lost love ones and your important documents.'
            ' It also help you to secure your family members and check if your important document is already available at the police',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase'],
        imageUrl: '',
        status: ProjectStatus.archived,
      ),
      ProjectModel(
        title: 'Binary Segmentation of Echocardiograms',
        description:
            'Trained a hybrid model that combined UNET, LadderNet and ResNet features to accurately'
            'predict echocardiograms and in so doing help distinguish between useful and non useful echocardiograms',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Flask', 'Python', 'TensorFlow'],
        imageUrl: '',
        status: ProjectStatus.completed,
      ),
      // ProjectModel(
      //   title: 'Verified DNA - Vedna mobile app',
      //   description:
      //       '.',
      //   categories: ['Desktop', 'All'],
      //   technologies: ['Flutter', 'Spring Boot', 'MySQL',],
      //   imageUrl: '',
      //   githubUrl: 'https://github.com/OGZod/vedna_app',
      //   status: ProjectStatus.completed,
      // ),
    ];
  }
}
