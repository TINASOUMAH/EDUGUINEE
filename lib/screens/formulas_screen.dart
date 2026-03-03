import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import '../data/course_data.dart';
import 'subject_formulas_screen.dart';

class FormulasScreen extends StatelessWidget {
  final String className;
  final String? option;
  const FormulasScreen({super.key, required this.className, this.option});

  @override
  Widget build(BuildContext context) {
    final subjects = CourseData.getSubjectsForClass(className, option: option);
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text('Formules & Méthodes', style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: subjects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final subject = subjects[index];
          // Simple heuristic for count (in real app would calculate from data)
          // For now we just mock "Recueil complet"
          
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
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textMain),
              ),
              subtitle: Text(
                'Voir les formules et fiches',
                style: GoogleFonts.inter(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectFormulasScreen(subject: subject)),
                );
              },
            ),
          ).animate().fadeIn(delay: (index * 100).ms).slideX();
        },
      ),
    );
  }
}
