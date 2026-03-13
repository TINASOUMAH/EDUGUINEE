import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash_screen.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // INITIALISATION DOTENV
  await dotenv.load(fileName: ".env");
  
  // INITIALISATION SUPABASE (Remplacer avec vos propres clés)
  await Supabase.initialize(
    url: 'https://fqgxzabrdcivjplrcmvd.supabase.co',
    anonKey: 'sb_publishable_LAq3vUho2M3bTooDOHPwzA_lFNfyWhA',
  );

  runApp(const EduGuineeApp());
}

class EduGuineeApp extends StatelessWidget {
  const EduGuineeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDUGUINEE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: const SplashScreen(),
    );
  }
}
