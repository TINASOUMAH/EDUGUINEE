import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';

class AIAssistantScreen extends StatefulWidget {
  final String className;
  final String? option;
  const AIAssistantScreen({super.key, required this.className, this.option});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  late final List<Map<String, String>> _messages;
  
  @override
  void initState() {
    super.initState();
    String levelInfo = widget.className;
    if (widget.option != null) levelInfo += " (${widget.option})";
    
    _messages = [
      {
        'role': 'ai',
        'content': "Bonjour ! Je suis ton assistant EduGuinée pour la $levelInfo. Comment puis-je t'aider aujourd'hui ?"
      },
    ];
  }
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  void _sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isTyping = true;
    });
    
    _controller.clear();
    _scrollToBottom();

    // Simulation d'une réponse intelligente locale
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        String response = _getSmartResponse(text);
        setState(() {
          _isTyping = false;
          _messages.add({'role': 'ai', 'content': response});
          _scrollToBottom();
        });
      }
    });
  }

  String _getSmartResponse(String query) {
    query = query.toLowerCase();
    bool is10eme = widget.className.contains('10');
    bool isTerminale = widget.className.contains('Terminale');
    
    if (query.contains('ph') || query.contains('acide') || query.contains('base')) {
      if (isTerminale) return "En Terminale, le pH est lié à la concentration en ions oxonium [H3O+]. pH = -log[H3O+]. N'oublie pas de vérifier si l'acide est fort ou faible !";
      if (is10eme) return "En 10ème, souviens-toi que le pH d'une solution acide est inférieur à 7. Les produits d'entretien comme l'acide chlorhydrique sont très acides. Une base comme la soude a un pH supérieur à 7.";
      return "Le pH (potentiel Hydrogène) mesure l'acidité d'une solution. \n- pH < 7 : Acide\n- pH = 7 : Neutre\n- pH > 7 : Basique";
    }
    if (query.contains('math') || query.contains('identite') || query.contains('pythagore') || query.contains('complexe')) {
      if (isTerminale) return "En Terminale, les nombres complexes s'écrivent z = a + ib. C'est un outil puissant en géométrie ! Pour l'analyse, n'oublie pas d'étudier les limites de exp(x) et ln(x).";
      if (is10eme) return "Pour ton BEPC, tu dois maîtriser les identités remarquables comme (a+b)² = x² + 2ab + b². Aussi, n'oublie pas que Pythagore ne s'applique que dans un triangle rectangle !";
      return "Le théorème de Pythagore dit que dans un triangle rectangle, a² + b² = c² (le carré de l'hypoténuse). C'est magique pour calculer des longueurs !";
    }
    if (query.contains('philo') || query.contains('conscience') || query.contains('sujet')) {
      if (isTerminale) return "La philosophie en Terminale demande de la rigueur. Que ce soit sur la conscience ou l'État, structure toujours ta dissertation : Thèse, Antithèse, Synthèse.";
      return "La philosophie est une nouvelle matière passionnante au lycée ! Elle permet de réfléchir sur le sens de la vie et de la société.";
    }
    if (query.contains('examen') || query.contains('bepc') || query.contains('bac') || query.contains('revision')) {
       if (isTerminale) return "Le BAC c'est la porte pour l'université ! Organise tes révisions selon ton option (${widget.option}). Priorise les gros coefficients et pratique sur les anciens sujets.";
       if (is10eme) return "Le BEPC est un grand moment ! Concentre-toi sur les matières à gros coefficients (Maths, Français, Physiques). Révise avec mes quiz et fiches de méthodes régulièrement.";
       return "Pour réussir tes examens, l'important est la régularité. Lis tes leçons chaque soir et entraîne-toi avec mes exercices !";
    }
    
    String context = widget.option != null ? "${widget.className} (${widget.option})" : widget.className;
    return "C'est une excellente question sur le programme de $context ! Je peux t'aider en Mathématiques${isTerminale ? ", Philosophie" : ""}, Français ou Sciences. Peux-tu préciser ton point de blocage ?";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppTheme.secondaryColor,
              child: Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text('Assistant EduGuinée', style: GoogleFonts.poppins(color: AppTheme.textMain, fontSize: 16)),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDot(),
                          _buildDot(delay: 200),
                          _buildDot(delay: 400),
                        ],
                      ),
                    ),
                  ).animate().fadeIn();
                }

                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.primaryColor : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(0),
                        bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      msg['content']!,
                      style: GoogleFonts.inter(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Pose ta question...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor,
                    radius: 24,
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({int delay = 0}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 6,
      height: 6,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .scale(delay: delay.ms, duration: 400.ms, begin: const Offset(1, 1), end: const Offset(1.5, 1.5));
  }
}
