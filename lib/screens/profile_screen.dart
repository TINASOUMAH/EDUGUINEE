import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import 'personal_info_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';
import 'class_selection_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Mon Profil',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Large Avatar
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFFACC15), // Yellow color from image
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            
            // Name and Email
            Text(
              'Élève',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF475569),
              ),
            ),
            Text(
              'eleve@eduguinee.com',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: const Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 48),
            
            // Profile Menu Items
            _buildProfileItem(
              icon: Icons.person_outline_rounded,
              title: 'Informations personnelles',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
                );
              },
            ),
            _buildProfileItem(
              icon: Icons.school_outlined,
              title: 'Ma Classe',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClassSelectionScreen()),
                );
              },
            ),
            _buildProfileItem(
              icon: Icons.settings_outlined,
              title: 'Paramètres',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            _buildProfileItem(
              icon: Icons.help_outline_rounded,
              title: 'Aide & Support',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Logout Item
            _buildProfileItem(
              icon: Icons.logout_rounded,
              title: 'Se déconnecter',
              isLogout: true,
              onTap: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final Color iconColor = isLogout ? const Color(0xFFEF4444) : const Color(0xFF1E293B);
    final Color bgColor = isLogout ? const Color(0xFFFEF2F2) : const Color(0xFFF1F5F9);
    final Color textColor = isLogout ? const Color(0xFFEF4444) : const Color(0xFF1E293B);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: textColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: isLogout ? const Color(0xFF94A3B8) : Colors.grey[400],
        ),
      ),
    );
  }
}
