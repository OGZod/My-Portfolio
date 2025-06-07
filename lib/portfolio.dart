import 'package:flutter/material.dart';
import 'package:my_portfolio_app/providers/navigation_provider.dart';
import 'package:my_portfolio_app/providers/theme_provider.dart';
import 'package:my_portfolio_app/screens/about/about_screen.dart';
import 'package:my_portfolio_app/screens/contact/contact_screen.dart';
import 'package:my_portfolio_app/screens/experience/experience_screen.dart';
import 'package:my_portfolio_app/screens/home/home_screen.dart';
import 'package:my_portfolio_app/screens/projects/projects_screen.dart';
import 'package:my_portfolio_app/screens/skills/skills_screen.dart';
import 'package:my_portfolio_app/widgets/navbar.dart';
import 'package:my_portfolio_app/widgets/responsive_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import 'constants/app_colors.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationProvider>(context,);

    return Consumer<ThemeProvider>(
      builder: (BuildContext context, themeProvider, Widget? child) {
        return Scaffold(
          body: Column(
            children: [
              NavBar(
                onItemSelected: (index) => _onItemSelected(index,),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      HomeScreen(key: nav.sectionKeys![0]),
                      AboutScreen(key: nav.sectionKeys![1]),
                      SkillsScreen(key: nav.sectionKeys![2]),
                      ProjectsScreen(key: nav.sectionKeys![3]),
                      ExperienceScreen(key: nav.sectionKeys![4]),
                      ContactScreen(key: nav.sectionKeys![5]),
                    ],
                  ),
                ),
              ),
            ],
          ),
          endDrawer:
          ResponsiveWrapper.isMobile(context) ||
              ResponsiveWrapper.isTablet(context)
              ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.getBackgroundColor(
                      themeProvider.currentThemeIsDark,
                    ),
                  ),
                  child: SvgPicture.asset('assets/images/og.png'),
                ),
                _buildDrawerItem('Home', 0,),
                _buildDrawerItem('About', 1,),
                _buildDrawerItem('Skills', 2, ),
                _buildDrawerItem('Projects', 3, ),
                _buildDrawerItem('Experience', 4, ),
                _buildDrawerItem('Contact', 5, ),
                const Divider(),
                _buildThemeToggle(),
              ],
            ),
          )
              : null,
        );
      },
    );
  }

  Widget _buildDrawerItem(
    String title,
    int index,
  ) {
    final nav = Provider.of<NavigationProvider>(context, listen: true);
    return ListTile(
      title: Text(title),
      selected: nav.selectedIndex == index,
      onTap: () {
        _onItemSelected(index,);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildThemeToggle() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.currentThemeIsDark;

    return Column(
      children: [
        ListTile(
          leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
          title: Text(isDarkMode ? 'Dark Mode' : 'Light Mode'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (_) {
              themeProvider.toggleTheme();
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_system_daydream),
          title: const Text('Use System Theme'),
          trailing: Switch(
            value: themeProvider.isSystemTheme,
            onChanged: (_) {
              themeProvider.setSystemTheme();
            },
          ),
        ),
      ],
    );
  }

  void _onItemSelected(int index, ) {
    final nav = Provider.of<NavigationProvider>(context, listen: false);
    nav.setSelectedIndex(index);

  }
}
