
class ProjectModel {
  final String title;
  final String description;
  final List<String> categories;
  final List<String> technologies;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final ProjectStatus status;

  ProjectModel({
    required this.title,
    required this.description,
    required this.categories,
    required this.technologies,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    required this.status,
  });

  // Factory constructor for JSON deserialization
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] as String,
      description: json['description'] as String,
      categories: List<String>.from(json['categories'] as List),
      technologies: List<String>.from(json['technologies'] as List),
      imageUrl: json['imageUrl'] as String,
      githubUrl: json['githubUrl'] as String?,
      liveUrl: json['liveUrl'] as String?,
      status: ProjectStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProjectStatus.completed,
      ),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categories': categories,
      'technologies': technologies,
      'imageUrl': imageUrl,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'status': status.name,
    };
  }

  // CopyWith method for immutable updates
  ProjectModel copyWith({
    String? title,
    String? description,
    List<String>? categories,
    List<String>? technologies,
    String? imageUrl,
    String? githubUrl,
    String? liveUrl,
    ProjectStatus? status,
  }) {
    return ProjectModel(
      title: title ?? this.title,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      technologies: technologies ?? this.technologies,
      imageUrl: imageUrl ?? this.imageUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.githubUrl == githubUrl &&
        other.liveUrl == liveUrl &&
        other.status == status;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        githubUrl.hashCode ^
        liveUrl.hashCode ^
        status.hashCode;
  }
}

enum ProjectStatus { 
  completed, 
  inProgress, 
  archived, 
  planning 
}