import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// ============================================================
/// GeminiService — Tuteur IA pour l'application EduGuinée
/// ============================================================
///
/// Fonctionnalités disponibles :
///   1. [askQuestion]      – Question/Réponse sur un cours
///   2. [sendChatMessage]  – Chat interactif avec le tuteur IA
///   3. [explainConcept]   – Explication simplifiée d'une notion
///   4. [generateQuiz]     – Génération de quiz dynamiques
///   5. [summarizeCourse]  – Résumé structuré d'un cours
///   6. [correctExercise]  – Correction + feedback d'un exercice
///
/// 🔑 IMPORTANT : Assurez-vous d'avoir une clé API valide dans le fichier .env
/// ============================================================
class GeminiService {
  // ─────────────────────────────────────────
  // 🔑 Configuration API
  // ─────────────────────────────────────────
  static String get _apiKey => dotenv.env['GEMINI_APIKEY'] ?? '';
  static const String _modelName = 'gemini-2.5-flash';

  // Persona du tuteur IA adapté au contexte guinéen
  static const String _systemPrompt = '''
Tu es EduBot, un tuteur IA bienveillant et pédagogue intégré dans EduGuinée,
une application éducative pour les élèves guinéens du primaire au lycée.

Tes règles :
- Réponds TOUJOURS en français
- Adapte tes explications au niveau scolaire guinéen (programmes MENA Guinée)
- Utilise des exemples concrets du contexte guinéen (Conakry, Labé, Kindia, etc.)
- Sois encourageant, patient et positif
- Si la question n'est pas liée à l'éducation, redirige poliment vers un sujet scolaire
- Prépare les élèves aux examens nationaux : CEPE, BEPC, Baccalauréat
''';

  late final GenerativeModel _model;
  late final GenerativeModel _chatModel;
  ChatSession? _chatSession;

  GeminiService() {
    _model = GenerativeModel(
      model: _modelName,
      apiKey: _apiKey,
      systemInstruction: Content.system(_systemPrompt),
      generationConfig: GenerationConfig(
        temperature: 0.7,
        maxOutputTokens: 2048,
        topP: 0.9,
      ),
    );

    _chatModel = GenerativeModel(
      model: _modelName,
      apiKey: _apiKey,
      systemInstruction: Content.system(_systemPrompt),
      generationConfig: GenerationConfig(
        temperature: 0.8,
        maxOutputTokens: 1024,
        topP: 0.95,
      ),
    );
  }

  // ════════════════════════════════════════════════════
  // 1. QUESTION / RÉPONSE SUR UN COURS
  // ════════════════════════════════════════════════════

  /// Pose une question à Gemini dans le contexte d'un cours.
  ///
  /// Exemple :
  /// ```dart
  /// final service = GeminiService();
  /// final reponse = await service.askQuestion(
  ///   question: 'Comment calculer l\'aire d\'un cercle ?',
  ///   subject: 'Mathématiques',
  ///   className: '4ème année',
  /// );
  /// ```
  Future<String> askQuestion({
    required String question,
    String? subject,
    String? className,
  }) async {
    try {
      final context = _buildContextHeader(subject: subject, className: className);
      final prompt = '${context}Question de l\'élève : $question';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Je n\'ai pas pu répondre. Réessaie s\'il te plaît.';
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur inattendue : $e');
    }
  }

  // ════════════════════════════════════════════════════
  // 2. CHAT INTERACTIF AVEC LE TUTEUR IA
  // ════════════════════════════════════════════════════

  /// Démarre une nouvelle session de chat (efface l'historique ou reprend le précédent).
  void startNewChatSession({List<Map<String, String>>? historyMessages}) {
    List<Content>? modelHistory;
    
    if (historyMessages != null && historyMessages.isNotEmpty) {
      modelHistory = historyMessages.map((msg) {
        final role = msg['role'] == 'user' ? 'user' : 'model';
        final text = msg['content'] ?? '';
        return Content(role, [TextPart(text)]);
      }).toList();
    }
    
    _chatSession = _chatModel.startChat(history: modelHistory);
  }

  /// Envoie un message dans la session de chat.
  ///
  /// Lance automatiquement une session si aucune n'est active.
  Future<String> sendChatMessage(String message) async {
    _chatSession ??= _chatModel.startChat();

    try {
      final response = await _chatSession!.sendMessage(
        Content.text(message),
      );
      return response.text ?? 'Je n\'ai pas compris. Peux-tu reformuler ?';
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur inattendue : $e');
    }
  }

  /// Retourne l'historique du chat sous forme de liste de maps.
  /// Chaque map contient 'role' ('user' ou 'model') et 'text'.
  List<Map<String, String>> getChatHistory() {
    if (_chatSession == null) return [];
    return _chatSession!.history.map((content) {
      final text = content.parts
          .whereType<TextPart>()
          .map((p) => p.text)
          .join('\n');
      return {
        'role': content.role ?? 'user',
        'text': text,
      };
    }).toList();
  }

  /// Efface la session de chat en cours.
  void clearChatSession() {
    _chatSession = null;
  }

  // ════════════════════════════════════════════════════
  // 3. EXPLICATION SIMPLIFIÉE D'UN CONCEPT
  // ════════════════════════════════════════════════════

  /// Demande une explication claire et simplifiée d'une notion.
  ///
  /// Exemple :
  /// ```dart
  /// final explication = await service.explainConcept(
  ///   concept: 'la photosynthèse',
  ///   subject: 'SVT',
  ///   className: '6ème année',
  /// );
  /// ```
  Future<String> explainConcept({
    required String concept,
    String? subject,
    String? className,
  }) async {
    try {
      final context = _buildContextHeader(subject: subject, className: className);
      final prompt = '''
${context}Explique le concept suivant de façon très claire, avec :
1. Une définition simple (2-3 phrases maximum)
2. Un exemple concret tiré du quotidien en Guinée
3. Une astuce mnémotechnique pour s'en souvenir

Concept à expliquer : $concept
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Impossible de générer l\'explication.';
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur inattendue : $e');
    }
  }

  // ════════════════════════════════════════════════════
  // 4. GÉNÉRATION DE QUIZ DYNAMIQUES
  // ════════════════════════════════════════════════════

  /// Génère une liste de questions QCM basées sur un chapitre.
  ///
  /// Exemple :
  /// ```dart
  /// final questions = await service.generateQuiz(
  ///   chapterTitle: 'Les équations du second degré',
  ///   subject: 'Mathématiques',
  ///   className: 'Terminale',
  ///   numberOfQuestions: 5,
  ///   difficulty: 'Difficile',
  /// );
  /// ```
  Future<List<GeminiQuizQuestion>> generateQuiz({
    required String chapterTitle,
    String? subject,
    String? className,
    int numberOfQuestions = 5,
    String difficulty = 'Moyen',
  }) async {
    try {
      final context = _buildContextHeader(subject: subject, className: className);
      final prompt = '''
${context}Génère exactement $numberOfQuestions questions QCM (choix multiples) sur le chapitre ci-dessous.
Difficulté : $difficulty
Chapitre : "$chapterTitle"

Réponds UNIQUEMENT avec du JSON valide (pas de markdown, pas d'explication), dans ce format exact :
[
  {
    "question": "Texte de la question ?",
    "options": ["Option A", "Option B", "Option C", "Option D"],
    "correct_index": 0,
    "explanation": "Explication brève de la bonne réponse."
  }
]
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '[]';
      return _parseQuizResponse(text);
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur lors de la génération du quiz : $e');
    }
  }

  // ════════════════════════════════════════════════════
  // 5. RÉSUMÉ D'UN COURS
  // ════════════════════════════════════════════════════

  /// Génère un résumé structuré d'un cours.
  ///
  /// [courseContent] : Texte du cours à résumer (peut être long)
  Future<String> summarizeCourse({
    required String courseContent,
    String? subject,
    String? className,
  }) async {
    try {
      final context = _buildContextHeader(subject: subject, className: className);
      final prompt = '''
${context}Fais un résumé structuré et concis du cours suivant.
Inclure :
• Les points clés essentiels (bullet points)
• Les formules ou règles importantes (si applicable)
• Ce que l'élève doit absolument maîtriser pour l'examen

Contenu du cours :
$courseContent
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Impossible de générer le résumé.';
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur inattendue : $e');
    }
  }

  // ════════════════════════════════════════════════════
  // 6. CORRECTION D'UN EXERCICE
  // ════════════════════════════════════════════════════

  /// Corrige la réponse d'un élève à un exercice et fournit un feedback.
  ///
  /// Retourne un [ExerciseCorrection] avec score, feedback et bonne réponse.
  Future<ExerciseCorrection> correctExercise({
    required String exerciseText,
    required String studentAnswer,
    String? subject,
    String? className,
  }) async {
    try {
      final context = _buildContextHeader(subject: subject, className: className);
      final prompt = '''
${context}Corrige la réponse de l'élève à cet exercice.

Énoncé de l'exercice : $exerciseText

Réponse de l'élève : $studentAnswer

Réponds UNIQUEMENT avec du JSON valide, dans ce format exact :
{
  "is_correct": true,
  "score": 8,
  "max_score": 10,
  "feedback": "Commentaire encourageant et constructif.",
  "correct_answer": "La réponse correcte et complète.",
  "tips": "Un conseil pour s'améliorer la prochaine fois."
}
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '{}';
      return _parseCorrectionResponse(text);
    } on GenerativeAIException catch (e) {
      throw GeminiException('Erreur API Gemini : ${e.message}');
    } catch (e) {
      throw GeminiException('Erreur lors de la correction : $e');
    }
  }

  // ════════════════════════════════════════════════════
  // MÉTHODES PRIVÉES UTILITAIRES
  // ════════════════════════════════════════════════════

  /// Construit l'en-tête de contexte à injecter dans les prompts.
  String _buildContextHeader({String? subject, String? className}) {
    if (subject == null && className == null) return '';
    final parts = <String>[];
    if (className != null) parts.add('Niveau : $className');
    if (subject != null) parts.add('Matière : $subject');
    return '[${parts.join(' | ')}]\n\n';
  }

  /// Parse la réponse JSON d'un quiz généré par Gemini.
  List<GeminiQuizQuestion> _parseQuizResponse(String rawText) {
    // Nettoyage : supprime les balises markdown si présentes
    final clean = _cleanJsonResponse(rawText);

    try {
      final List<dynamic> decoded = jsonDecode(clean) as List<dynamic>;
      return decoded.map((item) {
        final map = item as Map<String, dynamic>;
        return GeminiQuizQuestion(
          question: map['question'] as String? ?? '',
          options: List<String>.from(map['options'] as List? ?? []),
          correctIndex: (map['correct_index'] as num?)?.toInt() ?? 0,
          explanation: map['explanation'] as String? ?? '',
        );
      }).toList();
    } catch (e) {
      // Fallback en cas d'erreur de parsing
      return [
        GeminiQuizQuestion(
          question: 'Erreur de génération. Réessaie.',
          options: ['—', '—', '—', '—'],
          correctIndex: 0,
          explanation: 'Réponse brute : $rawText',
        ),
      ];
    }
  }

  /// Parse la réponse JSON d'une correction d'exercice.
  ExerciseCorrection _parseCorrectionResponse(String rawText) {
    final clean = _cleanJsonResponse(rawText);

    try {
      final map = jsonDecode(clean) as Map<String, dynamic>;
      return ExerciseCorrection(
        isCorrect: map['is_correct'] as bool? ?? false,
        score: (map['score'] as num?)?.toDouble() ?? 0,
        maxScore: (map['max_score'] as num?)?.toDouble() ?? 10,
        feedback: map['feedback'] as String? ?? '',
        correctAnswer: map['correct_answer'] as String? ?? '',
        tips: map['tips'] as String? ?? '',
      );
    } catch (_) {
      // Fallback : on retourne le texte brut comme feedback
      return ExerciseCorrection(
        isCorrect: false,
        score: 0,
        maxScore: 10,
        feedback: rawText,
        correctAnswer: '',
        tips: '',
      );
    }
  }

  /// Nettoie la réponse de Gemini en retirant les balises markdown.
  String _cleanJsonResponse(String text) {
    return text
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();
  }
}

// ════════════════════════════════════════════════════
// MODÈLES DE DONNÉES
// ════════════════════════════════════════════════════

/// Représente une question de quiz générée par Gemini.
class GeminiQuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const GeminiQuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  /// Retourne directement le texte de la bonne réponse.
  String get correctAnswer =>
      (correctIndex >= 0 && correctIndex < options.length)
          ? options[correctIndex]
          : '';
}

/// Résultat de la correction d'un exercice par Gemini.
class ExerciseCorrection {
  final bool isCorrect;
  final double score;
  final double maxScore;
  final String feedback;
  final String correctAnswer;
  final String tips;

  const ExerciseCorrection({
    required this.isCorrect,
    required this.score,
    required this.maxScore,
    required this.feedback,
    required this.correctAnswer,
    required this.tips,
  });

  /// Pourcentage du score (0–100).
  double get percentage => maxScore > 0 ? (score / maxScore) * 100 : 0;

  /// Note formatée (ex: "8/10").
  String get formattedScore =>
      '${score.toStringAsFixed(0)}/${maxScore.toStringAsFixed(0)}';
}

/// Exception levée en cas d'erreur du service Gemini.
class GeminiException implements Exception {
  final String message;

  const GeminiException(this.message);

  @override
  String toString() => 'GeminiException: $message';
}
