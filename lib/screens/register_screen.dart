import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? _selectedClass;
  String? _selectedOption;

  final List<String> _classes = ['6ème année', '10ème année', 'Terminale'];
  final List<String> _options = ['TSS', 'TSM', 'TEM'];

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
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    'Créer un compte',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                  
                  Text(
                    'Rejoignez la communauté EduGuinée dès aujourd\'hui',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
                  
                  const SizedBox(height: 40),
                  
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'Prénom',
                                hint: 'Jean',
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: 'Nom',
                                hint: 'Camara',
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(delay: 200.ms),
                        
                        const SizedBox(height: 20),
                        
                        _buildTextField(
                          label: 'Numéro de téléphone',
                          hint: '620 00 00 00',
                          icon: Icons.phone_android_rounded,
                          keyboardType: TextInputType.phone,
                        ).animate().fadeIn(delay: 300.ms),
                        
                        const SizedBox(height: 20),
                        
                        _buildDropdownField(
                          label: 'Classe',
                          hint: 'Sélectionnez votre classe',
                          value: _selectedClass,
                          items: _classes,
                          onChanged: (val) {
                            setState(() {
                              _selectedClass = val;
                              if (val != 'Terminale') _selectedOption = null;
                            });
                          },
                          icon: Icons.school_outlined,
                        ).animate().fadeIn(delay: 400.ms),
                        
                        if (_selectedClass == 'Terminale') ...[
                          const SizedBox(height: 20),
                          _buildDropdownField(
                            label: 'Option',
                            hint: 'Sélectionnez votre option',
                            value: _selectedOption,
                            items: _options,
                            onChanged: (val) => setState(() => _selectedOption = val),
                            icon: Icons.biotech_outlined,
                          ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                        ],
                        
                        const SizedBox(height: 20),
                        
                        _buildTextField(
                          label: 'Mot de passe',
                          hint: '••••••••',
                          icon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onTogglePassword: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ).animate().fadeIn(delay: 500.ms),
                        
                        const SizedBox(height: 40),
                        
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    className: _selectedClass ?? '10ème année',
                                    option: _selectedOption,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor,
                            foregroundColor: AppTheme.primaryColor,
                            minimumSize: const Size(double.infinity, 56),
                            elevation: 8,
                            shadowColor: AppTheme.secondaryColor.withOpacity(0.3),
                          ),
                          child: const Text('Créer mon compte'),
                        ).animate().fadeIn(delay: 600.ms).scale(),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Social Register
                  Column(
                    children: [
                      Text(
                        'Ou s\'inscrire avec',
                        style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(Icons.g_mobiledata_rounded, Colors.white),
                          const SizedBox(width: 20),
                          _buildSocialButton(Icons.facebook_rounded, Colors.blueAccent),
                          const SizedBox(width: 20),
                          _buildSocialButton(Icons.apple_rounded, Colors.white),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms),
                  
                  const SizedBox(height: 32),
                  
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous avez déjà un compte ?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 900.ms),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.31)),
            prefixIcon: Icon(icon, color: Colors.white70),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: Colors.white70,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppTheme.secondaryColor, width: 1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Obligatoire';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          dropdownColor: const Color(0xFF1E293B), // Darker slate for menu
          style: const TextStyle(color: Colors.white, fontSize: 16),
          iconEnabledColor: AppTheme.secondaryColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            prefixIcon: Icon(icon, color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(color: AppTheme.secondaryColor),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item, 
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Text(
                item,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              );
            }).toList();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Obligatoire';
            }
            return null;
          },
        ),
      ],
    );
  }
}
