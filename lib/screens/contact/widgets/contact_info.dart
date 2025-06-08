
import 'package:flutter/material.dart';
import 'package:my_portfolio_app/functions/helpers.dart';
import 'contact_item.dart';

class ContactInfo extends StatelessWidget {
  final bool isDarkMode;

  const ContactInfo({super.key, required this.isDarkMode});


  @override
  Widget build(BuildContext context) {
    final contacts = [
      {
        'icon': Icons.email_outlined,
        'label': 'Email',
        'value': 'obenayuk443@gmail.com',
        'subtitle': 'Professional inquiries',
        'url': 'obenayuk443@gmail.com',
        'color': const Color(0xFF4285f4),
      },
      {
        'icon': Icons.phone_outlined,
        'label': 'Phone',
        'value': '+237 672002649',
        'subtitle': 'Call or text',
        'url': 'tel:+237672002649',
        'color': const Color(0xFF34a853),
      },
      {
        'icon': Icons.work_outline,
        'label': 'LinkedIn',
        'value': 'linkedin.com/in/oben-gilbert',
        'subtitle': 'Professional network',
        'url': 'https://www.linkedin.com/in/oben-ayuk-90596a247?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
        'color': const Color(0xFF0077b5),
      },
      {
        'icon': Icons.code_outlined,
        'label': 'GitHub',
        'value': 'https://github.com/OGZod',
        'subtitle': 'View my projects',
        'url': 'https://github.com/OGZod',
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
                        onTap: () => handleSocialTap(contact['url'] as String),
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