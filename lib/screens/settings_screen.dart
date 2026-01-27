import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

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
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader("Général"),
          _buildSwitchTile(
            title: "Notifications",
            subtitle: "Recevoir des rappels de révision",
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            icon: Icons.notifications_active_rounded,
            color: Colors.blue,
          ),
          _buildSwitchTile(
            title: "Sons",
            subtitle: "Effets sonores dans l'application",
            value: _soundEnabled,
            onChanged: (val) => setState(() => _soundEnabled = val),
            icon: Icons.volume_up_rounded,
            color: Colors.purple,
          ),
          _buildSwitchTile(
            title: "Mode Sombre",
            subtitle: "Économiser la batterie et reposer les yeux",
            value: _darkMode,
            onChanged: (val) {
               setState(() => _darkMode = val);
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Le mode sombre sera disponible bientôt !")));
            },
            icon: Icons.dark_mode_rounded,
            color: Colors.indigo,
          ),

          const SizedBox(height: 24),
          _buildSectionHeader("Compte"),
           _buildActionTile(
            title: "Modifier le profil",
            icon: Icons.person_rounded,
            color: Colors.teal,
            onTap: () {
               // Navigation to Profile (already handled in Home, but good here too)
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Accédez aux paramètres via l'icône de profil")));
            },
          ),
          _buildActionTile(
            title: "Langue",
            icon: Icons.language_rounded,
            color: Colors.orange,
            onTap: () {},
          ),

           const SizedBox(height: 24),
          _buildSectionHeader("Support"),
          _buildActionTile(
            title: "Politique de confidentialité",
            icon: Icons.privacy_tip_rounded,
            color: Colors.grey,
            onTap: () {},
          ),
          _buildActionTile(
            title: "Conditions d'utilisation",
            icon: Icons.description_rounded,
            color: Colors.grey,
            onTap: () {},
          ),
          
          const SizedBox(height: 40),
          Center(
            child: Text(
              "Version 1.0.0",
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
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
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
        contentPadding: const EdgeInsets.all(12),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
       margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
         leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
      ),
    );
  }
}
