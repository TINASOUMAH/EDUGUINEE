import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // Dark blue background like reference
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'EduGuinée', 
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Title
            Text(
              'Contactez-nous',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor, // Yellow/Gold
                letterSpacing: 1,
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            
            const SizedBox(height: 24),
            
            // Logo EduGuinée
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),


            
            const SizedBox(height: 24),
            
            // Description Text
            Text(
              'Chez EduGuinée, nous sommes toujours à l\'écoute.\nSi vous avez des questions ou des suggestions, n\'hésitez pas à nous contacter.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 48),
            
            // Contact Cards
            _buildContactCard(
              icon: Icons.email_rounded,
              color: const Color(0xFFFFC107), // Amber for Email
              title: 'Email',
              content: 'velionxtech@gmail.com',
              actionWidget: const SizedBox.shrink(), // No button for email, just text
              delay: 300,
            ),
            
            _buildContactCard(
              icon: Icons.chat_bubble_rounded, // WhatsApp style
              color: const Color(0xFF25D366), // WhatsApp Green
              title: 'WhatsApp',
              content: '', // No text content, just button
              actionWidget: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     // TODO: Implement WhatsApp launch
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ouverture de WhatsApp...")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text("Envoyer un message", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ),
              delay: 400,
            ),
            
            _buildContactCard(
              icon: Icons.facebook_rounded,
              color: const Color(0xFF1877F2), // Facebook Blue
              title: 'Facebook',
              content: '',
              actionWidget: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     // TODO: Implement Facebook launch
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ouverture de Facebook...")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text("Suivez-nous sur Facebook", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ),
              delay: 500,
            ),
            
            const SizedBox(height: 40),
            
            // Footer Quote
            Text(
              'Nous sommes là pour vous accompagner vers la réussite.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn(delay: 600.ms),

             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color color,
    required String title,
    required String content,
    required Widget actionWidget,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon Box
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.2), width: 1.5),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              // Title
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (content.isNotEmpty)
             Padding(
               padding: const EdgeInsets.only(left: 48), // Align with title
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(height: 8),
                   Text(
                     content,
                     style: GoogleFonts.inter(
                       fontSize: 14,
                       color: Colors.black54,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ],
               ),
             ),
          if (actionWidget is! SizedBox)
             Padding(
               padding: const EdgeInsets.only(top: 16),
               child: actionWidget,
             )
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.2);
  }
}
