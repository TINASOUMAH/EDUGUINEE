import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import '../data/course_data.dart';
import 'chapters_screen.dart';

class MyCoursesScreen extends StatelessWidget {
  final String className;
  final String? option;
  
  const MyCoursesScreen({
    super.key, 
    required this.className,
    this.option,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = CourseData.getSubjectsForClass(className, option: option);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.95),
      appBar: AppBar(
        title: Text(
          'Cours de $className${option != null ? ' ($option)' : ''}', 
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Decoration
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.secondaryColor.withOpacity(0),
                  AppTheme.secondaryColor,
                  AppTheme.secondaryColor.withOpacity(0),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return _buildGuiSchoolCard(context, subjects[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuiSchoolCard(BuildContext context, CourseSubject subject, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark background for the card
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChaptersScreen(subject: subject)),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              // Left Section - Yellow with Icon/Illustration
              Container(
                width: 110,
                decoration: const BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      subject.icon as IconData,
                      color: AppTheme.primaryColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
              
              // Middle Section - Text Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subject.description ?? '${subject.chapters.length} Chapitres disponibles',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Right Section - Arrow Tab
              Container(
                width: 30,
                decoration: const BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, end: 0);
  }
}
