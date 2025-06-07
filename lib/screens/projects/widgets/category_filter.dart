import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_layout.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;
  final ResponsiveLayoutConfig config;
  final Animation<double> fadeAnimation;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.config,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Container(
        width: double.infinity,
        child: Wrap(
          alignment: config.categoryWrapAlignment,
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            return CategoryChip(
              category: category,
              isSelected: category == selectedCategory,
              onTap: () => onCategoryChanged(category),
              config: config,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;
  final ResponsiveLayoutConfig config;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Theme.of(context).dividerColor.withOpacity(0.2),
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Text(
          category,
          style: AppTextStyles.body.copyWith(
            fontSize: config.categoryFontSize,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}