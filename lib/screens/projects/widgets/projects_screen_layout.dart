import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_grid.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_header.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_layout.dart';

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

  const ProjectsScreenLayout({super.key, required this.layoutType, required this.fadeInAnimation, required this.slideAnimation, required this.staggeredAnimations, required this.selectedCategory, required this.categories, required this.onCategoryChanged});


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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectsHeader(
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectsHeader(
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectsHeader(
            config: ResponsiveLayoutConfig(layoutType),
            fadeAnimation: fadeInAnimation,
            slideAnimation: slideAnimation,
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
        title: 'E-Commerce Flutter App',
        description:
        'A complete e-commerce solution with payment integration, inventory management, and real-time analytics.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase', 'Stripe API', 'Node.js'],
        imageUrl: 'assets/images/project1.png',
        githubUrl: 'https://github.com/yourusername/ecommerce-app',
        liveUrl: 'https://play.google.com/store/apps/details?id=com.yourapp',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'AI-Powered Learning Platform',
        description:
        'Machine learning platform that personalizes educational content based on student performance and learning patterns.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Next.js', 'Python', 'TensorFlow', 'PostgreSQL'],
        imageUrl: 'assets/images/project2.png',
        githubUrl: 'https://github.com/yourusername/ai-learning',
        liveUrl: 'https://ai-learning-platform.vercel.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'University Management System',
        description:
        'Comprehensive desktop application for managing student records, course scheduling, and academic workflows.',
        categories: ['Desktop', 'All'],
        technologies: ['JavaFX', 'Spring Boot', 'MySQL', 'JasperReports'],
        imageUrl: 'assets/images/project3.png',
        githubUrl: 'https://github.com/yourusername/university-system',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'FinTech Mobile Wallet',
        description:
        'Secure mobile wallet application with biometric authentication, QR payments, and transaction history.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Dart', 'Firebase', 'Biometric Auth'],
        imageUrl: 'assets/images/project4.png',
        githubUrl: 'https://github.com/yourusername/mobile-wallet',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Healthcare Analytics Dashboard',
        description:
        'Real-time analytics dashboard for healthcare providers with patient insights and predictive modeling.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['React', 'Python', 'D3.js', 'FastAPI'],
        imageUrl: 'assets/images/project5.png',
        githubUrl: 'https://github.com/yourusername/healthcare-analytics',
        liveUrl: 'https://healthcare-dashboard.netlify.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Design System & Component Library',
        description:
        'Comprehensive design system with reusable components, tokens, and guidelines for consistent UI/UX.',
        categories: ['UI/UX', 'Web', 'All'],
        technologies: ['Figma', 'Storybook', 'React', 'TypeScript'],
        imageUrl: 'assets/images/project6.png',
        githubUrl: 'https://github.com/yourusername/design-system',
        liveUrl: 'https://design-system-storybook.netlify.app',
        status: ProjectStatus.completed,
      ),
    ];
  }

}