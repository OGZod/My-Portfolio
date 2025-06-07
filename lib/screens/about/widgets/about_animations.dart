import 'package:flutter/material.dart';

class AboutAnimations {
  final TickerProvider vsync;
  late AnimationController _animationController;
  late AnimationController _staggerController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late List<Animation<double>> _staggeredAnimations;

  AboutAnimations({required this.vsync}) {
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    _staggerController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Staggered animations for different sections
    _staggeredAnimations = List.generate(4, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.4,
            curve: Curves.easeOut,
          ),
        ),
      );
    });
  }

  void startAnimations() {
    _animationController.forward();
    _staggerController.forward();
  }

  void dispose() {
    _animationController.dispose();
    _staggerController.dispose();
  }

  // Getters
  Animation<double> get fadeInAnimation => _fadeInAnimation;

  Animation<Offset> get slideAnimation => _slideAnimation;

  List<Animation<double>> get staggeredAnimations => _staggeredAnimations;
}
