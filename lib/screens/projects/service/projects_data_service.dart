
import '../../../models/project_model.dart';

abstract class ProjectsDataService {
  Future<List<ProjectModel>> getAllProjects();
  Future<List<String>> getCategories();
  List<ProjectModel> filterProjects(List<ProjectModel> projects, String category);
}

class LocalProjectsDataService implements ProjectsDataService {
  static final LocalProjectsDataService _instance = LocalProjectsDataService._internal();
  factory LocalProjectsDataService() => _instance;
  LocalProjectsDataService._internal();

  // Cache for projects data
  List<ProjectModel>? _cachedProjects;
  List<String>? _cachedCategories;

  @override
  Future<List<ProjectModel>> getAllProjects() async {
    if (_cachedProjects != null) {
      return _cachedProjects!;
    }

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    _cachedProjects = _getLocalProjects();
    return _cachedProjects!;
  }

  @override
  Future<List<String>> getCategories() async {
    if (_cachedCategories != null) {
      return _cachedCategories!;
    }

    _cachedCategories = [
      'All',
      'Mobile',
      'Web',
      'Desktop',
      'Machine Learning',
      'UI/UX'
    ];
    
    return _cachedCategories!;
  }

  @override
  List<ProjectModel> filterProjects(List<ProjectModel> projects, String category) {
    if (category == 'All') {
      return projects;
    }
    return projects.where((project) => project.categories.contains(category)).toList();
  }

  List<ProjectModel> _getLocalProjects() {
    return [
      ProjectModel(
        title: 'E-Commerce Flutter App',
        description: 'A complete e-commerce solution with payment integration, inventory management, and real-time analytics.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Firebase', 'Stripe API', 'Node.js'],
        imageUrl: 'assets/images/project1.png',
        githubUrl: 'https://github.com/yourusername/ecommerce-app',
        liveUrl: 'https://play.google.com/store/apps/details?id=com.yourapp',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'AI-Powered Learning Platform',
        description: 'Machine learning platform that personalizes educational content based on student performance and learning patterns.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['Next.js', 'Python', 'TensorFlow', 'PostgreSQL'],
        imageUrl: 'assets/images/project2.png',
        githubUrl: 'https://github.com/yourusername/ai-learning',
        liveUrl: 'https://ai-learning-platform.vercel.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'University Management System',
        description: 'Comprehensive desktop application for managing student records, course scheduling, and academic workflows.',
        categories: ['Desktop', 'All'],
        technologies: ['JavaFX', 'Spring Boot', 'MySQL', 'JasperReports'],
        imageUrl: 'assets/images/project3.png',
        githubUrl: 'https://github.com/yourusername/university-system',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'FinTech Mobile Wallet',
        description: 'Secure mobile wallet application with biometric authentication, QR payments, and transaction history.',
        categories: ['Mobile', 'All'],
        technologies: ['Flutter', 'Dart', 'Firebase', 'Biometric Auth'],
        imageUrl: 'assets/images/project4.png',
        githubUrl: 'https://github.com/yourusername/mobile-wallet',
        status: ProjectStatus.inProgress,
      ),
      ProjectModel(
        title: 'Healthcare Analytics Dashboard',
        description: 'Real-time analytics dashboard for healthcare providers with patient insights and predictive modeling.',
        categories: ['Web', 'Machine Learning', 'All'],
        technologies: ['React', 'Python', 'D3.js', 'FastAPI'],
        imageUrl: 'assets/images/project5.png',
        githubUrl: 'https://github.com/yourusername/healthcare-analytics',
        liveUrl: 'https://healthcare-dashboard.netlify.app',
        status: ProjectStatus.completed,
      ),
      ProjectModel(
        title: 'Design System & Component Library',
        description: 'Comprehensive design system with reusable components, tokens, and guidelines for consistent UI/UX.',
        categories: ['UI/UX', 'Web', 'All'],
        technologies: ['Figma', 'Storybook', 'React', 'TypeScript'],
        imageUrl: 'assets/images/project6.png',
        githubUrl: 'https://github.com/yourusername/design-system',
        liveUrl: 'https://design-system-storybook.netlify.app',
        status: ProjectStatus.completed,
      ),
    ];
  }

  // Method to add new project (for future expansion)
  Future<void> addProject(ProjectModel project) async {
    _cachedProjects?.add(project);
  }

  // Method to update project (for future expansion)
  Future<void> updateProject(ProjectModel updatedProject) async {
    if (_cachedProjects != null) {
      final index = _cachedProjects!.indexWhere((p) => p.title == updatedProject.title);
      if (index != -1) {
        _cachedProjects![index] = updatedProject;
      }
    }
  }

  // Method to clear cache (useful for testing or forced refresh)
  void clearCache() {
    _cachedProjects = null;
    _cachedCategories = null;
  }
}