import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> with SingleTickerProviderStateMixin {
  int _activeTabIndex = 0; 
  final PageController _pageController = PageController();
  
  final List<String> _days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
  int _selectedDayIndex = 0;
  
  final List<String> _months = [
    'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          _buildEduHeader(context),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _activeTabIndex = index),
              children: [
                _buildProgrammesView(),
                _buildTasksView(),
                _buildObjectivesView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildCustomFAB(),
    );
  }

  Widget _buildEduHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.secondaryColor),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'EDUGUINÉE', 
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mes résolutions',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Planifie tes succès, un pas après l\'autre.',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildCustomTab(0, "Programmes", Icons.menu_book_rounded),
                _buildCustomTab(1, "Tâches", Icons.check_circle_outline_rounded),
                _buildCustomTab(2, "Objectifs", Icons.flag_rounded),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: -0.2, duration: 400.ms);
  }

  Widget _buildCustomTab(int index, String label, IconData icon) {
    bool isSelected = _activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(index, duration: 400.ms, curve: Curves.easeInOut);
      },
      child: AnimatedContainer(
        duration: 300.ms,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.secondaryColor : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (isSelected) 
              BoxShadow(color: AppTheme.secondaryColor.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.black : Colors.white70),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgrammesView() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionHeader("Mes Objectifs"),
        const SizedBox(height: 16),
        _buildSectionHeader("Toutes mes tâches"),
        const SizedBox(height: 25),
        _buildRevisionCard("Mathématiques", "Algèbre & Géométrie", "08:00", Colors.blue),
        _buildRevisionCard("Français", "Analyse Littéraire", "10:30", Colors.purple),
        _buildRevisionCard("Physique", "Mécanique du point", "14:00", Colors.orange),
      ],
    ).animate().fadeIn();
  }

  Widget _buildRevisionCard(String title, String sub, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 6, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textMain)),
                            Text(sub, style: GoogleFonts.inter(color: AppTheme.textSub, fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: Text(time, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksView() {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Février 2026', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                    _buildAddBtn("Ajouter une tâche", _showTaskForm),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 85,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedDayIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDayIndex = index),
                        child: AnimatedContainer(
                          duration: 300.ms,
                          width: 70,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected ? null : Border.all(color: Colors.grey.withOpacity(0.1)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_days[index], style: TextStyle(color: isSelected ? Colors.white70 : AppTheme.textSub, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text('${22 + index}', style: TextStyle(color: isSelected ? Colors.white : AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: Center(child: Text("Aucune tâche prévue pour ce jour."))),
        ],
      ),
    );
  }

  Widget _buildObjectivesView() {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Objectifs 2026', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                    _buildAddBtn("Ajouter un objectif", _showObjectiveForm),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      bool isSelected = index == 1; // Février
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey.withOpacity(0.2)),
                        ),
                        child: Text(_months[index], style: TextStyle(color: isSelected ? Colors.white : AppTheme.textMain, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: Center(child: Text("Lancez-vous des défis !"))),
        ],
      ),
    );
  }

  Widget _buildAddBtn(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
      ],
    );
  }

  void _showObjectiveForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFormSheet("Nouvel Objectif"),
    );
  }

  void _showTaskForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFormSheet("Nouvelle Tâche"),
    );
  }

  Widget _buildFormSheet(String title) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 25),
                    _buildFieldLabel("Titre de l'action"),
                    _buildTextField("Ex: Réviser la géométrie"),
                    const SizedBox(height: 25),
                    _buildFieldLabel("Période / Mois"),
                    _buildMonthGrid(),
                    const SizedBox(height: 25),
                    _buildFieldLabel("Description détaillée"),
                    _buildTextField("Notes importantes...", maxLines: 3, isNote: true),
                    const SizedBox(height: 25),
                    _buildFieldLabel("Catégorie"),
                    Row(
                      children: [
                        _buildChip("Scolaire", true),
                        const SizedBox(width: 10),
                        _buildChip("Perso", false),
                        const SizedBox(width: 10),
                        _buildChip("Autre", false),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                        ),
                        child: const Text("ENREGISTRER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textMain)),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1, bool isNote = false}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: isNote ? const Color(0xFFFEF9C3) : const Color(0xFFF1F5F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildMonthGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: 12,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index == 1 ? AppTheme.secondaryColor : AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(_months[index].substring(0, 3), style: TextStyle(color: index == 1 ? Colors.black : AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 11)),
      ),
    );
  }

  Widget _buildChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: active ? AppTheme.primaryColor : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: active ? Colors.white : AppTheme.textMain, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }

  Widget _buildCustomFAB() {
    return FloatingActionButton(
      onPressed: _activeTabIndex == 1 ? _showTaskForm : _showObjectiveForm,
      backgroundColor: AppTheme.secondaryColor,
      child: const Icon(Icons.add_rounded, color: Colors.black, size: 30),
    ).animate().scale();
  }
}
