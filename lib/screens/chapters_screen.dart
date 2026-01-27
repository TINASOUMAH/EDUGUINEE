import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import 'course_content_screen.dart';

class ChaptersScreen extends StatefulWidget {
  final CourseSubject subject;

  const ChaptersScreen({super.key, required this.subject});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  // Track expanded state for each chapter card
  final Map<String, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(widget.subject.name, style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: widget.subject.chapters.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final chapter = widget.subject.chapters[index];
          return _buildChapterCard(chapter, index);
        },
      ),
    );
  }

  Widget _buildChapterCard(CourseChapter chapter, int index) {
    final isExpanded = _expandedStates[chapter.id] ?? false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Card Content (Image + Info)
          InkWell(
            onTap: () => _toggleChapter(chapter.id),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chapter Image (Visual Representation)
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      color: widget.subject.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      // If we had real assets we would use: image: DecorationImage(image: AssetImage(chapter.imageAsset!), fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            _getIconForChapter(chapter),
                            size: 40,
                            color: widget.subject.color.withOpacity(0.5),
                          ),
                        ),
                        // Decorative corner
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: widget.subject.color.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor, // Requested Primary Color
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          chapter.description,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        
                        // "Voir le chapitre" Button
                        SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () => _toggleChapter(chapter.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade50, // "Bleu clair"
                              foregroundColor: Colors.blue.shade700,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              isExpanded ? 'Masquer' : 'Voir le chapitre',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Expanded Sub-chapters List
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    children: [
                      const Divider(height: 1),
                      if (chapter.subChapters.isEmpty)
                         Padding(
                           padding: const EdgeInsets.all(20),
                           child: Text("Bientôt disponible...", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
                         )
                      else
                        ...chapter.subChapters.map((sub) => _buildSubChapterItem(sub, chapter)).toList(),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
  }

  Widget _buildSubChapterItem(CourseSubChapter sub, CourseChapter chapter) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          sub.isCompleted ? Icons.check : Icons.play_arrow_rounded,
          color: sub.isCompleted ? Colors.green : AppTheme.secondaryColor,
          size: 20,
        ),
      ),
      title: Text(
        sub.title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: AppTheme.textMain,
          fontSize: 15,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey[400]),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContentScreen(
              subChapter: sub,
              subjectColor: widget.subject.color,
            ),
          ),
        );
      },
    );
  }

  void _toggleChapter(String chapterId) {
    setState(() {
      _expandedStates[chapterId] = !(_expandedStates[chapterId] ?? false);
    });
  }

  IconData _getIconForChapter(CourseChapter chapter) {
    // Helper to return a relevant icon since we don't have real images yet
    if (chapter.title.contains('Géométrie')) return Icons.architecture;
    if (chapter.title.contains('Algèbre') || chapter.title.contains('Equation')) return Icons.functions;
    if (chapter.title.contains('Chimie')) return Icons.science;
    if (chapter.title.contains('Mécanique')) return Icons.speed;
    return Icons.menu_book_rounded;
  }
}
