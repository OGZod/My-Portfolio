import 'package:flutter/material.dart';
import 'package:my_portfolio_app/portfolio.dart';
import 'package:my_portfolio_app/providers/navigation_provider.dart';
import 'package:my_portfolio_app/widgets/bug_builder.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'providers/theme_provider.dart';

void main() {
  ErrorWidget.builder = bugBuilder;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) =>
                  NavigationProvider()
                    ..initializeKeys(List.generate(6, (_) => GlobalKey())),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, s) => MyApp(),
      ),
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
      themeMode:
          themeProvider.isSystemTheme
              ? ThemeMode.system
              : (themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      home: const PortfolioApp(),
    );
  }
}
