import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../providers/navigation_provider.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isFullWidth;
  final bool isCentered;

  const ActionButtonsWidget({
    super.key,
    this.isFullWidth = false,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isFullWidth) {
      return Column(
        children: [
          PrimaryButton(
            text: 'View My Work',
            fullWidth: true,
            onPressed: () => _navigateToProjects(context),
          ),
          const SizedBox(height: 16),
          OutlinedActionButton(
            text: 'Get In Touch',
            fullWidth: true,
            onPressed: () => _navigateToContact(context),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment:
          isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        PrimaryButton(
          text: 'View My Work',
          onPressed: () => _navigateToProjects(context),
        ),
        const SizedBox(width: 16),
        OutlinedActionButton(
          text: 'Get In Touch',
          onPressed: () => _navigateToContact(context),
        ),
      ],
    );
  }

  void _navigateToProjects(BuildContext context) {
    final nav = Provider.of<NavigationProvider>(context, listen: false);

    nav.navigateToProjects();
  }

  void _navigateToContact(BuildContext context) {
    final nav = Provider.of<NavigationProvider>(context, listen: false);
    nav.navigateToContact();
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
}

class OutlinedActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;

  const OutlinedActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: onPressed,
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
}
