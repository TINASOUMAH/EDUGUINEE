import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // Dark blue background
      appBar: AppBar(
        title: Text('EduGuinée', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // App Identity
            Text(
              'EduGuinée',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor, // Gold/Yellow
                letterSpacing: 1.2,
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            
            const SizedBox(height: 4),
            Text(
              'Version : 1.0.0',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            
            const SizedBox(height: 20),
            Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
            const SizedBox(height: 20),
            
            // Description Section
            Text(
              'À propos de l\'application',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 100.ms),
            
            const SizedBox(height: 16),
            Text(
              'EduGuinée est ton allié pour réussir durant tout ton parcours scolaire ! Conçue avec passion pour les élèves de Guinée (6ème, 10ème, Terminale), cette application te donne tous les outils pour apprendre efficacement, t\'entraîner, et viser l\'excellence. Où que tu sois, ta réussite commence ici.',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
              textAlign: TextAlign.justify, // Justified for cleaner block look like reference
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 32),
            
            // Features Section
            Text(
              'Fonctionnalités principales :',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ).animate().fadeIn(delay: 300.ms),
            
            const SizedBox(height: 16),
            
            _buildFeatureItem('Cours clairs et structurés par niveau'),
            _buildFeatureItem('Méthodes et formules expliquées'),
            _buildFeatureItem('Quiz interactifs pour s\'entraîner'),
            _buildFeatureItem('Planning de révision intelligent'),
            _buildFeatureItem('Assistant IA pour tes questions'),
            _buildFeatureItem('Interface simple et moderne adaptée aux jeunes'),
            
            const SizedBox(height: 40),
            
            // Quote Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.3)),
              ),
              child: Text(
                '« Le savoir est une arme. Prépare-toi à réussir avec EduGuinée ! »',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.secondaryColor,
                ),
              ),
            ).animate().fadeIn(delay: 600.ms).scale(),
            
            const SizedBox(height: 40),
            
            // Copyright
            Text(
              '© 2024 EduGuinée. Tous droits réservés.',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white30),
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 6, color: Colors.white70),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Colors.white.withOpacity(0.9),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }
}
