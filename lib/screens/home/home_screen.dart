// home_screen.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/home/widgets/profile_image_widget.dart';
import 'package:my_portfolio_app/screens/skills_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/responsive_wrapper.dart';
import 'widgets/hero_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

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

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveWrapper(
          mobile: _HomeScreenLayout(
            layoutType: LayoutType.mobile,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            rotationController: _rotationController,
          ),
          tablet: _HomeScreenLayout(
            layoutType: LayoutType.tablet,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            rotationController: _rotationController,
          ),
          desktop: _HomeScreenLayout(
            layoutType: LayoutType.desktop,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            rotationController: _rotationController,
          ),
        );
      },
    );
  }
}

enum LayoutType { mobile, tablet, desktop }

class _HomeScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController rotationController;

  const _HomeScreenLayout({
    required this.layoutType,
    required this.fadeInAnimation,
    required this.slideAnimation,
    required this.rotationController,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    switch (layoutType) {
      case LayoutType.mobile:
        return _buildMobileLayout(context, isDarkMode);
      case LayoutType.tablet:
        return _buildTabletLayout(context, isDarkMode);
      case LayoutType.desktop:
        return _buildDesktopLayout(context, isDarkMode);
    }
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDarkMode) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: _buildAnimatedContent(
              child: HeroSection(
                nameStyle: AppTextStyles.headerLarge.copyWith(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
                titleStyle: AppTextStyles.headerMedium.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                descriptionStyle: AppTextStyles.body.copyWith(
                  fontSize: 18,
                  height: 1.6,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                showSocialLinks: true,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 2,
            child: Center(
              child: ProfileImageWidget(
                size: 380,
                rotationController: rotationController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isDarkMode) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: _buildAnimatedContent(
              child: HeroSection(
                nameStyle: AppTextStyles.headerLarge.copyWith(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
                titleStyle: AppTextStyles.headerMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                descriptionStyle: AppTextStyles.body.copyWith(
                  fontSize: 18,
                  height: 1.6,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                showSocialLinks: true,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Center(
              child: ProfileImageWidget(
                size: 260,
                rotationController: rotationController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      child: _buildAnimatedContent(
        child: Column(
          children: [
            ProfileImageWidget(
              size: 180,
              rotationController: rotationController,
            ),
            const SizedBox(height: 40),
            HeroSection(
              nameStyle: AppTextStyles.headerLarge.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
              titleStyle: AppTextStyles.headerMedium.copyWith(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              descriptionStyle: AppTextStyles.body.copyWith(
                fontSize: 18,
                height: 1.6,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              showSocialLinks: true,
              crossAxisAlignment: CrossAxisAlignment.center,
              isFullWidthButtons: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContent({required Widget child}) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }
}