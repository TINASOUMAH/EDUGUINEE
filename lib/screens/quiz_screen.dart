import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../data/course_data.dart';
import '../models/course_models.dart';
import 'quiz_detail_screen.dart';

class QuizScreen extends StatelessWidget {
  final String className;
  final String? option;
  const QuizScreen({super.key, required this.className, this.option});

  @override
  Widget build(BuildContext context) {
    final List<CourseSubject> subjects = CourseData.getSubjectsForClass(className, option: option);

    // Refined Theme Constants
    const Color darkBlue = Color(0xFF161C2C); 
    const Color accentYellow = Color(0xFFFFC107);
    const Color bgGrey = Color(0xFFF4F6F8); 

    return Scaffold(
      backgroundColor: bgGrey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 190.0,
            floating: false,
            pinned: true,
            backgroundColor: darkBlue,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Espace Quiz',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              background: Container(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF161C2C), Color(0xFF232D42)], // Subtle gradient for depth
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Teste tes connaissances",
                      style: GoogleFonts.poppins(
                        color: accentYellow,
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Choisis une matière pour commencer un quiz adapté à ton niveau $className.",
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8), 
                        fontSize: 13, 
                        height: 1.5
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPremiumChallengeCard(darkBlue, accentYellow),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Matières",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                          ]
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.grid_view_rounded, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(
                              "${subjects.length} cours",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subject = subjects[index];
                  return _buildPremiumSubjectCard(context, subject, index, darkBlue, accentYellow);
                },
                childCount: subjects.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumChallengeCard(Color darkBlue, Color accentYellow) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: darkBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decoration
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ton Progression",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Icon(Icons.trending_up_rounded, color: accentYellow, size: 20),
                ],
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Élève de $className\n",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2
                      ),
                    ),
                    TextSpan(
                      text: "Niveau Intermédiaire",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Progress Section
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: 0.35,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        color: accentYellow,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "35%",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: accentYellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuart);
  }

  Widget _buildPremiumSubjectCard(BuildContext context, CourseSubject subject, int index, Color darkBlue, Color accentYellow) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizDetailScreen(subject: subject)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             // Icon Circle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: darkBlue,
                shape: BoxShape.circle,
                boxShadow: [
                   BoxShadow(
                     color: darkBlue.withOpacity(0.2), 
                     blurRadius: 8, 
                     offset: const Offset(0, 4)
                   )
                ]
              ),
              child: Icon(subject.icon, color: accentYellow, size: 32),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              subject.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 6),
            // Subtitle
             Text(
              "0 Quiz complétés", // Placeholder text
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 12),
            // Accent dash
            Container(
              height: 4,
              width: 24,
              decoration: BoxDecoration(
                color: accentYellow,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1, end: 0);
  }
}
