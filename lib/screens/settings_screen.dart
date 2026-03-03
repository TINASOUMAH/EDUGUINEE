import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import 'personal_info_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text('Paramètres', style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          const SizedBox(height: 10),
          _buildSectionHeader("Général"),
          _buildSwitchTile(
            title: "Notifications",
            subtitle: "Recevoir des rappels de révision",
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            icon: Icons.notifications_rounded,
            color: const Color(0xFF3B82F6), // Blue
            bgColor: const Color(0xFFEFF6FF),
          ),
          _buildSwitchTile(
            title: "Sons",
            subtitle: "Effets sonores dans l'application",
            value: _soundEnabled,
            onChanged: (val) => setState(() => _soundEnabled = val),
            icon: Icons.volume_up_rounded,
            color: const Color(0xFFA855F7), // Purple
            bgColor: const Color(0xFFF5F3FF),
          ),
          _buildSwitchTile(
            title: "Mode Sombre",
            subtitle: "Économiser la batterie et reposer les yeux",
            value: _darkMode,
            onChanged: (val) {
               setState(() => _darkMode = val);
            },
            icon: Icons.dark_mode_rounded,
            color: const Color(0xFF4338CA), // Indigo
            bgColor: const Color(0xFFEEF2FF),
          ),

          const SizedBox(height: 32),
          _buildSectionHeader("Compte"),
          _buildActionTile(
            title: "Modifier le profil",
            icon: Icons.person_rounded,
            color: const Color(0xFF0D9488), // Teal
            bgColor: const Color(0xFFF0FDFA),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
              );
            },
          ),
          _buildActionTile(
            title: "Langue",
            icon: Icons.language_rounded,
            color: const Color(0xFFD97706), // Orange
            bgColor: const Color(0xFFFFFBEB),
            onTap: () {},
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF1E293B),
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: const Color(0xFF1E293B),
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey[300],
            inactiveThumbColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: onTap,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF1E293B),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
