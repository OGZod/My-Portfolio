import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/responsive_wrapper.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with TickerProviderStateMixin {
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

enum LayoutType { mobile, tablet, desktop }

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
          colors: isDarkMode
              ? [
            const Color(0xFF1a1a1a),
            const Color(0xFF0f0f0f),
          ]
              : [
            const Color(0xFFf8fafc),
            const Color(0xFFe2e8f0),
          ],
        ),
      ),
      child: _buildAnimatedContent(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: _buildContactCard(context, isDarkMode),
            ),
            const SizedBox(width: 60),
            Expanded(
              flex: 2,
              child: _buildWelcomeSection(context, 56, 20),
            ),
          ],
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
          colors: isDarkMode
              ? [
            const Color(0xFF1a1a1a),
            const Color(0xFF0f0f0f),
          ]
              : [
            const Color(0xFFf8fafc),
            const Color(0xFFe2e8f0),
          ],
        ),
      ),
      child: _buildAnimatedContent(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: _buildContactCard(context, isDarkMode),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: _buildWelcomeSection(context, 42, 18),
            ),
          ],
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
          colors: isDarkMode
              ? [
            const Color(0xFF1a1a1a),
            const Color(0xFF0f0f0f),
          ]
              : [
            const Color(0xFFf8fafc),
            const Color(0xFFe2e8f0),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: _buildAnimatedContent(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildWelcomeSection(context, 32, 16),
                const SizedBox(height: 40),
                _buildContactCard(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, double titleSize, double bodySize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: layoutType == LayoutType.mobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.7),
            ],
          ).createShader(bounds),
          child: Text(
            "Let's Connect!",
            style: AppTextStyles.headerLarge.copyWith(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: layoutType == LayoutType.mobile
                ? TextAlign.center
                : TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ready to bring your ideas to life? Reach out through any of the platforms below and let\'s start a conversation!',
          style: AppTextStyles.body.copyWith(
            fontSize: bodySize,
            height: 1.6,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
          ),
          textAlign: layoutType == LayoutType.mobile
              ? TextAlign.center
              : TextAlign.left,
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Usually responds within 24 hours',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context, bool isDarkMode) {
    return ScaleTransition(
      scale: cardScaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF262626).withOpacity(0.8)
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.connect_without_contact,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Get In Touch',
                  style: AppTextStyles.headerMedium.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildContactInfo(context, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isDarkMode) {
    final contacts = [
      {
        'icon': Icons.email_outlined,
        'label': 'Email',
        'value': 'your.email@example.com',
        'subtitle': 'Professional inquiries',
        'url': 'mailto:your.email@example.com',
        'color': const Color(0xFF4285f4),
      },
      {
        'icon': Icons.phone_outlined,
        'label': 'Phone',
        'value': '+1 (123) 456-7890',
        'subtitle': 'Call or text',
        'url': 'tel:+11234567890',
        'color': const Color(0xFF34a853),
      },
      {
        'icon': Icons.work_outline,
        'label': 'LinkedIn',
        'value': 'linkedin.com/in/yourprofile',
        'subtitle': 'Professional network',
        'url': 'https://www.linkedin.com/in/yourprofile',
        'color': const Color(0xFF0077b5),
      },
      {
        'icon': Icons.code_outlined,
        'label': 'GitHub',
        'value': 'github.com/yourusername',
        'subtitle': 'View my projects',
        'url': 'https://github.com/yourusername',
        'color': isDarkMode ? Colors.white : const Color(0xFF24292e),
      },
    ];

    return Column(
      children: contacts.asMap().entries.map((entry) {
        final index = entry.key;
        final contact = entry.value;

        return TweenAnimationBuilder(
          duration: Duration(milliseconds: 600 + (index * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _buildContactItem(
                    context,
                    icon: contact['icon'] as IconData,
                    label: contact['label'] as String,
                    value: contact['value'] as String,
                    subtitle: contact['subtitle'] as String,
                    iconColor: contact['color'] as Color,
                    onTap: () => _launchUrl(contact['url'] as String),
                    isDarkMode: isDarkMode,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildContactItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required String subtitle,
        required Color iconColor,
        required VoidCallback onTap,
        required bool isDarkMode,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.headerMedium.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        color: iconColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        log( 'Could not launch $url');
      }
    } catch (e) {
      log( 'Error launching $url');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
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