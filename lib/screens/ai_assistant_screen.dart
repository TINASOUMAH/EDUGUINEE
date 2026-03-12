import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/theme/app_theme.dart';
import '../services/gemini_service.dart';

class AIAssistantScreen extends StatefulWidget {
  final String className;
  final String? option;
  const AIAssistantScreen({super.key, required this.className, this.option});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ── Service Gemini ──────────────────────────────────
  final GeminiService _geminiService = GeminiService();

  List<Map<String, String>> _messages = [];
  bool _isTyping = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  // ── Chargement de l'historique ────────────────────────
  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString('ai_chat_history');

    if (historyJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(historyJson);
        _messages = decoded.map((e) => Map<String, String>.from(e)).toList();
      } catch (_) {
        _messages = [];
      }
    }

    if (_messages.isEmpty) {
      String levelInfo = widget.className;
      if (widget.option != null) levelInfo += ' (${widget.option})';

      _messages = [
        {
          'role': 'ai',
          'content':
              "Bonjour ! 👋 Je suis **EduBot**, ton assistant IA pour la $levelInfo.\n\n"
              "Je peux t'aider à :\n"
              "• Comprendre tes cours\n"
              "• Expliquer des concepts difficiles\n"
              "• Préparer tes examens (BEPC, BAC)\n\n"
              "Comment puis-je t'aider aujourd'hui ?",
        }
      ];
    }

    // Initialise la session avec l'historique rechargé
    _geminiService.startNewChatSession(historyMessages: _messages);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  // ── Sauvegarde de l'historique ────────────────────────
  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ai_chat_history', jsonEncode(_messages));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ── Envoi d'un message à Gemini ─────────────────────
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isTyping = true;
      _errorMessage = null;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      // Construit un message contextualisé (classe + option)
      final contextPrefix = _buildContextPrefix();
      final fullMessage = contextPrefix.isNotEmpty
          ? '$contextPrefix\n$text'
          : text;

      final response = await _geminiService.sendChatMessage(fullMessage);

      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({'role': 'ai', 'content': response});
        });
        _scrollToBottom();
        _saveChatHistory();
      }
    } on GeminiException catch (e) {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _errorMessage = e.message;
          _messages.add({
            'role': 'ai',
            'content': '⚠️ Erreur technique : ${e.message}',
          });
        });
        _scrollToBottom();
        _saveChatHistory();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _errorMessage = e.toString();
          _messages.add({
            'role': 'ai',
            'content': '⚠️ Erreur inattendue : $e',
          });
        });
        _scrollToBottom();
        _saveChatHistory();
      }
    }
  }

  /// Préfixe de contexte envoyé avec chaque message (invisible pour l'élève,
  /// mais aide Gemini à adapter ses réponses).
  String _buildContextPrefix() {
    final parts = <String>[];
    parts.add('[Niveau: ${widget.className}]');
    if (widget.option != null) parts.add('[Option: ${widget.option}]');
    return parts.join(' ');
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ── Nouvelle conversation ────────────────────────────
  void _startNewConversation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Nouvelle conversation',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text(
          'Veux-tu effacer cette conversation et en commencer une nouvelle ?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Annuler', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _geminiService.startNewChatSession();
              setState(() {
                _messages.clear();
                _messages.add({
                  'role': 'ai',
                  'content':
                      'Nouvelle conversation démarrée ! 🚀 Comment puis-je t\'aider ?',
                });
                _errorMessage = null;
              });
              _saveChatHistory();
            },
            child: Text('Recommencer',
                style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EduBot IA',
                  style: GoogleFonts.poppins(
                    color: AppTheme.textMain,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Propulsé par Gemini',
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined, color: AppTheme.primaryColor),
            tooltip: 'Nouvelle conversation',
            onPressed: _startNewConversation,
          ),
        ],
      ),
      body: Column(
        children: [
          // Bandeau d'erreur si API Key non configurée
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              color: Colors.red.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage ?? 'Erreur inconnue',
                      style: GoogleFonts.inter(
                          color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

          // Liste des messages
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Indicateur "en train d'écrire..."
                      if (index == _messages.length) {
                        return _buildTypingIndicator();
                      }

                      final msg = _messages[index];
                      final isUser = msg['role'] == 'user';

                      return _buildMessageBubble(
                        content: msg['content']!,
                        isUser: isUser,
                        index: index,
                      );
                    },
                  ),
          ),

          // Zone de saisie
          _buildInputBar(),
        ],
      ),
    );
  }

  // ── Bulle de message ────────────────────────────────
  Widget _buildMessageBubble({
    required String content,
    required bool isUser,
    required int index,
  }) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar IA
          if (!isUser) ...[
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 8, bottom: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                ),
              ),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 16),
            ),
          ],

          // Bulle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isUser
                    ? const Radius.circular(20)
                    : const Radius.circular(4),
                bottomRight: isUser
                    ? const Radius.circular(4)
                    : const Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              content,
              style: GoogleFonts.inter(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.08, end: 0);
  }

  // ── Indicateur de frappe ────────────────────────────
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(left: 16, right: 8, bottom: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              ),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
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
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildDot({int delay = 0}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          delay: delay.ms,
          duration: 400.ms,
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.3, 1.3),
        );
  }

  // ── Barre de saisie ─────────────────────────────────
  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Pose ta question à EduBot...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
                style: GoogleFonts.inter(fontSize: 14),
              ),
            ),
            const SizedBox(width: 10),
            // Bouton Envoyer
            GestureDetector(
              onTap: _isTyping ? null : _sendMessage,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _isTyping
                      ? LinearGradient(
                          colors: [Colors.grey.shade300, Colors.grey.shade300])
                      : LinearGradient(
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.secondaryColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  boxShadow: _isTyping
                      ? []
                      : [
                          BoxShadow(
                            color: AppTheme.primaryColor.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: _isTyping
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_rounded,
                        color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
