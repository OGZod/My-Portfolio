import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../constants/app_colors.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';
import 'responsive_wrapper.dart';

class NavBar extends StatelessWidget {
  final Function(int) onItemSelected;

  const NavBar({
    super.key,
    required this.onItemSelected,
  });

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
          SvgPicture.asset('assets/svgs/ogZod.svg',width: 50,),
          Row(
            children: [
              _buildNavItem('Home', 0,context),
              _buildNavItem('About', 1,context),
              _buildNavItem('Skills', 2,context),
              _buildNavItem('Projects', 3,context),
              _buildNavItem('Experience', 4,context),
              _buildNavItem('Contact', 5,context),
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
          SvgPicture.asset('assets/svgs/ogZod.svg',width: 50,),
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

  Widget _buildNavItem(String title, int index, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final nav = Provider.of<NavigationProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: () => onItemSelected(index),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color:
                nav.selectedIndex == index
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color:
                nav.selectedIndex != index
                        ? AppColors.textMuted
                        : AppColors.getTextColor(
                          themeProvider.currentThemeIsDark,
                        ),
                fontWeight:
                nav.selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
