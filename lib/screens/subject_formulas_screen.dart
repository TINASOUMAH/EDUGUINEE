import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart'; // For clipboard
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import '../data/course_data.dart'; // To access the full data

class SubjectFormulasScreen extends StatefulWidget {
  final CourseSubject subject;

  const SubjectFormulasScreen({super.key, required this.subject});

  @override
  State<SubjectFormulasScreen> createState() => _SubjectFormulasScreenState();
}

class _SubjectFormulasScreenState extends State<SubjectFormulasScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<CourseSection> _formulas = [];
  final List<CourseSection> _methods = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _extractContent();
  }

  void _extractContent() {
    // Flatten the hierarchy to find all formulas and methods for this subject
    for (var chapter in widget.subject.chapters) {
      for (var sub in chapter.subChapters) {
        for (var section in sub.sections) {
          if (section.type == CourseSectionType.formula) {
            _formulas.add(section);
          } else if (section.type == CourseSectionType.method) {
            _methods.add(section);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(widget.subject.name, style: GoogleFonts.poppins(color: AppTheme.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: widget.subject.color,
          unselectedLabelColor: Colors.grey,
          indicatorColor: widget.subject.color,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: "Formules"),
            Tab(text: "Méthodes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFormulasList(),
          _buildMethodsList(),
        ],
      ),
    );
  }

  Widget _buildFormulasList() {
    if (_formulas.isEmpty) {
      return _buildEmptyState("Aucune formule trouvée pour le moment.");
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _formulas.length,
      itemBuilder: (context, index) {
        final formula = _formulas[index];
        return _buildFormulaCard(formula, index);
      },
    );
  }

  Widget _buildMethodsList() {
    if (_methods.isEmpty) {
      return _buildEmptyState("Aucune méthode trouvée pour le moment.");
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _methods.length,
      itemBuilder: (context, index) {
        final method = _methods[index];
        return _buildMethodCard(method, index);
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book_rounded, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaCard(CourseSection formula, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: widget.subject.color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    formula.title ?? 'Formule #${index + 1}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: widget.subject.color,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 20, color: Colors.grey),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: formula.content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Formule copiée !", style: GoogleFonts.inter()),
                        backgroundColor: AppTheme.primaryColor,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  formula.content,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
                if (formula.subContent != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                         Expanded(
                           child: Text(
                            formula.subContent!,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                                                 ),
                         ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
  }

  Widget _buildMethodCard(CourseSection method, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lightbulb_outline, color: AppTheme.secondaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  method.title ?? 'Méthode #${index + 1}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            method.content,
            style: GoogleFonts.inter(fontSize: 15, height: 1.6, color: Colors.grey[800]),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1);
  }
}
