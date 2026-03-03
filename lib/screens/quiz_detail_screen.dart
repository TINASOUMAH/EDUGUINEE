import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/course_models.dart';
import 'quiz_play_screen.dart';

class QuizDetailScreen extends StatefulWidget {
  final CourseSubject subject;

  const QuizDetailScreen({super.key, required this.subject});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  // Enforcing Dark Blue + Yellow Theme
  final Color darkBlue = const Color(0xFF161C2C);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color bgGrey = const Color(0xFFF4F6F8);

  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            backgroundColor: darkBlue,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                   gradient: LinearGradient(
                    colors: [Color(0xFF161C2C), Color(0xFF232D42)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: darkBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: accentYellow, width: 2),
                          boxShadow: [
                            BoxShadow(color: accentYellow.withOpacity(0.3), blurRadius: 15)
                          ]
                        ),
                        child: Icon(widget.subject.icon, size: 48, color: accentYellow),
                      ).animate().scale(curve: Curves.easeOutBack),
                      const SizedBox(height: 12),
                      Text(
                        widget.subject.name,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  color: bgGrey,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Stats
                  Row(
                    children: [
                      Expanded(child: _buildStatCard("Score Moyen", "85%", Icons.insights_rounded)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildStatCard("Quiz Faits", "12", Icons.done_all_rounded)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  Text(
                    "Choisis ton mode",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildModeCard(
                    title: "Découverte",
                    subtitle: "Apprends à ton rythme",
                    icon: Icons.menu_book_rounded,
                    delay: 0,
                  ),
                  _buildModeCard(
                    title: "Entraînement",
                    subtitle: "Questions ciblées par chapitre",
                    icon: Icons.psychology_rounded,
                    delay: 100,
                  ),
                  _buildModeCard(
                    title: "Examen Blanc",
                    subtitle: "Simulation chronométrée",
                    icon: Icons.timer_outlined,
                    delay: 200,
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (_selectedMode != null)
                  BoxShadow(
                    color: darkBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _selectedMode == null 
                ? null 
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPlayScreen(
                          subject: widget.subject,
                          mode: _selectedMode!,
                        ),
                      ),
                    );
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedMode == null ? Colors.grey[300] : accentYellow,
                foregroundColor: darkBlue,
                disabledBackgroundColor: Colors.grey[200],
                disabledForegroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: _selectedMode == null ? 0 : 8,
                shadowColor: accentYellow.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lancer",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.play_circle_fill_rounded, 
                    size: 28,
                    color: _selectedMode == null ? Colors.grey[400] : darkBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: accentYellow, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: darkBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildModeCard({required String title, required String subtitle, required IconData icon, required int delay}) {
    final bool isSelected = _selectedMode == title;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? accentYellow : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected ? accentYellow.withOpacity(0.15) : Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
             setState(() {
               _selectedMode = title;
             });
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? accentYellow : darkBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon, 
                    color: isSelected ? darkBlue : accentYellow, 
                    size: 26
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle_rounded, color: accentYellow, size: 24)
                else
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black26, size: 14)
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1, end: 0);
  }

}
