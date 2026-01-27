import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import '../data/course_data.dart';
import 'chapters_screen.dart';

class MyCoursesScreen extends StatelessWidget {
  final String className;
  
  const MyCoursesScreen({
    super.key, 
    required this.className
  });

  @override
  Widget build(BuildContext context) {
    // Liste simulée des matières desormais dans CourseData


    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Cours', style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: CourseData.subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final subject = CourseData.subjects[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (subject.color as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(subject.icon as IconData, color: subject.color as Color, size: 28),
              ),
              title: Text(
                subject.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMain,
                ),
              ),
              subtitle: Text(
                '${subject.chapters.length} Chapitres',
                style: GoogleFonts.inter(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChaptersScreen(subject: subject)),
                );
              },
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2);
        },
      ),
    );
  }
}
