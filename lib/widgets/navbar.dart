import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
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
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'YourName',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
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
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'YourName',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
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
                color: selectedIndex == index ? AppColors.primary : AppColors.text,
                fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}