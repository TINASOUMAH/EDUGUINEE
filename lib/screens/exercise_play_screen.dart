import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/course_models.dart';
import '../data/course_data.dart';

class ExercisePlayScreen extends StatefulWidget {
  final CourseSubject subject;
  final String exerciseTitle;
  final String exerciseSubtitle;

  const ExercisePlayScreen({
    super.key, 
    required this.subject, 
    required this.exerciseTitle,
    required this.exerciseSubtitle,
  });

  @override
  State<ExercisePlayScreen> createState() => _ExercisePlayScreenState();
}

class _ExercisePlayScreenState extends State<ExercisePlayScreen> {
  final Color darkBlue = const Color(0xFF161C2C);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color successGreen = const Color(0xFF4CAF50);
  final Color lightGrey = const Color(0xFFF8F9FA);

  bool _showCorrection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Énoncé de l'exercice",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: darkBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                   Container(
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.1),
                       borderRadius: BorderRadius.circular(15),
                     ),
                     child: Icon(widget.subject.icon as IconData, color: accentYellow, size: 30),
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           widget.subject.name,
                           style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                         ),
                         Text(
                           widget.exerciseTitle,
                           style: GoogleFonts.poppins(
                             color: Colors.white, 
                             fontSize: 18, 
                             fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Énoncé", Icons.description_rounded),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: Text(
                      _getMockEnonce(widget.exerciseTitle),
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0),
                  
                  const SizedBox(height: 32),
                  
                  if (_showCorrection) ...[
                    _buildSectionTitle("Correction", Icons.check_circle_rounded, color: successGreen),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: successGreen.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: successGreen.withOpacity(0.2)),
                      ),
                      child: Text(
                        _getMockCorrection(widget.exerciseTitle),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ).animate().fadeIn().scale(duration: 300.ms, curve: Curves.easeOutBack),
                  ] else ...[
                     Container(
                       padding: const EdgeInsets.all(20),
                       decoration: BoxDecoration(
                         color: accentYellow.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: Row(
                         children: [
                           Icon(Icons.info_outline_rounded, color: Colors.orange[800]),
                           const SizedBox(width: 12),
                           Expanded(
                             child: Text(
                               "Prends ton temps pour résoudre l'exercice avant de regarder la correction.",
                               style: GoogleFonts.inter(
                                 fontSize: 13, 
                                 color: Colors.orange[900], 
                                 fontWeight: FontWeight.w600
                               ),
                             ),
                           ),
                         ],
                       ),
                     ).animate().fadeIn(delay: 400.ms),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                setState(() => _showCorrection = !_showCorrection);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _showCorrection ? darkBlue : accentYellow,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
              child: Text(
                _showCorrection ? "Cacher la correction" : "Voir la correction",
                style: GoogleFonts.poppins(
                  color: _showCorrection ? Colors.white : darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, {Color color = const Color(0xFF161C2C)}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18, 
            fontWeight: FontWeight.bold, 
            color: color
          ),
        ),
      ],
    );
  }

  String _getMockEnonce(String title) {
    if (title.contains('pH')) {
      return "On dispose de trois produits ménagers : \n- Jus de citron (A)\n- Eau de Javel (B)\n- Vinaigre (C)\n\nLes mesures de pH ont donné : pH(A)=2,4 ; pH(B)=11,5 ; pH(C)=3,0.\n\nQuestions :\n1. Classer ces produits du plus acide au moins acide.\n2. Lequel de ces produits est basique ?";
    }
    if (title.contains('Pythagore')) {
      return "Soit un triangle ABC rectangle en B tel que :\nAB = 3 cm et BC = 4 cm.\n\nCalculer la longueur du segment [AC]. Justifiez votre réponse en précisant le théorème utilisé.";
    }
    if (title.contains('Thalès')) {
      return "Dans un triangle ABC, les points D et E sont respectivement sur [AB] et [AC]. Les droites (DE) et (BC) sont parallèles. \nOn donne : AD=2cm, AB=5cm et DE=3cm.\n\nQuestion : Calculer la longueur BC.";
    }
    if (title.contains('Identités')) {
      return "Développer et réduire les expressions suivantes :\n1. A = (x + 3)²\n2. B = (2x - 5)²\n3. C = (x + 4)(x - 4)";
    }
    if (title.contains('Trigonométrie')) {
      return "Dans un triangle RST rectangle en S, on donne RS = 5 cm et l'angle SRT = 30°.\n\nQuestion : Calculer la longueur de l'hypoténuse RT. (On donne cos 30° ≈ 0,866)";
    }
    if (title.contains('Poids')) {
      return "Un objet a une masse m = 50 kg sur la Terre (g = 9,8 N/kg).\n\nQuestions :\n1. Calculez le poids P de cet objet sur Terre.\n2. Si on transporte cet objet sur la Lune (g = 1,6 N/kg), quelle sera sa masse ?";
    }
    if (title.contains('Ohm')) {
      return "Un conducteur ohmique de résistance R = 100 Ω est traversé par un courant d'intensité I = 0,2 A.\n\nQuestion : Calculez la tension U aux bornes de ce conducteur.";
    }
    if (title.contains('Alcanes')) {
      return "1. Donnez la formule générale des alcanes.\n2. Déterminez la formule brute de l'alcane possédant 4 atomes de carbone (Butane).\n3. Écrivez sa formule semi-développée.";
    }
    if (title.contains('Dissertation')) {
      return "Sujet : 'L'éducation est le moteur du développement d'une nation.'\n\nConsigne : Analysez cette affirmation en montrant d'abord comment l'éducation profite à l'individu, puis comment elle transforme la société.";
    }
    if (title.contains('Indépendance')) {
      return "1. À quelle date la République de Guinée a-t-elle proclamé son indépendance ?\n2. Qui était le leader du PDG-RDA à cette époque ?\n3. Quel pays a voté 'NON' au référendum de septembre 1958 ?";
    }
    if (title.contains('Bauxite')) {
      return "1. Pourquoi appelle-t-on la Guinée 'le scandale géologique' ?\n2. Citez deux grandes régions minières de bauxite en Guinée.\n3. Quel est l'impact de cette ressource sur l'économie nationale ?";
    }
    return "Consigne de l'exercice : \nLisez attentivement l'énoncé et répondez aux questions en détaillant vos calculs ou votre raisonnement.\n\nTitre : $title\n\nQuestion : Expliquez les concepts clés liés à ce sujet.";
  }

  String _getMockCorrection(String title) {
    if (title.contains('pH')) {
      return "1. Jus de citron (2,4) > Vinaigre (3,0) > Eau de Javel (11,5).\n\n2. Le produit basique est l'Eau de Javel (pH > 7).";
    }
    if (title.contains('Pythagore')) {
      return "D'après Pythagore : AC² = AB² + BC² = 3² + 4² = 9 + 16 = 25.\nAC = √25 = 5 cm.";
    }
    if (title.contains('Thalès')) {
      return "D'après Thalès : AD/AB = DE/BC => 2/5 = 3/BC.\nBC = (5 × 3) / 2 = 7,5 cm.";
    }
    if (title.contains('Identités')) {
      return "1. (x + 3)² = x² + 6x + 9\n2. (2x - 5)² = 4x² - 20x + 25\n3. (x + 4)(x - 4) = x² - 16";
    }
    if (title.contains('Trigonométrie')) {
      return "Dans RST rectangle en S, cos(SRT) = RS/RT => cos(30°) = 5/RT.\nRT = 5 / cos(30°) = 5 / 0,866 ≈ 5,77 cm.";
    }
    if (title.contains('Poids')) {
      return "1. P = m × g = 50 × 9,8 = 490 N.\n2. La masse est invariante ! m = 50 kg sur la Lune également.";
    }
    if (title.contains('Ohm')) {
      return "U = R × I = 100 × 0,2 = 20 V.";
    }
    if (title.contains('Alcanes')) {
      return "1. CnH2n+2\n2. C4H10 (Butane)\n3. CH3-CH2-CH2-CH3";
    }
    if (title.contains('Dissertation')) {
      return "Plan suggéré :\nI. Développement personnel (esprit critique, métier).\nII. Progrès social (économie, santé, démocratie).";
    }
    if (title.contains('Indépendance')) {
      return "1. 2 octobre 1958.\n2. Ahmed Sékou Touré.\n3. La Guinée (seul pays d'Afrique française à voter NON).";
    }
    if (title.contains('Bauxite')) {
      return "1. À cause de l'immensité de ses réserves minières.\n2. Boké et Fria.\n3. Elle représente la majorité des recettes d'exportation.";
    }
    return "Correction : Les points clés à aborder étaient la définition des termes, l'application des formules vues en cours et la synthèse des arguments historiques ou littéraires.";
  }
}
