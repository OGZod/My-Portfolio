import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../functions/helpers.dart';
import '../../../../models/project_model.dart';

class ProjectCardHeader extends StatelessWidget {
  final ProjectModel project;
  final ResponsiveLayoutConfig config;

  const ProjectCardHeader({
    super.key,
    required this.project,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      project.title,
      style: AppTextStyles.headerSmall.copyWith(
        fontSize: config.cardTitleFontSize,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.displayLarge?.color,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ProjectCardDescription extends StatelessWidget {
  final ProjectModel project;
  final ResponsiveLayoutConfig config;

  const ProjectCardDescription({
    super.key,
    required this.project,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      project.description,
      style: AppTextStyles.body.copyWith(
        fontSize: config.cardDescriptionFontSize,
        height: 1.5,
        color: AppColors.textMuted,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class ProjectCardTechnologies extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardTechnologies({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          project.technologies.take(3).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                tech,
                style: AppTextStyles.body.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            );
          }).toList(),
    );
  }
}

class ProjectCardActions extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardActions({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (project.liveUrl != null)
          Expanded(
            child: ProjectActionButton(
              label: 'Live Demo',
              icon: Icons.launch,
              onTap: () => _launchUrl(project.liveUrl!),
              isPrimary: true,
            ),
          ),
        if (project.liveUrl != null && project.githubUrl != null)
          const SizedBox(width: 12),
        if (project.githubUrl != null)
          Expanded(
            child: ProjectActionButton(
              label: 'Code',
              icon: Icons.code,
              onTap: () => _launchUrl(project.githubUrl!),
              isPrimary: project.liveUrl == null,
            ),
          ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}

class ProjectActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const ProjectActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border:
              isPrimary
                  ? null
                  : Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCardImage extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardImage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    // Create a unique key for ScaffoldMessenger to avoid conflicts
    final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.8),
              AppColors.secondary.withValues(alpha: 0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            Image.network(
              project.imageUrl,
              fit: BoxFit.contain,
              height: 180,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    _getProjectIcon(),
                    size: 60,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  // Image is fully loaded, remove any existing SnackBar
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scaffoldKey.currentState?.removeCurrentSnackBar();
                  });
                  return child;
                }
                return Center(
                  child: Icon(
                    _getProjectIcon(),
                    size: 60,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                );
              },
            ),
            // Top row badges
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Company project badge (left side)
                  if (project.role?.isNotEmpty??false)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.business,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Company',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Right side badges
                  Row(
                    children: [
                      // Role badge
                      if (project.role != null && project.role!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            project.role!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        ProjectStatusBadge(status: project.status),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getProjectIcon() {
    if (project.categories.contains('Mobile')) {
      return Icons.phone_android;
    } else if (project.categories.contains('Web')) {
      return Icons.web;
    } else if (project.categories.contains('Desktop')) {
      return Icons.desktop_windows;
    } else if (project.categories.contains('Machine Learning')) {
      return Icons.psychology;
    } else if (project.categories.contains('UI/UX')) {
      return Icons.design_services;
    }
    return Icons.code;
  }
}

class ProjectStatusBadge extends StatelessWidget {
  final ProjectStatus status;

  const ProjectStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String label;

    switch (status) {
      case ProjectStatus.inProgress:
        backgroundColor = Colors.orange;
        label = 'In Progress';
        break;
      case ProjectStatus.completed:
        backgroundColor = Colors.green;
        label = 'Completed';
        break;
      case ProjectStatus.archived:
        backgroundColor = Colors.grey;
        label = 'Archived';
        break;
      case ProjectStatus.planning:
        backgroundColor = Colors.blue;
        label = 'Planning';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
