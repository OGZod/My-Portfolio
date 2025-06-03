// projects_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../providers/theme_provider.dart';
import '../widgets/responsive_wrapper.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _staggerController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _staggeredAnimations;

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Mobile', 'Web', 'Desktop', 'Machine Learning', 'UI/UX'];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Staggered animations for project cards
    _staggeredAnimations = List.generate(6, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            index * 0.15,
            (index * 0.15) + 0.4,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _animationController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveWrapper(
          mobile: _ProjectsScreenLayout(
            layoutType: LayoutType.mobile,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
            selectedCategory: _selectedCategory,
            categories: _categories,
            onCategoryChanged: _onCategoryChanged,
          ),
          tablet: _ProjectsScreenLayout(
            layoutType: LayoutType.tablet,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
            selectedCategory: _selectedCategory,
            categories: _categories,
            onCategoryChanged: _onCategoryChanged,
          ),
          desktop: _ProjectsScreenLayout(
            layoutType: LayoutType.desktop,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
            selectedCategory: _selectedCategory,
            categories: _categories,
            onCategoryChanged: _onCategoryChanged,
          ),
        );
      },
    );
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _staggerController.reset();
    _staggerController.forward();
  }
}

enum LayoutType { mobile, tablet, desktop }

class _ProjectsScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final List<Animation<double>> staggeredAnimations;
  final String selectedCategory;
  final List<String> categories;
  final Function(String) onCategoryChanged;

  const _ProjectsScreenLayout({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedHeader(context),
          const SizedBox(height: 40),
          _buildCategoryFilter(context),
          const SizedBox(height: 50),
          _buildProjectsGrid(context, crossAxisCount: 3),
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
          _buildAnimatedHeader(context),
          const SizedBox(height: 35),
          _buildCategoryFilter(context),
          const SizedBox(height: 40),
          _buildProjectsGrid(context, crossAxisCount: 2),
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
          _buildAnimatedHeader(context),
          const SizedBox(height: 30),
          _buildCategoryFilter(context),
          const SizedBox(height: 35),
          _buildProjectsGrid(context, crossAxisCount: 1),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader(BuildContext context) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          crossAxisAlignment: layoutType == LayoutType.mobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              'My Projects',
              style: AppTextStyles.headerLarge.copyWith(
                fontSize: _getHeaderFontSize(),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
              textAlign: layoutType == LayoutType.mobile
                  ? TextAlign.center
                  : TextAlign.left,
            ),
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'A showcase of innovative solutions across multiple platforms and technologies',
              style: AppTextStyles.body.copyWith(
                fontSize: _getSubtitleFontSize(),
                color: AppColors.textMuted,
                height: 1.5,
              ),
              textAlign: layoutType == LayoutType.mobile
                  ? TextAlign.center
                  : TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child: Container(
        width: double.infinity,
        child: Wrap(
          alignment: layoutType == LayoutType.mobile
              ? WrapAlignment.center
              : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            final isSelected = category == selectedCategory;
            return GestureDetector(
              onTap: () => onCategoryChanged(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: Text(
                  category,
                  style: AppTextStyles.body.copyWith(
                    fontSize: _getCategoryFontSize(),
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, {required int crossAxisCount}) {
    final filteredProjects = _getFilteredProjects();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: _getGridSpacing(),
        mainAxisSpacing: _getGridSpacing(),
        childAspectRatio: _getAspectRatio(),
      ),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        if (index >= staggeredAnimations.length) {
          return _ProjectCard(
            project: filteredProjects[index],
            layoutType: layoutType,
            animation: staggeredAnimations.last,
          );
        }
        return _ProjectCard(
          project: filteredProjects[index],
          layoutType: layoutType,
          animation: staggeredAnimations[index],
        );
      },
    );
  }

  List<ProjectModel> _getFilteredProjects() {
    final allProjects = _getAllProjects();
    if (selectedCategory == 'All') {
      return allProjects;
    }
    return allProjects.where((project) =>
        project.categories.contains(selectedCategory)).toList();
  }

  List<ProjectModel> _getAllProjects() {
    return [
      ProjectModel(
        title: 'E-Commerce Flutter App',
        description: 'A complete e-commerce solution with payment integration, inventory management, and real-time analytics.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase', 'Stripe API', 'Node.js'],
        imageUrl: 'assets/images/project1.png',
        githubUrl: 'https://github.com/yourusername/ecommerce-app',
        liveUrl: 'https://play.google.com/store/apps/details?id=com.yourapp',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'AI-Powered Learning Platform',
        description: 'Machine learning platform that personalizes educational content based on student performance and learning patterns.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Next.js', 'Python', 'TensorFlow', 'PostgreSQL'],
        imageUrl: 'assets/images/project2.png',
        githubUrl: 'https://github.com/yourusername/ai-learning',
        liveUrl: 'https://ai-learning-platform.vercel.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'University Management System',
        description: 'Comprehensive desktop application for managing student records, course scheduling, and academic workflows.',
        categories: ['Desktop', 'All'],
        technologies: ['JavaFX', 'Spring Boot', 'MySQL', 'JasperReports'],
        imageUrl: 'assets/images/project3.png',
        githubUrl: 'https://github.com/yourusername/university-system',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'FinTech Mobile Wallet',
        description: 'Secure mobile wallet application with biometric authentication, QR payments, and transaction history.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Dart', 'Firebase', 'Biometric Auth'],
        imageUrl: 'assets/images/project4.png',
        githubUrl: 'https://github.com/yourusername/mobile-wallet',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Healthcare Analytics Dashboard',
        description: 'Real-time analytics dashboard for healthcare providers with patient insights and predictive modeling.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['React', 'Python', 'D3.js', 'FastAPI'],
        imageUrl: 'assets/images/project5.png',
        githubUrl: 'https://github.com/yourusername/healthcare-analytics',
        liveUrl: 'https://healthcare-dashboard.netlify.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Design System & Component Library',
        description: 'Comprehensive design system with reusable components, tokens, and guidelines for consistent UI/UX.',
        categories: ['UI/UX', 'Web', 'All'],
        technologies: ['Figma', 'Storybook', 'React', 'TypeScript'],
        imageUrl: 'assets/images/project6.png',
        githubUrl: 'https://github.com/yourusername/design-system',
        liveUrl: 'https://design-system-storybook.netlify.app',
        status: ProjectStatus.completed,
      ),
    ];
  }

  double _getHeaderFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 32;
      case LayoutType.tablet:
        return 40;
      case LayoutType.desktop:
        return 48;
    }
  }

  double _getSubtitleFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }

  double _getCategoryFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }

  double _getGridSpacing() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 20;
      case LayoutType.tablet:
        return 24;
      case LayoutType.desktop:
        return 30;
    }
  }

  double _getAspectRatio() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 0.85;
      case LayoutType.tablet:
        return 0.9;
      case LayoutType.desktop:
        return 0.95;
    }
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final LayoutType layoutType;
  final Animation<double> animation;

  const _ProjectCard({
    required this.project,
    required this.layoutType,
    required this.animation,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(widget.animation),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..scale(_isHovered ? 1.02 : 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered
                      ? AppColors.primary.withOpacity(0.3)
                      : Theme.of(context).dividerColor.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? AppColors.primary.withOpacity(0.15)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: _isHovered ? 20 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectImage(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProjectHeader(),
                          const SizedBox(height: 12),
                          _buildProjectDescription(),
                          const Spacer(),
                          _buildTechnologies(),
                          const SizedBox(height: 16),
                          _buildProjectActions(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              _getProjectIcon(),
              size: 60,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          if (widget.project.status == ProjectStatus.inProgress)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'In Progress',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Text(
      widget.project.title,
      style: AppTextStyles.headerSmall.copyWith(
        fontSize: _getTitleFontSize(),
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.displayLarge?.color,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProjectDescription() {
    return Text(
      widget.project.description,
      style: AppTextStyles.body.copyWith(
        fontSize: _getDescriptionFontSize(),
        height: 1.5,
        color: AppColors.textMuted,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widget.project.technologies.take(3).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Text(
            tech,
            style: AppTextStyles.body.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjectActions() {
    return Row(
      children: [
        if (widget.project.liveUrl != null)
          Expanded(
            child: _buildActionButton(
              label: 'Live Demo',
              icon: Icons.launch,
              onTap: () => _launchUrl(widget.project.liveUrl!),
              isPrimary: true,
            ),
          ),
        if (widget.project.liveUrl != null && widget.project.githubUrl != null)
          const SizedBox(width: 12),
        if (widget.project.githubUrl != null)
          Expanded(
            child: _buildActionButton(
              label: 'Code',
              icon: Icons.code,
              onTap: () => _launchUrl(widget.project.githubUrl!),
              isPrimary: widget.project.liveUrl == null,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isPrimary ? null : Border.all(
            color: AppColors.primary.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getProjectIcon() {
    if (widget.project.categories.contains('Mobile')) {
      return Icons.phone_android;
    } else if (widget.project.categories.contains('Web')) {
      return Icons.web;
    } else if (widget.project.categories.contains('Desktop')) {
      return Icons.desktop_windows;
    } else if (widget.project.categories.contains('Machine Learning')) {
      return Icons.psychology;
    } else if (widget.project.categories.contains('UI/UX')) {
      return Icons.design_services;
    }
    return Icons.code;
  }

  void _launchUrl(String url) {
    // Implement URL launcher
    print('Launching: $url');
  }

  double _getTitleFontSize() {
    switch (widget.layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double _getDescriptionFontSize() {
    switch (widget.layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }
}

// Project Model
class ProjectModel {
  final String title;
  final String description;
  final List<String> categories;
  final List<String> technologies;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final ProjectStatus status;

  ProjectModel({
    required this.title,
    required this.description,
    required this.categories,
    required this.technologies,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    required this.status,
  });
}

enum ProjectStatus { completed, inProgress }