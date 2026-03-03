import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'pdf_viewer_screen.dart';
import '../core/theme/app_theme.dart';

class PastPapersScreen extends StatefulWidget {
  final String className;
  final String? option;
  const PastPapersScreen({super.key, required this.className, this.option});

  @override
  State<PastPapersScreen> createState() => _PastPapersScreenState();
}

class _PastPapersScreenState extends State<PastPapersScreen> {
  late List<Map<String, dynamic>> _subjects;
  late String _selectedExam;
  final List<String> _exams = ["2023", "2022", "2021", "2020", "2019"];

  @override
  void initState() {
    super.initState();
    _selectedExam = widget.className;
    _subjects = _getSubjectsForClass(widget.className);
  }

  List<Map<String, dynamic>> _getSubjectsForClass(String className) {
    if (className.contains('Terminale')) {
      final List<Map<String, dynamic>> baseSubjects = [
        {'name': 'Philosophie', 'icon': Icons.psychology_rounded, 'color': Colors.deepPurple},
        {'name': 'Français', 'icon': Icons.menu_book_rounded, 'color': Colors.blue},
        {'name': 'Anglais', 'icon': Icons.language_rounded, 'color': Colors.indigo},
        {'name': 'Histoire', 'icon': Icons.history_edu_rounded, 'color': Colors.brown},
      ];

      if (widget.option == 'TSM') {
        return [
          {'name': 'Mathématiques', 'icon': Icons.calculate_rounded, 'color': Colors.purple},
          {'name': 'Physique', 'icon': Icons.bolt_rounded, 'color': Colors.orange},
          {'name': 'Chimie', 'icon': Icons.science_rounded, 'color': Colors.green},
          ...baseSubjects,
        ];
      } else if (widget.option == 'TEM') {
        return [
          {'name': 'SVT', 'icon': Icons.biotech_rounded, 'color': Colors.teal},
          {'name': 'Physique', 'icon': Icons.bolt_rounded, 'color': Colors.orange},
          {'name': 'Chimie', 'icon': Icons.science_rounded, 'color': Colors.green},
          {'name': 'Mathématiques', 'icon': Icons.calculate_rounded, 'color': Colors.purple},
          ...baseSubjects,
        ];
      } else if (widget.option == 'TSS') {
        return [
          ...baseSubjects,
          {'name': 'Géographie', 'icon': Icons.public_rounded, 'color': Colors.cyan},
          {'name': 'Économie', 'icon': Icons.trending_up_rounded, 'color': Colors.teal},
          {'name': 'Mathématiques', 'icon': Icons.calculate_rounded, 'color': Colors.purple},
        ];
      }
      return baseSubjects;
    } else if (className.contains('10')) {
      return [
        {'name': 'Français', 'icon': Icons.menu_book_rounded, 'color': Colors.blue},
        {'name': 'Mathématiques', 'icon': Icons.calculate_rounded, 'color': Colors.purple},
        {'name': 'Physique', 'icon': Icons.bolt_rounded, 'color': Colors.orange},
        {'name': 'Chimie', 'icon': Icons.science_rounded, 'color': Colors.green},
        {'name': 'SVT', 'icon': Icons.biotech_rounded, 'color': Colors.teal},
        {'name': 'Histoire', 'icon': Icons.history_edu_rounded, 'color': Colors.brown},
        {'name': 'Géographie', 'icon': Icons.public_rounded, 'color': Colors.cyan},
        {'name': 'ECM', 'icon': Icons.gavel_rounded, 'color': Colors.red},
        {'name': 'Anglais', 'icon': Icons.language_rounded, 'color': Colors.indigo},
      ];
    } else {
      return [
        {'name': 'Rédaction', 'icon': Icons.edit_note_rounded, 'color': Colors.blue},
        {'name': 'Dictée-Questions', 'icon': Icons.spellcheck_rounded, 'color': Colors.orange},
        {'name': 'Calcul', 'icon': Icons.calculate_rounded, 'color': Colors.purple},
        {'name': 'Sciences d\'Obs.', 'icon': Icons.biotech_rounded, 'color': Colors.green},
        {'name': 'Histoire-Géo', 'icon': Icons.public_rounded, 'color': Colors.teal},
        {'name': 'ECM', 'icon': Icons.gavel_rounded, 'color': Colors.red},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildExamFilter(),
                   const SizedBox(height: 25),
                   Text(
                    'Par Matière',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMain,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildSubjectCard(_subjects[index]),
                childCount: _subjects.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      stretch: true,
      backgroundColor: AppTheme.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'ANCIENS SUJETS',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Background decoration positioned safely
            Positioned(
              right: -30,
              top: -20,
              child: Icon(
                Icons.history_edu_rounded,
                size: 180,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
            // Content with clearer spacing
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Annales & Examens',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Entraîne-toi avec les sessions passées',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamFilter() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _exams.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedExam == _exams[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedExam = _exams[index]),
            child: AnimatedContainer(
              duration: 300.ms,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.secondaryColor : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(color: AppTheme.secondaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))
                ],
              ),
              child: Text(
                _exams[index],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppTheme.primaryColor : AppTheme.textSub,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (subject['color'] as Color).withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showPapersForSubject(subject),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (subject['color'] as Color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(subject['icon'], color: subject['color'], size: 30),
                ),
                const SizedBox(height: 15),
                Text(
                  subject['name'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().scale(delay: 100.ms);
  }

  void _showPapersForSubject(Map<String, dynamic> subject) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(subject['icon'], color: AppTheme.secondaryColor, size: 28),
                  const SizedBox(width: 15),
                  Text(
                    subject['name'],
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Sujets disponibles pour le $_selectedExam',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    int year = 2023 - index;
                    return _buildPaperTile(year, subject['color']);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaperTile(int year, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.picture_as_pdf_rounded, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sujet Session $year',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  'Examen National • ${widget.className.contains('10') ? 'BEPC' : widget.className.contains('Terminale') ? 'BAC' : 'CEE (6ème)'}',
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textSub),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye_rounded, color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => PdfViewerScreen(
                    title: 'Sujet Session $year',
                    pdfUrl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf', // URL de test
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download_for_offline_rounded, color: AppTheme.textSub),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
