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
        title: 'AssesFlow',
        description:
        'Comprehensive desktop application for managing student records,'
            ' course scheduling, and academic workflows',
        categories: ['UI/UX', 'Web', 'All','Mobile','Desktop'],
        technologies: ['Figma', 'Flutter', 'Spring Boot',],
        imageUrl: '',
        githubUrl: 'https://github.com/OGZod/AssessFlow',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'BakeEat',
        description:
        'A social application aimed at promoting pastries by creating fun environment'
            ' wherein pastry makers can share their work and get engagements from clients easily.',
        categories: ['UI/UX', 'Web', 'All','Mobile','Desktop'],
        technologies: ['Figma', 'Flutter', 'Firebase'],
        imageUrl: '',
        githubUrl: 'https://github.com/OGZod/BakeEat_Mobile',
        status: ProjectStatus.inProgress,
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
          liveUrl: 'https://play.google.com/store/apps/details?id=com.dohtechsolutions.buzme'
      ),
      ProjectModel(
        title: 'Buzsmart',
        description:
        'Buzsmart is a revolutionary marketplace that bridges the gap between'
            ' people living abroad and the authentic tastes of their home countries. '
            'We connect you with local stores that stock.',
        categories: ['All', 'Mobile'],
        technologies: ['Flutter', 'TypeScript', 'PostgreSQL'],
        imageUrl: 'assets/images/project5.png',
        role: 'Frontend developer',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Ajuoza',
        description:
            'Ajuoza Is the App to find your lost love ones and your important documents.'
                ' It also help you to secure your family members and check if your important document is already available at the police',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase',],
        imageUrl: '',
        status: ProjectStatus.archived,
      ),
      ProjectModel(
        title: 'Binary Segmentation of Echocardiograms',
        description:
            'Trained a hybrid model that combined UNET, LadderNet and ResNet features to accurately'
                'predict echocardiograms and in so doing help distinguish between useful and non useful echocardiograms',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Flask', 'Python', 'TensorFlow',],
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
