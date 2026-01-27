import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planning de Révision', style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDaySection("Aujourd'hui", [
            _buildScheduleItem("08:00 - 10:00", "Mathématiques", "Algèbre linéaire", Colors.blue),
            _buildScheduleItem("14:00 - 16:00", "Physique", "Mécanique du point", Colors.orange),
          ]),
          const SizedBox(height: 24),
          _buildDaySection("Demain", [
            _buildScheduleItem("09:00 - 11:00", "Chimie", "Réactions RedOx", Colors.purple),
            _buildScheduleItem("16:00 - 18:00", "Anglais", "Grammar revision", Colors.teal),
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text("Ajouter", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDaySection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildScheduleItem(String time, String subject, String topic, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(subject, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              Text(topic, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(Icons.check, size: 16, color: color),
          )
        ],
      ),
    );
  }
}
