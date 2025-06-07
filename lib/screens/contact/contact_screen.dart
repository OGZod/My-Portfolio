import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/contact/widgets/contact_card.dart';
import 'package:my_portfolio_app/screens/contact/widgets/welcome_section.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/responsive_wrapper.dart';
import '../../functions/helpers.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _cardScaleAnimation;

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

    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _cardScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _cardAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveWrapper(
          mobile: _ContactScreenLayout(
            layoutType: LayoutType.mobile,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            cardScaleAnimation: _cardScaleAnimation,
          ),
          tablet: _ContactScreenLayout(
            layoutType: LayoutType.tablet,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            cardScaleAnimation: _cardScaleAnimation,
          ),
          desktop: _ContactScreenLayout(
            layoutType: LayoutType.desktop,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            cardScaleAnimation: _cardScaleAnimation,
          ),
        );
      },
    );
  }
}

class _ContactScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> cardScaleAnimation;

  const _ContactScreenLayout({
    required this.layoutType,
    required this.fadeInAnimation,
    required this.slideAnimation,
    required this.cardScaleAnimation,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
          isDarkMode
              ? [const Color(0xFF1a1a1a), const Color(0xFF0f0f0f)]
              : [const Color(0xFFf8fafc), const Color(0xFFe2e8f0)],
        ),
      ),
      child: FadeTransition(
        opacity: fadeInAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: ContactCard(
                      cardScaleAnimation: cardScaleAnimation, isDarkMode: isDarkMode)),
              const SizedBox(width: 60),
              Expanded(flex: 2, child: WelcomeSection(layoutType: layoutType, titleSize: 56, bodySize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isDarkMode) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
          isDarkMode
              ? [const Color(0xFF1a1a1a), const Color(0xFF0f0f0f)]
              : [const Color(0xFFf8fafc), const Color(0xFFe2e8f0)],
        ),
      ),
      child: FadeTransition(
        opacity: fadeInAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: ContactCard(
                      cardScaleAnimation: cardScaleAnimation, isDarkMode: isDarkMode)),
              const SizedBox(width: 40),
              Expanded(flex: 2, child: WelcomeSection(layoutType: layoutType, titleSize: 42, bodySize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
          isDarkMode
              ? [const Color(0xFF1a1a1a), const Color(0xFF0f0f0f)]
              : [const Color(0xFFf8fafc), const Color(0xFFe2e8f0)],
        ),
      ),
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: fadeInAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WelcomeSection(layoutType: layoutType, titleSize: 32, bodySize: 16),
                  const SizedBox(height: 40),
                  ContactCard(
                      cardScaleAnimation: cardScaleAnimation, isDarkMode: isDarkMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}