import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
// import 'screens/skills_screen.dart';
// import 'screens/projects_screen.dart';
// import 'screens/experience_screen.dart';
import 'screens/contact_screen.dart';
import 'widgets/navbar.dart';
import 'widgets/responsive_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oben Gilbert - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
      ),
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
                  // SkillsScreen(key: _keys[2]),
                  // ProjectsScreen(key: _keys[3]),
                  // ExperienceScreen(key: _keys[4]),
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
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: const Text(
                'YourName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem('Home', 0),
            _buildDrawerItem('About', 1),
            _buildDrawerItem('Skills', 2),
            _buildDrawerItem('Projects', 3),
            _buildDrawerItem('Experience', 4),
            _buildDrawerItem('Contact', 5),
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