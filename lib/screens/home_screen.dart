import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import 'my_courses_screen.dart';
import 'ai_assistant_screen.dart';
import 'formulas_screen.dart';
import 'quiz_screen.dart';
import 'planning_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'contact_screen.dart';
import 'about_screen.dart';
import 'settings_screen.dart';
import 'welcome_screen.dart';
import 'exercise_screen.dart';
import 'calculator_screen.dart';
import 'past_papers_screen.dart';

class HomeScreen extends StatelessWidget {
  final String className;
  final String? option;

  const HomeScreen({
    super.key,
    required this.className,
    this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EduGuinée', style: GoogleFonts.poppins(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppTheme.primaryColor, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppTheme.primaryColor),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
            child: const CircleAvatar(
              backgroundColor: AppTheme.secondaryColor,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bon retour,',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Élève de $className',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (option != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Option $option',
                          style: GoogleFonts.inter(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation(AppTheme.secondaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Progression: 35%',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.2),

              const SizedBox(height: 32),

              Text(
                'Vos Outils',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              // Grid Features
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildFeatureCard(
                    context,
                    title: 'Mes Cours',
                    icon: Icons.menu_book_rounded,
                    color: const Color(0xFF4A90E2),
                    delay: 100,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyCoursesScreen(className: className, option: option)),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Formules / Méthodes',
                    icon: Icons.functions_rounded,
                    color: const Color(0xFFF5A623),
                    delay: 200,
                    onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => FormulasScreen(className: className, option: option))
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Quiz',
                    icon: Icons.school_rounded,
                    color: const Color(0xFF9013FE),
                    delay: 300,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(className: className, option: option))),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Mes Exercices',
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFF50E3C2),
                    delay: 400,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseScreen(className: className, option: option))),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Assistant IA',
                    icon: Icons.auto_awesome_rounded,
                    color: AppTheme.accentColor,
                    delay: 500,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AIAssistantScreen(className: className, option: option))),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Planning',
                    icon: Icons.calendar_month_rounded,
                    color: const Color(0xFF7ED321),
                    delay: 600,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlanningScreen())),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Anciens Sujets',
                    icon: Icons.history_edu_rounded,
                    color: const Color(0xFFD0021B),
                    delay: 700,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PastPapersScreen(className: className, option: option))),
                  ),
                  _buildFeatureCard(
                    context,
                    title: 'Super Calculatrice',
                    icon: Icons.calculate_rounded,
                    color: const Color(0xFFBD10E0),
                    delay: 800,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CalculatorScreen(className: className))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/menu_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Accueil'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('À propos'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: const Text('Contactez-nous'),
            onTap: () {
               Navigator.pop(context); // Close drawer
               Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Paramètres'),
            onTap: () {
               Navigator.pop(context); // Close drawer
               Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text('Se déconnecter', style: TextStyle(color: Colors.red)),
            onTap: () {
               Navigator.pop(context); // Close drawer
               showDialog(
                 context: context,
                 builder: (context) => AlertDialog(
                   title: Text('Se déconnecter', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                   content: Text('Voulez-vous vraiment vous déconnecter ?', style: GoogleFonts.inter()),
                   actions: [
                     TextButton(
                       onPressed: () => Navigator.pop(context),
                       child: const Text('Annuler'),
                     ),
                     TextButton(
                       onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                            (route) => false,
                          );
                       },
                       child: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
                     ),
                   ],
                 ),
               );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required int delay,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(24),
          child: Container(
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(24),
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Icon(
                      icon,
                      size: 52, 
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMain,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                 Container(
                  width: 20,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).scale(duration: 400.ms, curve: Curves.easeOutBack);
  }
}
