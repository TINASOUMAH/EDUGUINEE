import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_screen.dart';
import '../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    // Simulation du temps de chargement
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Icon animé
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondaryColor.withOpacity(0.6),
                    blurRadius: 40,
                    spreadRadius: 2,
                  )
                ]
              ),
              child: const Icon(
                Icons.school_rounded,
                size: 60,
                color: AppTheme.primaryColor,
              ),
            ).animate()
             .scale(duration: 800.ms, curve: Curves.easeOutBack)
             .then().shimmer(duration: 1500.ms, color: AppTheme.secondaryColor)
             .then().animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scaleXY(end: 1.1, duration: 1000.ms),
            
            const SizedBox(height: 30),

            // Texte Logo
            Column(
              children: [
                Text.rich(
                  const TextSpan(
                    children: [
                      TextSpan(text: 'Edu', style: TextStyle(color: Colors.white)),
                      TextSpan(text: 'Guinée', style: TextStyle(color: AppTheme.secondaryColor)),
                    ]
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3, end: 0),
                
                Text(
                  'L\'excellence à portée de main',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ),

            const SizedBox(height: 80),

            // Loading Indicator Stylisé
            SizedBox(
              width: 40,
              height: 40,
              child: const CircularProgressIndicator(
                color: AppTheme.secondaryColor,
                strokeWidth: 3,
              ),
            ).animate().fadeIn(delay: 1200.ms),
          ],
        ),
      ),
    );
  }
}
