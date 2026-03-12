import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_selection_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
          ),
          
          // Background decorations removed


          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  
                  // Illustration Logo
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack),




                  const SizedBox(height: 48),

                  // Title with Rich Text
                  Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(text: 'Bienvenue sur '),
                        TextSpan(text: 'EDUGUINEE', style: TextStyle(color: AppTheme.secondaryColor)),
                      ]
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32, // Adjusted size for single line fit
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 20),

                  // Subtitle
                  Text(
                    'Préparez-vous à réussir votre examen avec des ressources adaptées. Apprenez, progressez et réussissez.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13, // Reduced font size to help it fit on one line
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),

                  const Spacer(flex: 2),

                  // Action Buttons
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          foregroundColor: AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        child: const Text('Se connecter'),
                      ).animate().fadeIn(delay: 800.ms).slideY(begin: 1, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 1.5),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('S\'inscrire'),
                      ).animate().fadeIn(delay: 950.ms).slideY(begin: 1, end: 0),
                      
                      const SizedBox(height: 12),
                      
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(className: '6ème année'),
                            ),
                          );
                        },
                        child: Text(
                          'Découvrir sans compte',
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white30,
                          ),
                        ),
                      ).animate().fadeIn(delay: 1100.ms),
                    ],
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
