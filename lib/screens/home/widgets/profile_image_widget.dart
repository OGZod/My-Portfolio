import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileImageWidget extends StatelessWidget {
  final double size;
  final AnimationController rotationController;
  final String? imageUrl;

  const ProfileImageWidget({
    super.key,
    required this.size,
    required this.rotationController,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.center,
      children: [
        _BackgroundGradientCircle(size: size),
        _AnimatedRotatingBorder(
          size: size,
          rotationController: rotationController,
          isDarkMode: isDarkMode,
        ),
        _ProfileImage(
          size: size,
          isDarkMode: isDarkMode,
          imageUrl: imageUrl ?? 
              'https://avatars.githubusercontent.com/u/121359450?v=4',
        ),
      ],
    );
  }
}

class _BackgroundGradientCircle extends StatelessWidget {
  final double size;

  const _BackgroundGradientCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 1.05,
      height: size * 1.05,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.brown.withValues(alpha: 0.8),
            Colors.brown.withValues(alpha: 0.2),
          ],
        ),
      ),
    );
  }
}

class _AnimatedRotatingBorder extends StatelessWidget {
  final double size;
  final AnimationController rotationController;
  final bool isDarkMode;

  const _AnimatedRotatingBorder({
    required this.size,
    required this.rotationController,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: rotationController.value * 2 * math.pi,
          child: Container(
            width: size * 1.1,
            height: size * 1.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode
                    ? Colors.white.withValues(alpha: 0.15)
                    : Colors.brown.withValues(alpha: 0.15),
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: _RotatingDots(size: size),
          ),
        );
      },
    );
  }
}

class _RotatingDots extends StatelessWidget {
  final double size;

  const _RotatingDots({required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(8, (index) {
        final angle = (index / 8) * 2 * math.pi;
        return Positioned(
          left: size * 0.55 + math.cos(angle) * size * 0.55,
          top: size * 0.55 + math.sin(angle) * size * 0.55,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final double size;
  final bool isDarkMode;
  final String imageUrl;

  const _ProfileImage({
    required this.size,
    required this.isDarkMode,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile-image',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.white,
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}