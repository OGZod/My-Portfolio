import 'package:flutter/material.dart';
import 'package:my_portfolio_app/screens/projects/widgets/project_card/widgets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../functions/helpers.dart';
import '../../../../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final LayoutType layoutType;
  final Animation<double> animation;

  const ProjectCard({
    super.key,
    required this.project,
    required this.layoutType,
    required this.animation,
  });

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
            transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      _isHovered
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Theme.of(
                            context,
                          ).dividerColor.withValues(alpha: 0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        _isHovered
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : Colors.black.withValues(alpha: 0.05),
                    blurRadius: _isHovered ? 20 : 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProjectCardImage(project: widget.project),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProjectCardHeader(
                            project: widget.project,
                            config: ResponsiveLayoutConfig(widget.layoutType),
                          ),
                          const SizedBox(height: 12),
                          ProjectCardDescription(
                            project: widget.project,
                            config: ResponsiveLayoutConfig(widget.layoutType),
                          ),
                          const Spacer(),
                          ProjectCardTechnologies(project: widget.project),
                          const SizedBox(height: 16),
                          ProjectCardActions(project: widget.project),
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
}
