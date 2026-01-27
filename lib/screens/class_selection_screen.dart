import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../widgets/selection_card.dart';
import 'home_screen.dart';

class ClassSelectionScreen extends StatefulWidget {
  const ClassSelectionScreen({super.key});

  @override
  State<ClassSelectionScreen> createState() => _ClassSelectionScreenState();
}

class _ClassSelectionScreenState extends State<ClassSelectionScreen> {
  void _handleSelection(BuildContext context, String className, {String? option}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          className: className,
          option: option,
        ),
      ),
    );
  }

  void _showTerminalOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Choisissez votre option',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sélectionnez votre filière pour la Terminale',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            SelectionCard(
              title: 'Sciences Sociales (TSS)',
              subtitle: 'Histoire, Géographie, Philo...',
              icon: Icons.people_outline_rounded,
              color: Colors.orange,
              onTap: () {
                Navigator.pop(context);
                _handleSelection(context, 'Terminale', option: 'TSS');
              },
            ),
            SelectionCard(
              title: 'Sciences Mathématiques (TSM)',
              subtitle: 'Maths, Physique, Info...',
              icon: Icons.functions_rounded,
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
                _handleSelection(context, 'Terminale', option: 'TSM');
              },
            ),
            SelectionCard(
              title: 'Sciences Expérimentales (TEM)',
              subtitle: 'Biologie, Chimie, Physique...',
              icon: Icons.science_rounded,
              color: Colors.green,
              onTap: () {
                Navigator.pop(context);
                _handleSelection(context, 'Terminale', option: 'TEM');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          'Étape 1/2',
                          style: GoogleFonts.inter(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  Text(
                    'Votre niveau ?',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Sélectionnez votre classe actuelle pour personnaliser votre expérience.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),

                  const SizedBox(height: 48),

                  // Cards List
                  Column(
                    children: [
                      SelectionCard(
                        title: '6ème Année',
                        subtitle: 'Début du collège',
                        icon: Icons.backpack_outlined,
                        color: Colors.teal,
                        onTap: () => _handleSelection(context, '6ème Année'),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                      SelectionCard(
                        title: '10ème Année (Brevet)',
                        subtitle: 'Préparation au BEPC',
                        icon: Icons.menu_book_rounded,
                        color: AppTheme.secondaryColor,
                        onTap: () => _handleSelection(context, '10ème Année'),
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                      SelectionCard(
                        title: 'Terminale (Bac)',
                        subtitle: 'Examen final du lycée',
                        icon: Icons.school_rounded,
                        color: AppTheme.accentColor,
                        onTap: () => _showTerminalOptions(context),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
