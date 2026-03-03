import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/course_models.dart';

class QuizQuestion {
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizPlayScreen extends StatefulWidget {
  final CourseSubject subject;
  final String mode;

  const QuizPlayScreen({
    super.key, 
    required this.subject, 
    required this.mode
  });

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  // Theme Colors
  final Color darkBlue = const Color(0xFF161C2C);
  final Color accentYellow = const Color(0xFFFFC107);
  final Color bgLight = const Color(0xFFF4F6F8);
  final Color successGreen = const Color(0xFF4CAF50);
  final Color errorRed = const Color(0xFFF44336);

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  late Timer _timer;
  int _timeLeft = 30;
  late List<QuizQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = _generateQuestionsForSubject(widget.subject);
    _startTimer();
  }

  List<QuizQuestion> _generateQuestionsForSubject(CourseSubject subject) {
    // 10ème (BEPC) Questions
    if (subject.id.startsWith('10_')) {
      if (subject.id.contains('fr')) {
        return [
          QuizQuestion(
            text: "Quel écrivain a écrit 'L'Enfant Noir' ?",
            options: ["Camara Laye", "Djibril Tamsir Niane", "Williams Sassine", "Tierno Monénembo"],
            correctOptionIndex: 0,
          ),
          QuizQuestion(
            text: "Dans une dissertation, où annonce-t-on le plan ?",
            options: ["Dans la conclusion", "Dans l'introduction", "Dans le développement", "Dans la synthèse"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Quelle figure de style est utilisée dans 'Le soleil rit' ?",
            options: ["Métaphore", "Comparaison", "Personnification", "Hyperbole"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('maths')) {
        return [
          QuizQuestion(
            text: "Calcule (a + b)²",
            options: ["a² + b²", "a² + 2ab + b²", "a² - 2ab + b²", "a² + ab + b²"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Dans un triangle rectangle, le cosinus est le rapport :",
            options: ["Opposé / Hypoténuse", "Adjacent / Hypoténuse", "Opposé / Adjacent", "Hypoténuse / Adjacent"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Le théorème de Pythagore s'applique dans un triangle :",
            options: ["Isocèle", "Équilatéral", "Rectangle", "Quelconque"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('phys')) {
        return [
          QuizQuestion(
            text: "Quelle est l'unité du poids (P) ?",
            options: ["Kilogramme (kg)", "Newton (N)", "Joule (J)", "Watt (W)"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Quelle est la formule de la loi d'Ohm ?",
            options: ["P = U x I", "U = R x I", "W = F x d", "E = P x t"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Une lentille convergente a une vergence :",
            options: ["Nulle", "Négative", "Positive", "Infinie"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('chim')) {
        return [
          QuizQuestion(
            text: "Une solution dont le pH est égal à 2 est :",
            options: ["Basique", "Neutre", "Acide", "Alcaline"],
            correctOptionIndex: 2,
          ),
          QuizQuestion(
            text: "Quelle est la formule générale des Alcanes ?",
            options: ["CnH2n", "CnH2n-2", "CnH2n+2", "CnHn"],
            correctOptionIndex: 2,
          ),
          QuizQuestion(
            text: "L'atome est composé de protons, neutrons et :",
            options: ["Molécules", "Ions", "Électrons", "Noyaux"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('bio')) {
        return [
          QuizQuestion(
            text: "Où se trouve l'ADN dans une cellule ?",
            options: ["Dans le cytoplasme", "Dans le noyau", "Dans la membrane", "Dans les vacuoles"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Le VIH attaque principalement :",
            options: ["Les globules rouges", "Le système nerveux", "Le système immunitaire", "Les poumons"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('hist')) {
        return [
          QuizQuestion(
            text: "En quelle année la Guinée a-t-elle voté 'NON' au référendum ?",
            options: ["1945", "1958", "1960", "1984"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "Qui a dirigé la 1ère République de Guinée ?",
            options: ["Lansana Conté", "Sékou Touré", "Alpha Condé", "Louis Lansana Beavogui"],
            correctOptionIndex: 1,
          ),
        ];
      } else if (subject.id.contains('geo')) {
        return [
          QuizQuestion(
            text: "Quelle est la principale ressource minière de la Guinée ?",
            options: ["L'or", "Le diamant", "La bauxite", "Le fer"],
            correctOptionIndex: 2,
          ),
          QuizQuestion(
            text: "Quel pays est la 1ère puissance économique mondiale ?",
            options: ["Chine", "Japon", "USA", "Allemagne"],
            correctOptionIndex: 2,
          ),
        ];
      } else if (subject.id.contains('ecm')) {
        return [
          QuizQuestion(
            text: "Quelles sont les couleurs du drapeau guinéen ?",
            options: ["Bleu-Blanc-Rouge", "Rouge-Jaune-Vert", "Vert-Blanc-Rouge", "Jaune-Bleu-Rouge"],
            correctOptionIndex: 1,
          ),
          QuizQuestion(
            text: "La devise de la Guinée est :",
            options: ["Unité-Progrès-Justice", "Travail-Justice-Solidarité", "Liberté-Égalité-Fraternité", "Paix-Travail-Patrie"],
            correctOptionIndex: 1,
          ),
        ];
      }
    }

    // 6ème (Default) Questions
    if (subject.id.contains('fr')) {
      return [
        QuizQuestion(
          text: "Quel est le type d'une phrase qui donne un ordre ?",
          options: ["Déclarative", "Interrogative", "Impérative", "Exclamative"],
          correctOptionIndex: 2,
        ),
        QuizQuestion(
          text: "Comment appelle-t-on les verbes se terminant en -er ?",
          options: ["1er groupe", "2ème groupe", "3ème groupe", "Verbes d'état"],
          correctOptionIndex: 0,
        ),
      ];
    } else if (subject.id.contains('calcul') || subject.id.contains('maths')) {
      return [
        QuizQuestion(
          text: "Combien d'angles possède un triangle ?",
          options: ["2", "3", "4", "5"],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          text: "Quel est le périmètre d'un carré de 5 cm de côté ?",
          options: ["10 cm", "20 cm", "25 cm", "15 cm"],
          correctOptionIndex: 1,
        ),
      ];
    } else if (subject.id.contains('hist')) {
      return [
        QuizQuestion(
          text: "Quelle est la date de l'indépendance de la Guinée ?",
          options: ["2 octobre 1958", "1er janvier 1960", "28 septembre 1958", "14 mai 1957"],
          correctOptionIndex: 0,
        ),
      ];
    } else if (subject.id.contains('geo')) {
      return [
        QuizQuestion(
          text: "Combien y a-t-il de régions naturelles en Guinée ?",
          options: ["2", "3", "4", "5"],
          correctOptionIndex: 2,
        ),
      ];
    } else if (subject.id.contains('sci') || subject.id.contains('bio')) {
      return [
        QuizQuestion(
          text: "Quel organe permet de respirer ?",
          options: ["Le cœur", "L'estomac", "Les poumons", "Le foie"],
          correctOptionIndex: 2,
        ),
      ];
    } else {
      return [
        QuizQuestion(
          text: "Quelle est la devise de la Guinée ?",
          options: ["Liberté - Égalité - Fraternité", "Travail - Justice - Solidarité", "Unité - Progrès - Justice", "Paix - Travail - Patrie"],
          correctOptionIndex: 1,
        ),
      ];
    }
  }

  void _startTimer() {
    _timeLeft = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _selectedOptionIndex = -1; // No selection
      });
      _timer.cancel();
    }
  }

  void _handleOptionSelect(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedOptionIndex = index;
      _isAnswered = true;
      if (index == _questions[_currentQuestionIndex].correctOptionIndex) {
        _score += 10;
      }
    });
    _timer.cancel();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      });
      _startTimer();
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: darkBlue, shape: BoxShape.circle),
              child: Icon(Icons.emoji_events_rounded, color: accentYellow, size: 60),
            ),
            const SizedBox(height: 20),
            Text(
              "Bravo !",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: darkBlue),
            ),
            const SizedBox(height: 10),
            Text(
              "Tu as fini le quiz de ${widget.subject.name}.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Text(
              "$_score Points",
              style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: darkBlue),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Back to detail
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text("Continuer", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: bgLight,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildQuestionCard(question),
                  const SizedBox(height: 30),
                  ...List.generate(
                    question.options.length,
                    (index) => _buildOptionCard(question.options[index], index, question.correctOptionIndex),
                  ),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 20, left: 10, right: 20),
      color: darkBlue,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Text(
                  "${widget.subject.name}",
                  style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer_outlined, color: accentYellow, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "$_timeLeft",
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question ${_currentQuestionIndex + 1} / ${_questions.length}",
                      style: GoogleFonts.inter(color: Colors.white.withOpacity(0.7), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Score : $_score",
                      style: GoogleFonts.poppins(color: accentYellow, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / _questions.length,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    color: accentYellow,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(QuizQuestion question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.volume_up_rounded, color: darkBlue.withOpacity(0.3), size: 24),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: darkBlue.withOpacity(0.03),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              question.text,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: darkBlue,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildOptionCard(String text, int index, int correctIndex) {
    bool isSelected = _selectedOptionIndex == index;
    bool isCorrect = index == correctIndex;
    
    Color cardColor = Colors.white;
    Color textColor = darkBlue;
    Widget? trailing;

    if (_isAnswered) {
      if (isCorrect) {
        cardColor = successGreen;
        textColor = Colors.white;
        trailing = const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24);
      } else if (isSelected) {
        cardColor = errorRed;
        textColor = Colors.white;
        trailing = const Icon(Icons.cancel_rounded, color: Colors.white, size: 24);
      }
    }

    return GestureDetector(
      onTap: () => _handleOptionSelect(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: _isAnswered ? _nextQuestion : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: darkBlue,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
            ),
            child: Text(
              _currentQuestionIndex < _questions.length - 1 ? "Continuer" : "Voir le score",
              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
