import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksWidget extends StatelessWidget {
  final MainAxisAlignment alignment;

  const SocialLinksWidget({
    super.key,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor =
        isDarkMode
            ? Colors.white.withValues(alpha: 0.8)
            : Colors.black.withValues(alpha: 0.7);

    return Row(
      mainAxisAlignment: alignment,
      children: [
        SocialIconButton(
          icon: Icons.link,
          label: 'LinkedIn',
          color: iconColor,
          onTap:
              () => _handleSocialTap(
                'https://www.linkedin.com/in/oben-ayuk-90596a247?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
              ),
        ),
        SocialIconButton(
          icon: Icons.code,
          label: 'GitHub',
          color: iconColor,
          onTap: () => _handleSocialTap('https://github.com/OGZod'),
        ),
        SocialIconButton(
          icon: Icons.email,
          label: 'Email',
          color: iconColor,
          onTap: () => _handleSocialTap('tangayabah@gmail.com'),
        ),
      ],
    );
  }

  void _handleSocialTap(String url) async {
    if (url.toLowerCase().contains('gmail')) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: url, // Replace with your email
      );

      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        print('Could not launch email composer');
      }
    } else {
      if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        log('Could not launch $url');
      }
    }
  }
}

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Tooltip(
        message: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
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
