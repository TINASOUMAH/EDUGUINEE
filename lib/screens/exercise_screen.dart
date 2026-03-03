import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/course_models.dart';
import '../data/course_data.dart';
import 'exercise_play_screen.dart';

class ExerciseScreen extends StatefulWidget {
  final String className;
  final String? option;
  const ExerciseScreen({super.key, required this.className, this.option});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final Color darkBlue = const Color(0xFF161C2C);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color bgGrey = const Color(0xFFF4F6F8);
  
  @override
  Widget build(BuildContext context) {
    final List<CourseSubject> subjects = CourseData.getSubjectsForClass(widget.className, option: widget.option);

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Mes Exercices",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F7FA), // Cleaner professional background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  children: [
                    Text(
                      "Entraînement quotidien",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Choisis une matière pour commencer à t'exercer et préparer ton examen.",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Subject List
                    ...subjects.asMap().entries.map((entry) {
                      return _buildSubjectListItem(entry.value, entry.key);
                    }).toList(),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectListItem(CourseSubject subject, int index) {
    final Color subjectColor = subject.color as Color;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: accentYellow,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SubjectExerciseListScreen(subject: subject),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon styling
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(subject.icon as IconData, size: 32, color: darkBlue),
                        const SizedBox(height: 4),
                        Text(
                          "EXO",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subject.name,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: darkBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Nouveau",
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getDescription(subject.name),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: darkBlue.withOpacity(0.8),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1, end: 0);
  }

  String _getDescription(String subject) {
    if (subject.contains('Math')) return "Maîtrise les théorèmes et les calculs complexes.";
    if (subject.contains('Français')) return "Deviens imbattable en grammaire et conjugaison.";
    if (subject.contains('Chimie')) return "Tout sur le pH et les réactions chimiques.";
    return "Des exercices ciblés pour réussir ton examen avec brio.";
  }
}

class SubjectExerciseListScreen extends StatefulWidget {
  final CourseSubject subject;
  const SubjectExerciseListScreen({super.key, required this.subject});

  @override
  State<SubjectExerciseListScreen> createState() => _SubjectExerciseListScreenState();
}

class _SubjectExerciseListScreenState extends State<SubjectExerciseListScreen> {
  String _selectedCategory = "Toutes catégories";

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = const Color(0xFF161C2C);
    final Color accentYellow = const Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "EduGuinée Exercises",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Premium Yellow Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 35),
            decoration: BoxDecoration(
              color: darkBlue, // Background behind the rounded yellow part
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: accentYellow,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: darkBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "TERMINÉ : 45%",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                          ),
                        ),
                      ),
                      Icon(widget.subject.icon as IconData, color: darkBlue, size: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.subject.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  Text(
                    "S'entraîner pour réussir l'examen",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: darkBlue.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // Filters Section (Horizontal)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip("Tous", true),
                        const SizedBox(width: 12),
                        _buildFilterChip("Favoris", false),
                        const SizedBox(width: 12),
                        _buildFilterChip("Résolus", false),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  Text(
                    "Catégories",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, 
                      fontSize: 18,
                      color: darkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Category Selection
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip("Toutes catégories"),
                        const SizedBox(width: 12),
                        ..._getDynamicCategories(widget.subject.name).map((cat) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _buildCategoryChip(cat),
                        )),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  // Exercise Count info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Liste des exercices",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, 
                          fontSize: 18,
                          color: darkBlue,
                        ),
                      ),
                      Text(
                        "${_getFilteredExerciseCards(context, widget.subject).length} exercices",
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Exercise Cards
                  ..._getFilteredExerciseCards(context, widget.subject),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getDynamicCategories(String subjectName) {
    if (subjectName.contains('Math')) return ["Algèbre", "Géométrie", "Arithmétique"];
    if (subjectName.contains('Chimie')) return ["Atomes", "pH", "Alcanes"];
    if (subjectName.contains('Français')) return ["Grammaire", "Conjugaison", "Dissertation"];
    if (subjectName.contains('Physique')) return ["Optique", "Électricité", "Mécanique"];
    if (subjectName.contains('Hist')) return ["Histoire de Guinée", "Résistance"];
    if (subjectName.contains('Géo')) return ["Géographie de Guinée", "Économie"];
    if (subjectName.contains('Sci') || subjectName.contains('Bio')) return ["SVT", "L'Environnement"];
    if (subjectName.contains('ECM')) return ["Civisme", "Morale", "Institutions"];
    return ["Chapitre 1", "Chapitre 2"];
  }

  List<Widget> _getFilteredExerciseCards(BuildContext context, CourseSubject subject) {
    List<Widget> allCards = _getAllExerciseCards(context, subject);
    if (_selectedCategory == "Toutes catégories") return allCards;
    return allCards; // The filtering is handled inside _buildExerciseSecondaryCard via visibility check
  }

  List<Widget> _getAllExerciseCards(BuildContext context, CourseSubject subject) {
    String name = subject.name;
    bool is10eme = subject.id.startsWith('10_');

    if (is10eme) {
      if (name.contains('Math')) {
        return [
          _buildExerciseSecondaryCard(context, "Calcul d'Identités Remarquables", "Catégorie: Algèbre", subject),
          _buildExerciseSecondaryCard(context, "Application de Pythagore", "Catégorie: Géométrie", subject),
          _buildExerciseSecondaryCard(context, "Calculs de Trigonométrie", "Catégorie: Géométrie", subject),
          _buildExerciseSecondaryCard(context, "Théorème de Thalès", "Catégorie: Géométrie", subject),
        ];
      } else if (name.contains('Physique')) {
        return [
          _buildExerciseSecondaryCard(context, "Calcul du Poids et de la Masse", "Catégorie: Mécanique", subject),
          _buildExerciseSecondaryCard(context, "Calcul de Puissance Électrique", "Catégorie: Électricité", subject),
          _buildExerciseSecondaryCard(context, "Lentilles et Vergence", "Catégorie: Optique", subject),
          _buildExerciseSecondaryCard(context, "Loi d'Ohm en circuit", "Catégorie: Électricité", subject),
        ];
      } else if (name.contains('Chimie')) {
        return [
          _buildExerciseSecondaryCard(context, "Échelle de pH et Acidité", "Catégorie: pH", subject),
          _buildExerciseSecondaryCard(context, "Nomenclature des Alcanes", "Catégorie: Alcanes", subject),
          _buildExerciseSecondaryCard(context, "Structure de l'Atome", "Catégorie: Atomes", subject),
          _buildExerciseSecondaryCard(context, "Combustion des Hydrocarbures", "Catégorie: Alcanes", subject),
        ];
      } else if (name.contains('Français')) {
        return [
          _buildExerciseSecondaryCard(context, "Sujet de Dissertation : L'Éducation", "Catégorie: Dissertation", subject),
          _buildExerciseSecondaryCard(context, "Analyse de texte : Camara Laye", "Catégorie: Français", subject),
          _buildExerciseSecondaryCard(context, "Figures de style avancées", "Catégorie: Grammaire", subject),
        ];
      } else if (name.contains('Hist')) {
        return [
          _buildExerciseSecondaryCard(context, "Causes de l'Indépendance", "Catégorie: Histoire de Guinée", subject),
          _buildExerciseSecondaryCard(context, "Les Résistants Africains", "Catégorie: Histoire de Guinée", subject),
        ];
      } else if (name.contains('Géo')) {
        return [
          _buildExerciseSecondaryCard(context, "Économie de la Bauxite", "Catégorie: Géographie de Guinée", subject),
          _buildExerciseSecondaryCard(context, "Les 4 Régions Naturelles", "Catégorie: Géographie de Guinée", subject),
        ];
      } else if (name.contains('ECM')) {
        return [
          _buildExerciseSecondaryCard(context, "Les Institutions de l'État", "Catégorie: Institutions", subject),
          _buildExerciseSecondaryCard(context, "Civisme et Environnement", "Catégorie: Civisme", subject),
        ];
      }
    }

    // Default (6ème or other)
    if (name.contains('Chimie')) {
      return [
        _buildExerciseSecondaryCard(context, "pH de produits ménagers", "Catégorie: pH", subject),
        _buildExerciseSecondaryCard(context, "Dilution de soda", "Catégorie: Solutions aqueuses", subject),
        _buildExerciseSecondaryCard(context, "Neutralisation accidentelle", "Catégorie: pH", subject),
      ];
    } else if (name.contains('Math')) {
      return [
        _buildExerciseSecondaryCard(context, "Calcul de périmètres", "Catégorie: Géométrie", subject),
        _buildExerciseSecondaryCard(context, "Opérations sur les fractions", "Catégorie: Arithmétique", subject),
        _buildExerciseSecondaryCard(context, "Tables de multiplication", "Catégorie: Arithmétique", subject),
      ];
    } else if (name.contains('Français')) {
      return [
        _buildExerciseSecondaryCard(context, "Le Présent de l'Indicatif", "Catégorie: Conjugaison", subject),
        _buildExerciseSecondaryCard(context, "L'Accord du Participe Passé", "Catégorie: Grammaire", subject),
        _buildExerciseSecondaryCard(context, "Les Types de Phrases", "Catégorie: Grammaire", subject),
      ];
    } else if (name.contains('Hist')) {
      return [
        _buildExerciseSecondaryCard(context, "L'Indépendance de la Guinée", "Catégorie: Histoire de Guinée", subject),
        _buildExerciseSecondaryCard(context, "L'Évolution de l'Homme", "Catégorie: Préhistoire", subject),
      ];
    } else if (name.contains('Géo')) {
      return [
        _buildExerciseSecondaryCard(context, "Les Régions Naturelles", "Catégorie: Géographie de Guinée", subject),
        _buildExerciseSecondaryCard(context, "Le Cycle de l'Eau", "Catégorie: Climat", subject),
      ];
    } else if (name.contains('Sci') || name.contains('Bio')) {
      return [
        _buildExerciseSecondaryCard(context, "La Digestion", "Catégorie: Le Corps Humain", subject),
        _buildExerciseSecondaryCard(context, "Le Recyclage", "Catégorie: L'Environnement", subject),
      ];
    } else if (name.contains('ECM')) {
      return [
        _buildExerciseSecondaryCard(context, "Devoirs du Citoyen", "Catégorie: Civisme", subject),
        _buildExerciseSecondaryCard(context, "Respect des biens publics", "Catégorie: Morale", subject),
      ];
    } else {
      return [
        _buildExerciseSecondaryCard(context, "Exercice 1 : $name", "Catégorie: Chapitre 1", subject),
        _buildExerciseSecondaryCard(context, "Exercice 2 : $name", "Catégorie: Chapitre 2", subject),
      ];
    }
  }

  Widget _buildFilterChip(String label, bool isActive) {
    final Color darkBlue = const Color(0xFF161C2C);
    return GestureDetector(
      onTap: () {
        // Logique de filtre pour la démo
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? darkBlue : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isActive ? darkBlue : Colors.grey[200]!),
          boxShadow: [
            if (isActive) BoxShadow(
              color: darkBlue.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : darkBlue.withOpacity(0.6),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final Color darkBlue = const Color(0xFF161C2C);
    bool isActive = _selectedCategory == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? darkBlue : const Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseSecondaryCard(BuildContext context, String title, String subtitle, CourseSubject subject) {
    final Color darkBlue = const Color(0xFF161C2C);
    
    // Simple filter check for the demo
    if (_selectedCategory != "Toutes catégories" && !subtitle.contains(_selectedCategory)) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), 
            blurRadius: 15, 
            offset: const Offset(0, 6)
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExercisePlayScreen(
                  subject: subject,
                  exerciseTitle: title,
                  exerciseSubtitle: subtitle,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: (subject.color as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(subject.icon as IconData, color: subject.color as Color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, 
                          fontSize: 16, 
                          color: darkBlue,
                          letterSpacing: -0.5
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 11, 
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[300], size: 14),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0);
  }
}
