enum CourseSectionType {
  text,
  image,
  formula,
  example,
  method,
  exercise, // Simple inline exercise or prompt
  tip, // Astuce/Memo
}

class CourseSection {
  final String id;
  final CourseSectionType type;
  final String? title;
  final String content; // Text content, or image path, or formula LaTeX/text
  final String? subContent; // Explanation for formula, or hint
  final bool isEssential; // "Points essentiels à retenir"

  const CourseSection({
    required this.id,
    required this.type,
    required this.content,
    this.title,
    this.subContent,
    this.isEssential = false,
  });
}

enum CompletionStatus {
  notStarted,
  inProgress,
  completed, // "Lu"
  toReview, // "À revoir"
}

class CourseChapter {
  final String id;
  final String title;
  final String description;
  final String? imageAsset; // Added for chapter visual
  final List<CourseSubChapter> subChapters;
  CompletionStatus status;

  CourseChapter({
    required this.id,
    required this.title,
    required this.description,
    this.imageAsset,
    required this.subChapters,
    this.status = CompletionStatus.notStarted,
  });
  
  // Helper to get total progress
  double get progress {
    if (subChapters.isEmpty) return 0.0;
    int completed = subChapters.where((s) => s.isCompleted).length;
    return completed / subChapters.length;
  }
}

class CourseSubChapter {
  final String id;
  final String title;
  final List<CourseSection> sections;
  bool isCompleted;

  CourseSubChapter({
    required this.id,
    required this.title,
    required this.sections,
    this.isCompleted = false,
  });
}

class CourseSubject {
  final String id;
  final String name;
  final String? description;
  final dynamic icon; // IconData
  final String? imageAsset; // Path for illustration
  final dynamic color; // Color
  final List<CourseChapter> chapters;

  const CourseSubject({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.imageAsset,
    required this.color,
    required this.chapters,
  });
}
