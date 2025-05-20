import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';
import 'responsive_wrapper.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      mobile: _buildMobileNavBar(context),
      desktop: _buildDesktopNavBar(context),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: AppColors.getBackgroundColor(themeProvider.currentThemeIsDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/svgs/ogZod.svg'),
          Row(
            children: [
              _buildNavItem('Home', 0),
              _buildNavItem('About', 1),
              _buildNavItem('Skills', 2),
              _buildNavItem('Projects', 3),
              _buildNavItem('Experience', 4),
              _buildNavItem('Contact', 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNavBar(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.getBackgroundColor(themeProvider.currentThemeIsDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/svgs/ogZod.svg'),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: () => onItemSelected(index),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: selectedIndex == index ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedIndex == index ? AppColors.primary : AppColors.getTextColor(false),
                fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}