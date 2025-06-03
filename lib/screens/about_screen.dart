// import 'package:flutter/material.dart';
// import 'package:my_portfolio_app/widgets/theme_consumer.dart';
//
// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
//
// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});
//
//   static const double desktopBreakpoint =
//       800; // Width threshold for desktop layout
//
//   @override
//   Widget build(BuildContext context) {
//     return ThemeConsumer(
//       builder:
//           (context, isDarkMode) => Container(
//             constraints: const BoxConstraints(minHeight: 500),
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 if (constraints.maxWidth >= desktopBreakpoint) {
//                   // Desktop layout: two-column side by side
//                   return Padding(
//                     padding: const EdgeInsets.all(32),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Left column - About Me & Professional Experience
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'About Me',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.getTextColor(isDarkMode),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 'I am a Master of Science in Engineering from the University of Buea, Cameroon. '
//                                 'As a software engineer, I operate mainly as a fullstack developer, '
//                                 'specializing in building applications across mobile, desktop, and web platforms.',
//                                 style:  AppTextStyles.body.copyWith(
//                                   fontSize: 18,
//                                   height: 1.6,
//                                   color: Theme.of(context).textTheme.bodyLarge?.color,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'In addition to my development work, I am a part-time university lecturer at several universities, '
//                                 'where I teach and mentor students in software engineering and related fields.',
//                                 style:  AppTextStyles.body.copyWith(
//                                   fontSize: 18,
//                                   height: 1.6,
//                                   color: Theme.of(context).textTheme.bodyLarge?.color,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(width: 64),
//
//                         // Right column - Technical Expertise
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 12),
//                               Text(
//                                 '• Flutter (mobile, desktop, and web development)\n'
//                                 '• Node.js, Spring Boot, Next.js, JavaFX\n'
//                                 '• Machine Learning using Python\n'
//                                 '• UI/UX Designing',
//                                 style:  AppTextStyles.body.copyWith(
//                                   fontSize: 18,
//                                   height: 1.6,
//                                   color: Theme.of(context).textTheme.bodyLarge?.color,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   // Mobile layout: single column, stacked vertically
//                   return SingleChildScrollView(
//                     padding: const EdgeInsets.all(24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('About Me', style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.getTextColor(isDarkMode),
//                         ),),
//                         const SizedBox(height: 16),
//                         Text(
//                           'I am a Master of Science in Engineering from the University of Buea, Cameroon. '
//                           'As a software engineer, I operate mainly as a fullstack developer, '
//                           'specializing in building applications across mobile, desktop, and web platforms.',
//                           style: AppTextStyles.body.copyWith(
//                             fontSize: 18,
//                             height: 1.6,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         const SizedBox(height: 12),
//                         Text(
//                           '• Flutter (mobile, desktop, and web development)\n'
//                           '• Node.js, Spring Boot, Next.js, JavaFX\n'
//                           '• Machine Learning using Python\n'
//                           '• UI/UX Designing',
//                           style: AppTextStyles.body.copyWith(
//                             fontSize: 18,
//                             height: 1.6,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         const SizedBox(height: 12),
//                         Text(
//                           'In addition to my development work, I am a part-time university lecturer at several universities, '
//                           'where I teach and mentor students in software engineering and related fields.',
//                           style: AppTextStyles.body.copyWith(
//                             fontSize: 18,
//                             height: 1.6,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//     );
//   }
// about_screen.dart
// about_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../providers/theme_provider.dart';
import '../widgets/responsive_wrapper.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _staggerController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _staggeredAnimations;

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
      duration: const Duration(milliseconds: 2000),
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

    // Staggered animations for different sections
    _staggeredAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.4,
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
          mobile: _AboutScreenLayout(
            layoutType: LayoutType.mobile,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
          ),
          tablet: _AboutScreenLayout(
            layoutType: LayoutType.tablet,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
          ),
          desktop: _AboutScreenLayout(
            layoutType: LayoutType.desktop,
            fadeInAnimation: _fadeInAnimation,
            slideAnimation: _slideAnimation,
            staggeredAnimations: _staggeredAnimations,
          ),
        );
      },
    );
  }
}

enum LayoutType { mobile, tablet, desktop }

class _AboutScreenLayout extends StatelessWidget {
  final LayoutType layoutType;
  final Animation<double> fadeInAnimation;
  final Animation<Offset> slideAnimation;
  final List<Animation<double>> staggeredAnimations;

  const _AboutScreenLayout({
    required this.layoutType,
    required this.fadeInAnimation,
    required this.slideAnimation,
    required this.staggeredAnimations,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedHeader(context),
          const SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAnimatedSection(
                      context,
                      0,
                      _AboutMeSection(layoutType: layoutType),
                    ),
                    const SizedBox(height: 40),
                    _buildAnimatedSection(
                      context,
                      1,
                      _EducationSection(layoutType: layoutType),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAnimatedSection(
                      context,
                      2,
                      _PhilosophySection(layoutType: layoutType),
                    ),
                    const SizedBox(height: 40),
                    _buildAnimatedSection(
                      context,
                      3,
                      _ValuesSection(layoutType: layoutType),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedHeader(context),
          const SizedBox(height: 50),
          _buildAnimatedSection(
            context,
            0,
            _AboutMeSection(layoutType: layoutType),
          ),
          const SizedBox(height: 40),
          _buildAnimatedSection(
            context,
            1,
            _EducationSection(layoutType: layoutType),
          ),
          const SizedBox(height: 40),
          _buildAnimatedSection(
            context,
            2,
            _PhilosophySection(layoutType: layoutType),
          ),
          const SizedBox(height: 40),
          _buildAnimatedSection(
            context,
            3,
            _ValuesSection(layoutType: layoutType),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedHeader(context),
          const SizedBox(height: 40),
          _buildAnimatedSection(
            context,
            0,
            _AboutMeSection(layoutType: layoutType),
          ),
          const SizedBox(height: 30),
          _buildAnimatedSection(
            context,
            1,
            _EducationSection(layoutType: layoutType),
          ),
          const SizedBox(height: 30),
          _buildAnimatedSection(
            context,
            2,
            _PhilosophySection(layoutType: layoutType),
          ),
          const SizedBox(height: 30),
          _buildAnimatedSection(
            context,
            3,
            _ValuesSection(layoutType: layoutType),
          ),
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
              'About Me',
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
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(BuildContext context, int index, Widget child) {
    return FadeTransition(
      opacity: staggeredAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(staggeredAnimations[index]),
        child: child,
      ),
    );
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
}

class _AboutMeSection extends StatelessWidget {
  final LayoutType layoutType;

  const _AboutMeSection({required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'My Journey',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.psychology_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Passion-Driven Engineer',
                      style: AppTextStyles.headerSmall.copyWith(
                        fontSize: _getTitleFontSize(),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'With a Master\'s in Engineering from the University of Buea, I blend academic rigor with practical innovation. My approach to software engineering is rooted in creating solutions that not only meet technical requirements but also deliver exceptional user experiences.',
                  style: AppTextStyles.body.copyWith(
                    fontSize: _getBodyFontSize(),
                    height: 1.7,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      color: AppColors.secondary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Educator & Mentor',
                      style: AppTextStyles.headerSmall.copyWith(
                        fontSize: _getTitleFontSize(),
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'As a part-time university lecturer across multiple institutions, I\'m committed to nurturing the next generation of engineers. I believe in the power of knowledge sharing and the importance of bridging the gap between academic theory and industry practice.',
                  style: AppTextStyles.body.copyWith(
                    fontSize: _getBodyFontSize(),
                    height: 1.7,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getTitleFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double _getBodyFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }
}

class _EducationSection extends StatelessWidget {
  final LayoutType layoutType;

  const _EducationSection({required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'Education',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEducationItem(
            context,
            'Master of Science in Engineering',
            'University of Buea, Cameroon',
            'Advanced coursework in software engineering, systems design, and research methodologies',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(BuildContext context, String degree, String institution, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: AppTextStyles.headerSmall.copyWith(
              fontSize: _getTitleFontSize(),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            institution,
            style: AppTextStyles.body.copyWith(
              fontSize: _getBodyFontSize(),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTextStyles.body.copyWith(
              fontSize: _getBodyFontSize() - 1,
              height: 1.5,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  double _getTitleFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double _getBodyFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }
}

class _PhilosophySection extends StatelessWidget {
  final LayoutType layoutType;

  const _PhilosophySection({required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'My Philosophy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhilosophyCard(
            context,
            Icons.lightbulb_outline_rounded,
            'Innovation Through Quality',
            'I believe that exceptional software emerges from the intersection of technical excellence and creative problem-solving. Every project is an opportunity to push boundaries while maintaining the highest standards of quality.',
          ),
          const SizedBox(height: 16),
          _buildPhilosophyCard(
            context,
            Icons.groups_rounded,
            'Knowledge Multiplier',
            'Teaching has taught me that the greatest impact comes from empowering others. Whether mentoring students or collaborating with teams, I strive to be a catalyst for growth and learning.',
          ),
          const SizedBox(height: 16),
          _buildPhilosophyCard(
            context,
            Icons.trending_up_rounded,
            'Continuous Evolution',
            'Technology evolves rapidly, and so must we. I\'m committed to lifelong learning, staying current with emerging technologies, and adapting to new challenges with enthusiasm and expertise.',
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophyCard(BuildContext context, IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.headerSmall.copyWith(
                    fontSize: _getTitleFontSize(),
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyles.body.copyWith(
                    fontSize: _getBodyFontSize(),
                    height: 1.6,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getTitleFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }

  double _getBodyFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }
}

class _ValuesSection extends StatelessWidget {
  final LayoutType layoutType;

  const _ValuesSection({required this.layoutType});

  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'What Drives Me',
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).cardColor,
              Theme.of(context).cardColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Impact Through Code & Education',
                  style: AppTextStyles.headerSmall.copyWith(
                    fontSize: _getTitleFontSize(),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'I\'m driven by the opportunity to make a meaningful difference through technology. Whether it\'s developing solutions that solve real-world problems or mentoring the next generation of engineers, my goal is to contribute to a future where technology serves humanity better.',
              style: AppTextStyles.body.copyWith(
                fontSize: _getBodyFontSize(),
                height: 1.7,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.secondary.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note_alt,
                    color: AppColors.secondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '"Excellence is not a destination, it\'s a continuous journey of learning, growing, and giving back."',
                      style: AppTextStyles.body.copyWith(
                        fontSize: _getBodyFontSize(),
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getTitleFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double _getBodyFontSize() {
    switch (layoutType) {
      case LayoutType.mobile:
        return 16;
      case LayoutType.tablet:
        return 17;
      case LayoutType.desktop:
        return 18;
    }
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionContainer({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headerMedium.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        const SizedBox(height: 20),
        child,
      ],
    );
  }
}
