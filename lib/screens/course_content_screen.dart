import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';

class CourseContentScreen extends StatelessWidget {
  final CourseSubChapter subChapter;
  final Color subjectColor;

  const CourseContentScreen({
    super.key,
    required this.subChapter,
    required this.subjectColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for better readability
      appBar: AppBar(
        title: Text(
          subChapter.title,
          style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(subChapter.isCompleted ? Icons.check_circle : Icons.check_circle_outline, 
              color: subChapter.isCompleted ? Colors.green : Colors.grey),
            onPressed: () {
              // TODO: Mark as complete logic
            },
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: subChapter.sections.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final section = subChapter.sections[index];
          return _buildSection(context, section, index);
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, CourseSection section, int index) {
    // Animation wrapper
    final widget = _getSectionWidget(context, section);
    return widget.animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
  }

  Widget _getSectionWidget(BuildContext context, CourseSection section) {
    switch (section.type) {
      case CourseSectionType.text:
        return _buildTextSection(section);
      case CourseSectionType.formula:
        return _buildFormulaSection(context, section);
      case CourseSectionType.example:
        return _buildExampleSection(section);
      case CourseSectionType.method:
        return _buildMethodSection(context, section);
      case CourseSectionType.tip:
        return _buildTipSection(section);
      case CourseSectionType.exercise:
        return _buildExerciseSection(context, section);
      default:
        return Text('Unsupported type: ${section.type}');
    }
  }

  Widget _buildTextSection(CourseSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
               section.title!,
               style: GoogleFonts.poppins(
                 fontSize: 18,
                 fontWeight: FontWeight.w600,
                 color: AppTheme.textMain,
               ),
            ),
          ),
        Text(
          section.content,
          style: GoogleFonts.inter(fontSize: 16, height: 1.6, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildFormulaSection(BuildContext context, CourseSection section) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: subjectColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: subjectColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: subjectColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          if (section.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Icon(Icons.functions, color: subjectColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    section.title!.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: subjectColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              section.content,
              style: GoogleFonts.sourceCodePro(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
             textAlign: TextAlign.center,
            ),
          ),
          if (section.subContent != null)
             Padding(
               padding: const EdgeInsets.only(top: 12.0),
               child: Text(
                 section.subContent!,
                 style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700], fontStyle: FontStyle.italic),
                 textAlign: TextAlign.center,
               ),
             ),
        ],
      ),
    );
  }

  Widget _buildExampleSection(CourseSection section) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50], // Distinct neutral color
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: Colors.blueGrey, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 18, color: Colors.blueGrey[700]),
              const SizedBox(width: 8),
              Text(
                section.title ?? 'Exemple',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.blueGrey[800]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            section.content,
             style: GoogleFonts.inter(fontSize: 15, color: Colors.blueGrey[900]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTipSection(CourseSection section) {
      return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
           const SizedBox(width: 12),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 if (section.title != null)
                   Text(section.title!, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.amber[900])),
                   Text(section.content, style: GoogleFonts.inter(color: Colors.black87)),
               ],
             ),
           )
         ],
      ),
    );
  }

  Widget _buildMethodSection(BuildContext context, CourseSection section) {
     return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [subjectColor.withOpacity(0.05), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: subjectColor.withOpacity(0.3)),
      ),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: subjectColor, shape: BoxShape.circle),
                  child: const Icon(Icons.settings, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                 Text(
                section.title ?? 'Méthode',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textMain),
              ),
              ],
            ),
             const SizedBox(height: 12),
             Text(
                section.content,
                style: GoogleFonts.inter(fontSize: 15, height: 1.5),
             ),
         ],
      ),
    );
  }
  
    Widget _buildExerciseSection(BuildContext context, CourseSection section) {
     return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
        border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.5)),
      ),
      child: Column(
         children: [
            Icon(Icons.sports_esports, color: AppTheme.secondaryColor, size: 32),
             const SizedBox(height: 8),
             Text(
               section.title ?? 'À vous de jouer !',
               style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.secondaryColor),
             ),
               const SizedBox(height: 12),
             Text(
                section.content,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 15),
             ),
             if (section.subContent != null) ...[
                 const Divider(height: 24),
                  Text(
                    'Solution: ${section.subContent}',
                     style: GoogleFonts.inter(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
             ]
         ],
      ),
    );
  }
}
