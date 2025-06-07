import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/projects_layout.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../functions/helpers.dart';
import '../../../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final LayoutType layoutType;
  final Animation<double> animation;

  const ProjectCard({super.key, required this.project, required this.layoutType, required this.animation});


  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(widget.animation),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..scale(_isHovered ? 1.02 : 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered
                      ? AppColors.primary.withOpacity(0.3)
                      : Theme.of(context).dividerColor.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? AppColors.primary.withOpacity(0.15)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: _isHovered ? 20 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProjectImage(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProjectHeader(),
                          const SizedBox(height: 12),
                          _buildProjectDescription(),
                          const Spacer(),
                          _buildTechnologies(),
                          const SizedBox(height: 16),
                          _buildProjectActions(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Container(
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
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              _getProjectIcon(),
              size: 60,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          if (widget.project.status == ProjectStatus.inProgress)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'In Progress',
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Text(
      widget.project.title,
      style: AppTextStyles.headerSmall.copyWith(
        fontSize: _getTitleFontSize(),
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.displayLarge?.color,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildProjectDescription() {
    return Text(
      widget.project.description,
      style: AppTextStyles.body.copyWith(
        fontSize: _getDescriptionFontSize(),
        height: 1.5,
        color: AppColors.textMuted,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widget.project.technologies.take(3).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
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

  Widget _buildProjectActions() {
    return Row(
      children: [
        if (widget.project.liveUrl != null)
          Expanded(
            child: _buildActionButton(
              label: 'Live Demo',
              icon: Icons.launch,
              onTap: () => _launchUrl(widget.project.liveUrl!),
              isPrimary: true,
            ),
          ),
        if (widget.project.liveUrl != null && widget.project.githubUrl != null)
          const SizedBox(width: 12),
        if (widget.project.githubUrl != null)
          Expanded(
            child: _buildActionButton(
              label: 'Code',
              icon: Icons.code,
              onTap: () => _launchUrl(widget.project.githubUrl!),
              isPrimary: widget.project.liveUrl == null,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isPrimary ? null : Border.all(
            color: AppColors.primary.withOpacity(0.5),
          ),
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

  IconData _getProjectIcon() {
    if (widget.project.categories.contains('Mobile')) {
      return Icons.phone_android;
    } else if (widget.project.categories.contains('Web')) {
      return Icons.web;
    } else if (widget.project.categories.contains('Desktop')) {
      return Icons.desktop_windows;
    } else if (widget.project.categories.contains('Machine Learning')) {
      return Icons.psychology;
    } else if (widget.project.categories.contains('UI/UX')) {
      return Icons.design_services;
    }
    return Icons.code;
  }

  void _launchUrl(String url) {
    // Implement URL launcher
    print('Launching: $url');
  }

  double _getTitleFontSize() {
    switch (widget.layoutType) {
      case LayoutType.mobile:
        return 18;
      case LayoutType.tablet:
        return 19;
      case LayoutType.desktop:
        return 20;
    }
  }

  double _getDescriptionFontSize() {
    switch (widget.layoutType) {
      case LayoutType.mobile:
        return 14;
      case LayoutType.tablet:
        return 15;
      case LayoutType.desktop:
        return 16;
    }
  }
}

class ProjectCardImage extends StatelessWidget {
  final ProjectModel project;

  const ProjectCardImage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary.withOpacity(0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              _getProjectIcon(),
              size: 60,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          if (project.status == ProjectStatus.inProgress)
            Positioned(
              top: 12,
              right: 12,
              child: ProjectStatusBadge(status: project.status),
            ),
        ],
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

  const ProjectStatusBadge({
    super.key,
    required this.status,
  });

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

  const ProjectCardTechnologies({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: project.technologies.take(3).map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
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

  const ProjectCardActions({
    super.key,
    required this.project,
  });

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
          border: isPrimary
              ? null
              : Border.all(color: AppColors.primary.withOpacity(0.5)),
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