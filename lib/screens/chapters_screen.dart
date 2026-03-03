import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import '../models/course_models.dart';
import 'course_content_screen.dart';

class ChaptersScreen extends StatefulWidget {
  final CourseSubject subject;

  const ChaptersScreen({super.key, required this.subject});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.subject.chapters.isEmpty ? 1 : widget.subject.chapters.length, 
      vsync: this
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subject.chapters.isEmpty) {
      return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          title: Text(widget.subject.name, style: GoogleFonts.poppins(color: Colors.white)),
          backgroundColor: AppTheme.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.secondaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text(
            "Les cours arrivent bientôt...",
            style: GoogleFonts.inter(color: Colors.white70),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              backgroundColor: AppTheme.primaryColor,
              leading: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.secondaryColor, size: 20),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.subject.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [const Shadow(color: Colors.black45, blurRadius: 10)],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Placeholder for Chapter Illustration
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            AppTheme.primaryColor,
                          ],
                        ),
                      ),
                      child: Icon(
                        widget.subject.icon as IconData,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    // If subject has specific content illustration, we could show it here
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: AppTheme.secondaryColor,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                  unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
                  overlayColor: WidgetStateProperty.all(Colors.white10),
                  tabs: widget.subject.chapters.map((chapter) => Tab(text: chapter.title)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: widget.subject.chapters.map((chapter) => _buildLessonList(chapter)).toList(),
        ),
      ),
    );
  }

  Widget _buildLessonList(CourseChapter chapter) {
    if (chapter.subChapters.isEmpty) {
      return Center(
        child: Text(
          "Aucune leçon disponible pour ce chapitre.",
          style: GoogleFonts.inter(color: Colors.white38),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: chapter.subChapters.length,
      itemBuilder: (context, index) {
        final sub = chapter.subChapters[index];
        return _buildLessonButton(sub, chapter, index);
      },
    );
  }

  Widget _buildLessonButton(CourseSubChapter sub, CourseChapter chapter, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseContentScreen(
                subChapter: sub,
                subjectColor: AppTheme.secondaryColor,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: AppTheme.primaryColor,
          elevation: 4,
          shadowColor: Colors.black45,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                sub.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.2, end: 0);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
