import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../widgets/responsive_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      mobile: _buildMobileLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, I\'m',
                  style: AppTextStyles.body.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your Name',
                  style: AppTextStyles.headerLarge.copyWith(fontSize: 48),
                ),
                Text(
                  'Flutter Developer',
                  style: AppTextStyles.headerMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'I build beautiful, responsive and feature-rich mobile and web applications using Flutter.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Scroll to contact section
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Get In Touch'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1),
                  image: const DecorationImage(
                    image: AssetImage('assets/profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
              image: const DecorationImage(
                image: AssetImage('assets/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Hello, I\'m',
            style: AppTextStyles.body.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Your Name',
            style: AppTextStyles.headerLarge.copyWith(fontSize: 32),
          ),
          Text(
            'Flutter Developer',
            style: AppTextStyles.headerMedium.copyWith(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I build beautiful, responsive and feature-rich mobile and web applications using Flutter.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Scroll to contact section
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Get In Touch'),
          ),
        ],
      ),
    );
  }
}