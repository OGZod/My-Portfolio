import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_screen_layout.dart';
import 'package:provider/provider.dart';
import '../../functions/helpers.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/responsive_wrapper.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _staggerController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _staggeredAnimations;

  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Mobile',
    'Web',
    'Desktop',
    'Machine Learning',
    'UI/UX',
  ];

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
          mobile: ProjectsScreenLayout(
            layoutType: LayoutType.mobile,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
            selectedCategory: _selectedCategory,
            categories: _categories,
            onCategoryChanged: _onCategoryChanged,
          ),
          tablet: ProjectsScreenLayout(
            layoutType: LayoutType.tablet,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
            selectedCategory: _selectedCategory,
            categories: _categories,
            onCategoryChanged: _onCategoryChanged,
          ),
          desktop: ProjectsScreenLayout(
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

