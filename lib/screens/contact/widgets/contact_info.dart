
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import 'contact_item.dart';

class ContactInfo extends StatelessWidget {
  final bool isDarkMode;

  const ContactInfo({super.key, required this.isDarkMode});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        log('Could not launch $url');
      }
    } catch (e) {
      log('Error launching $url');
    }
  }

  @override
  Widget build(BuildContext context) {
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
      children:
          contacts.asMap().entries.map((entry) {
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
                      child: ContactItem(
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
}