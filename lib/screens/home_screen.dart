

import 'package:flutter/material.dart';
import 'package:my_portfolio_app/functions/get_time_of_day.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/responsive_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ResponsiveWrapper(
      mobile: _buildMobileLayout(context, isDarkMode),
      desktop: _buildDesktopLayout(context, isDarkMode),
      tablet: _buildTabletLayout(context, isDarkMode),
    );
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
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeadingPill(context, isDarkMode),
                    const SizedBox(height: 24),
                    Text(
                      'Oben Ayuk Gilbert',
                      style: AppTextStyles.headerLarge.copyWith(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Flutter Developer',
                          style: AppTextStyles.headerMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),
                        _buildAnimatedDot(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'I build beautiful, responsive and feature-rich mobile and web applications that deliver exceptional user experiences.',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 18,
                        height: 1.6,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        _buildPrimaryButton(context, 'View My Work'),
                        const SizedBox(width: 16),
                        _buildOutlinedButton(
                          context,
                          'Get In Touch',
                          isDarkMode,
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    _buildSocialLinks(isDarkMode),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 2,
            child: Center(child: _buildProfileImage(isDarkMode, 380)),
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
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeadingPill(context, isDarkMode),
                    const SizedBox(height: 16),
                    Text(
                      'Oben Ayuk Gilbert',
                      style: AppTextStyles.headerLarge.copyWith(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Flutter Developer',
                          style: AppTextStyles.headerMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildAnimatedDot(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'I build beautiful, responsive and feature-rich mobile and web applications that deliver exceptional user experiences.',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 16,
                        height: 1.6,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        _buildPrimaryButton(context, 'View My Work'),
                        const SizedBox(width: 16),
                        _buildOutlinedButton(
                          context,
                          'Get In Touch',
                          isDarkMode,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _buildSocialLinks(isDarkMode),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Center(child: _buildProfileImage(isDarkMode, 260)),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(isDarkMode, 180),
                const SizedBox(height: 40),
                _buildHeadingPill(context, isDarkMode),
                const SizedBox(height: 16),
                Text(
                  'Oben Ayuk Gilbert',
                  style: AppTextStyles.headerLarge.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Flutter Developer',
                      style: AppTextStyles.headerMedium.copyWith(
                        color: AppColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildAnimatedDot(),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'I build beautiful, responsive and feature-rich mobile and web applications that deliver exceptional user experiences.',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 16,
                    height: 1.6,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    _buildPrimaryButton(
                      context,
                      'View My Work',
                      fullWidth: true,
                    ),
                    const SizedBox(height: 16),
                    _buildOutlinedButton(
                      context,
                      'Get In Touch',
                      isDarkMode,
                      fullWidth: true,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                _buildSocialLinks(isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingPill(BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        '${getTimeOfDay()}, I\'m',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildAnimatedDot() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 8 * value,
                spreadRadius: 2 * value,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context,
    String text, {
    bool fullWidth = false,
  }) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to projects section
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        minimumSize: fullWidth ? const Size(double.infinity, 54) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildOutlinedButton(
    BuildContext context,
    String text,
    bool isDarkMode, {
    bool fullWidth = false,
  }) {
    return OutlinedButton(
      onPressed: () {
        // Scroll to contact section
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.white : AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        minimumSize: fullWidth ? const Size(double.infinity, 54) : null,
        side: BorderSide(
          color:
              isDarkMode
                  ? Colors.white.withValues(alpha: 0.5)
                  : AppColors.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isDarkMode, double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background gradient circle
        Container(
          width: size * 1.05,
          height: size * 1.05,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.brown.withValues(alpha: 0.8),
                Colors.brown.withValues(alpha: 0.2),
              ],
            ),
          ),
        ),

        // Animated rotating circle
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * math.pi,
              child: Container(
                width: size * 1.1,
                height: size * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isDarkMode
                            ? Colors.white.withValues(alpha: 0.15)
                            : Colors.brown.withValues(alpha: 0.15),
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: Stack(
                  children: List.generate(8, (index) {
                    final angle = (index / 8) * 2 * math.pi;
                    return Positioned(
                      left: size * 0.55 + math.cos(angle) * size * 0.55,
                      top: size * 0.55 + math.sin(angle) * size * 0.55,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),

        // Profile image
        Hero(
          tag: 'profile-image',
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isDarkMode
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.white,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      isDarkMode
                          ? Colors.black.withValues(alpha: 0.2)
                          : Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
              image: const DecorationImage(
                image: NetworkImage(
                  'https://pbs.twimg.com/profile_images/1640246277932822529/mBeTDZje.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(bool isDarkMode) {
    final Color iconColor =
        isDarkMode
            ? Colors.white.withValues(alpha: 0.8)
            : Colors.black.withValues(alpha: 0.7);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSocialIcon(iconColor, Icons.language, 'Website'),
        _buildSocialIcon(iconColor, Icons.link, 'LinkedIn'),
        _buildSocialIcon(iconColor, Icons.code, 'GitHub'),
        _buildSocialIcon(iconColor, Icons.email, 'Email'),
      ],
    );
  }

  Widget _buildSocialIcon(Color color, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Tooltip(
        message: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              // Handle social link tap
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
