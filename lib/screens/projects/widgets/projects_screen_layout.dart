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
        title: 'Ajuoza',
        description:
            'Ajuoza Is the App to find your lost love ones and your important documents.'
                ' It also help you to secure your family members and check if your important document is already available at the police',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase',],
        imageUrl: 'https://th.bing.com/th/id/OIP.E3S9mcNaXkD-4PuTPKnFdAAAAA?w=129&h=150&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3.png',
        liveUrl: '',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Binary Segmentation of Echocardiograms',
        description:
            'Trained a hybrid model that combined UNET, LadderNet and ResNet features to accurately'
                'predict echocardiograms and in so doing help distinguish between useful and non useful echocardiograms',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Flask', 'Python', 'TensorFlow',],
        imageUrl: '',
        githubUrl: '',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Verified DNA - Vedna mobile app',
        description:
            'Comprehensive desktop application for managing student records, course scheduling, and academic workflows.',
        categories: ['Desktop', 'All'],
        technologies: ['Flutter', 'Spring Boot', 'MySQL',],
        imageUrl: '',
        githubUrl: 'https://github.com/OGZod/vedna_app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Buzme',
        description:
            'Buzme is Africa\'s trusted online marketplace featuring secure '
                'escrow payments, business tools, and logistics.'
                ' Buy safely, sell confidently, and manage your business efficiently',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Dart', 'Firebase', 'NodeJS'],
        imageUrl: 'https://play-lh.googleusercontent.com/Ut-PvSsA4dDrijhPLUKgvRY7ZWWSlyQsvBoGzs1bVhGODTOdbr5vd6cf75cLIZpju6w=w5120-h2880-rw.png',
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
        title: 'AssesFlow',
        description:
            'An Application for easy student assessment.',
        categories: ['UI/UX', 'Web', 'All','Mobile','Desktop'],
        technologies: ['Figma', 'Flutter', 'Spring Boot', 'Java','Dart','Firebase'],
        imageUrl: '',
        role: 'Co-founder',
        githubUrl: 'https://github.com/OGZod/AssessFlow',
        status: ProjectStatus.inProgress,
      ),
    ];
  }
}
