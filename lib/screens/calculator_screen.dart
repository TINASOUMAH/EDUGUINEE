import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';

class CalculatorScreen extends StatefulWidget {
  final String className;
  const CalculatorScreen({super.key, required this.className});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _equation = "0";
  String _result = "0";
  int _activeModeIndex = 0;
  
  late List<String> _modes;

  @override
  void initState() {
    super.initState();
    _modes = (widget.className.contains('10') || widget.className.contains('Terminale'))
      ? ["Scientifique", "Équation", "Développement", "Factorisation"]
      : ["Basique", "Équation"];
  }

  // Colors for the new professional design
  final Color _bgGradientStart = const Color(0xFF0F172A);
  final Color _bgGradientEnd = const Color(0xFF1E293B);
  final Color _displayBg = Colors.white;
  final Color _accentYellow = const Color(0xFFFACC15);

  void _onPress(String text) {
    setState(() {
      if (text == "C") {
        _equation = "0";
        _result = "0";
      } else if (text == "⌫") {
        _equation = _equation.length > 1 ? _equation.substring(0, _equation.length - 1) : "0";
      } else if (text == "Résoudre" || text == "=") {
        _calculate();
      } else if (["sin", "cos", "tan", "√"].contains(text)) {
        _equation = _equation == "0" ? "$text(" : _equation + "$text(";
      } else {
        _equation = _equation == "0" ? text : _equation + text;
      }
    });
  }

  void _calculate() {
    try {
      String expStr = _equation
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('y', '^')
        .replaceAll('x', '*')
        .replaceAll('√', 'sqrt')
        .replaceAll('sin', 'sin')
        .replaceAll('cos', 'cos')
        .replaceAll('tan', 'tan');
        
      Parser p = Parser();
      Expression exp = p.parse(expStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _result = eval.toStringAsFixed(eval == eval.toInt() ? 0 : 4);
    } catch (e) {
      _result = "Erreur";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGradientStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'EDUGUINÉE', 
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_bgGradientStart, _bgGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Mode Tabs (Modern pill design)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: _modes.asMap().entries.map((e) {
                    bool isSelected = _activeModeIndex == e.key;
                    return GestureDetector(
                      onTap: () => setState(() => _activeModeIndex = e.key),
                      child: AnimatedContainer(
                        duration: 300.ms,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? _accentYellow : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          e.value,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? _bgGradientStart : Colors.white70,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            // Display Area (Redesigned to avoid overflow and look premium)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _displayBg,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        _equation,
                        style: GoogleFonts.inter(fontSize: 22, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _result,
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _bgGradientStart,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.2),
            ),
            
            const SizedBox(height: 24),
            
            // Keyboard Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    if (widget.className.contains('10') || widget.className.contains('Terminale')) ...[
                      _buildKeyRow(["C", "sin", "cos", "tan"], type: 'func'),
                      _buildKeyRow(["√", "xʸ", "(", ")"], type: 'func'),
                      _buildKeyRow(["x", "y", ",", "⌫"], type: 'func'),
                    ] else ...[
                      _buildKeyRow(["C", "⌫", "(", ")"], type: 'func'),
                      _buildKeyRow(["x", "y", ",", "xʸ"], type: 'func'),
                    ],
                    _buildKeyRow(["7", "8", "9", "÷"], type: 'num'),
                    _buildKeyRow(["4", "5", "6", "×"], type: 'num'),
                    _buildKeyRow(["1", "2", "3", "-"], type: 'num'),
                    _buildLastRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyRow(List<String> keys, {required String type}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: keys.map((key) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _buildButton(key, type),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLastRow() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _buildButton("Résoudre", 'special'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _buildButton("0", 'num'),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _buildButton("+", 'op'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, String type) {
    bool isOp = ["÷", "×", "-", "+"].contains(text);
    Color bgColor;
    Color textColor;

    switch (type) {
      case 'num':
        bgColor = Colors.white.withOpacity(0.1);
        textColor = Colors.white;
        break;
      case 'func':
        bgColor = Colors.white.withOpacity(0.05);
        textColor = _accentYellow;
        break;
      case 'op':
        bgColor = _accentYellow.withOpacity(0.1);
        textColor = _accentYellow;
        break;
      case 'special':
        bgColor = _accentYellow;
        textColor = _bgGradientStart;
        break;
      default:
        bgColor = Colors.white.withOpacity(0.1);
        textColor = Colors.white;
    }

    if (isOp) {
      bgColor = Colors.white.withOpacity(0.05);
      textColor = _accentYellow;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (type == 'special')
          BoxShadow(
            color: _accentYellow.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onPress(text == "xʸ" ? "y" : text),
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: text == "⌫" 
              ? Icon(Icons.backspace_rounded, color: textColor, size: 22)
              : Text(
                  text, 
                  style: GoogleFonts.poppins(
                    fontSize: text == "Résoudre" ? 18 : 24, 
                    fontWeight: FontWeight.bold, 
                    color: textColor
                  )
                ),
          ),
        ),
      ),
    );
  }
}
