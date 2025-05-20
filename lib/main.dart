import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/experience_screen.dart';
import 'package:my_portfolio_app/screens/projects_screen.dart';
import 'package:my_portfolio_app/screens/skills_screen.dart';
import 'package:my_portfolio_app/widgets/bug_builder.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'constants/app_colors.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'widgets/navbar.dart';
import 'widgets/responsive_wrapper.dart';

void main() {
  ErrorWidget.builder = bugBuilder;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Oben Gilbert - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.getBackgroundColor(false),
        fontFamily: 'Poppins',
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.getBackgroundColor(true),
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      themeMode: themeProvider.isSystemTheme
          ? ThemeMode.system
          : (themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      home: const PortfolioApp(),
    );
  }
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  int _selectedIndex = 0;
  final _scrollController = ScrollController();
  final List<GlobalKey> _keys = List.generate(6, (_) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          NavBar(
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemSelected,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HomeScreen(key: _keys[0]),
                  AboutScreen(key: _keys[1]),
                  SkillsScreen(key: _keys[2]),
                  ProjectsScreen(key: _keys[3]),
                  ExperienceScreen(key: _keys[4]),
                  ContactScreen(key: _keys[5]),
                ],
              ),
            ),
          ),
        ],
      ),
      endDrawer: ResponsiveWrapper.isMobile(context)
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(themeProvider.currentThemeIsDark),
              ),
              child: SvgPicture.asset('assets/images/og.png'),
            ),
            _buildDrawerItem('Home', 0),
            _buildDrawerItem('About', 1),
            _buildDrawerItem('Skills', 2),
            _buildDrawerItem('Projects', 3),
            _buildDrawerItem('Experience', 4),
            _buildDrawerItem('Contact', 5),
            const Divider(),
            _buildThemeToggle(),
          ],
        ),
      )
          : null,
    );
  }

  Widget _buildDrawerItem(String title, int index) {
    return ListTile(
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemSelected(index);
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

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}