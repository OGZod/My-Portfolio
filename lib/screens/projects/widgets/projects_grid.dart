import 'package:flutter/material.dart';
import '../../../functions/helpers.dart';
import '../../../models/project_model.dart';
import 'project_card/project_card.dart';

class ProjectsGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  final ResponsiveLayoutConfig config;
  final List<Animation<double>> staggeredAnimations;

  const ProjectsGrid({
    super.key,
    required this.projects,
    required this.config,
    required this.staggeredAnimations,
  });

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return EmptyProjectsState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: config.gridCrossAxisCount,
        crossAxisSpacing: config.gridSpacing,
        mainAxisSpacing: config.gridSpacing,
        childAspectRatio: config.gridAspectRatio,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final animationIndex =
            index < staggeredAnimations.length
                ? index
                : staggeredAnimations.length - 1;

        return ProjectCard(
          project: projects[index],
          animation: staggeredAnimations[animationIndex],
          layoutType: config.layoutType,
        );
      },
    );
  }
}

class EmptyProjectsState extends StatelessWidget {
  const EmptyProjectsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
