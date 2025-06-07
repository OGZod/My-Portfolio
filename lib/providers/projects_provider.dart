import 'package:flutter/foundation.dart';
import '../models/project_model.dart';
import '../screens/projects/service/projects_data_service.dart';

class ProjectsProvider with ChangeNotifier {
  final ProjectsDataService _dataService;
  
  ProjectsProvider({ProjectsDataService? dataService}) 
      : _dataService = dataService ?? LocalProjectsDataService();

  // State variables
  List<ProjectModel> _allProjects = [];
  List<ProjectModel> _filteredProjects = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  bool _isLoading = false;
  String? _error;

  // Getters
  List<ProjectModel> get allProjects => _allProjects;
  List<ProjectModel> get filteredProjects => _filteredProjects;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasProjects => _allProjects.isNotEmpty;

  // Initialize data
  Future<void> initialize() async {
    _setLoading(true);
    _setError(null);

    try {
      // Load categories and projects concurrently
      final futures = await Future.wait([
        _dataService.getCategories(),
        _dataService.getAllProjects(),
      ]);

      _categories = futures[0] as List<String>;
      _allProjects = futures[1] as List<ProjectModel>;
      _filterProjects();
      
    } catch (e) {
      _setError('Failed to load projects: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Change selected category
  void changeCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _filterProjects();
      notifyListeners();
    }
  }

  // Refresh data
  Future<void> refresh() async {
    // Clear cache if using local service
    if (_dataService is LocalProjectsDataService) {
      (_dataService).clearCache();
    }
    await initialize();
  }

  // Add new project (for future expansion)
  // Future<void> addProject(ProjectModel project) async {
  //   try {
  //     await _dataService.addProject(project);
  //     _allProjects.add(project);
  //     _filterProjects();
  //     notifyListeners();
  //   } catch (e) {
  //     _setError('Failed to add project: ${e.toString()}');
  //   }
  // }

  // Update project (for future expansion)
  // Future<void> updateProject(ProjectModel updatedProject) async {
  //   try {
  //     await _dataService.updateProject(updatedProject);
  //     final index = _allProjects.indexWhere((p) => p.title == updatedProject.title);
  //     if (index != -1) {
  //       _allProjects[index] = updatedProject;
  //       _filterProjects();
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     _setError('Failed to update project: ${e.toString()}');
  //   }
  // }

  // Search projects by title or description
  List<ProjectModel> searchProjects(String query) {
    if (query.isEmpty) return _filteredProjects;
    
    final lowercaseQuery = query.toLowerCase();
    return _filteredProjects.where((project) {
      return project.title.toLowerCase().contains(lowercaseQuery) ||
             project.description.toLowerCase().contains(lowercaseQuery) ||
             project.technologies.any((tech) => 
                 tech.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  // Get projects by status
  List<ProjectModel> getProjectsByStatus(ProjectStatus status) {
    return _allProjects.where((project) => project.status == status).toList();
  }

  // Get projects by technology
  List<ProjectModel> getProjectsByTechnology(String technology) {
    return _allProjects.where((project) => 
        project.technologies.contains(technology)).toList();
  }

  // Private methods
  void _filterProjects() {
    _filteredProjects = _dataService.filterProjects(_allProjects, _selectedCategory);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    if (error != null) {
      notifyListeners();
    }
  }

  // Get statistics
  Map<String, int> getProjectStatistics() {
    final stats = <String, int>{};
    
    // Count by status
    for (final project in _allProjects) {
      final status = project.status.name;
      stats[status] = (stats[status] ?? 0) + 1;
    }
    
    // Count by category
    for (final project in _allProjects) {
      for (final category in project.categories) {
        if (category != 'All') {
          stats[category] = (stats[category] ?? 0) + 1;
        }
      }
    }
    
    return stats;
  }
}