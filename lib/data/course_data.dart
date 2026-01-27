import 'package:flutter/material.dart';
import '../models/course_models.dart';

class CourseData {
  static final List<CourseSubject> subjects = [
    CourseSubject(
      id: 'math',
      name: 'Mathématiques',
      icon: Icons.functions_rounded,
      color: Colors.blue,
      chapters: [
        CourseChapter(
          id: 'math_c1',
          title: 'Géométrie : Aires et Volumes',
          description: 'Calcul des surfaces et volumes des figures usuelles.',
          imageAsset: 'assets/images/geometry_shapes.png',
          subChapters: [
            CourseSubChapter(
              id: 'math_c1_s1',
              title: 'Les Aires',
              sections: [
                CourseSection(
                  id: 's1',
                  type: CourseSectionType.text,
                  title: 'Introduction',
                  content: 'L\'aire d\'une figure est la mesure de sa surface intérieure. Elle s\'exprime en unités carrées (cm², m², etc.).',
                  isEssential: true,
                ),
                CourseSection(
                  id: 's2',
                  type: CourseSectionType.formula,
                  title: 'Carré',
                  content: 'A = c × c = c²',
                  subContent: 'Où c est la longueur d\'un côté.',
                  isEssential: true,
                ),
                CourseSection(
                  id: 's3',
                  type: CourseSectionType.example,
                  title: 'Exemple Carré',
                  content: 'Si un côté c = 4cm, alors A = 4 × 4 = 16 cm².',
                ),
                CourseSection(
                  id: 's4',
                  type: CourseSectionType.formula,
                  title: 'Rectangle',
                  content: 'A = L × l',
                  subContent: 'L = Longueur, l = largeur',
                  isEssential: true,
                ),
                CourseSection(
                  id: 's5',
                  type: CourseSectionType.tip,
                  title: 'Astuce',
                  content: 'Ne confondez pas Aire et Périmètre ! Le périmètre est le contour, l\'aire est la surface.',
                ),
                 CourseSection(
                  id: 's6',
                  type: CourseSectionType.exercise,
                  title: 'Exercice Rapide',
                  content: 'Calculez l\'aire d\'un rectangle de 5m sur 3m.',
                  subContent: 'Réponse: 15 m²',
                ),
              ],
            ),
            CourseSubChapter(
              id: 'math_c1_s2',
              title: 'Les Volumes',
              sections: [
                CourseSection(
                  id: 's7',
                  type: CourseSectionType.text,
                  content: 'Le volume mesure l\'espace occupé par un objet 3D.',
                ),
                CourseSection(
                  id: 's8',
                  type: CourseSectionType.formula,
                  title: 'Cube',
                  content: 'V = c³',
                  isEssential: true,
                ),
              ],
            ),
          ],
        ),
        CourseChapter(
          id: 'math_c2',
          title: 'Algèbre : Équations',
          description: 'Résolution d\'équations du premier degré.',
          imageAsset: 'assets/images/algebra_eq.png',
          subChapters: [],
        ),
      ],
    ),
    CourseSubject(
      id: 'phys',
      name: 'Physique',
      icon: Icons.flash_on_rounded,
      color: Colors.orange,
      chapters: [
        CourseChapter(
          id: 'phys_c1',
          title: 'Mécanique',
          description: 'Mouvement et vitesse',
          imageAsset: 'assets/images/mechanics.png',
          subChapters: [
            CourseSubChapter(
              id: 'phys_c1_s1',
              title: 'La Vitesse',
              sections: [
                CourseSection(
                  id: 'p1',
                  type: CourseSectionType.formula,
                  title: 'Vitesse Moyenne',
                  content: 'v = d / t',
                  subContent: 'd en mètres (m), t en secondes (s), v en m/s',
                  isEssential: true,
                ),
                CourseSection(
                  id: 'p2',
                  type: CourseSectionType.method,
                  title: 'Calculer une distance',
                  content: '1. Identifier la vitesse (v) et le temps (t).\n2. Appliquer la formule d = v × t.\n3. Vérifier les unités.',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
     CourseSubject(
      id: 'fr',
      name: 'Français',
      icon: Icons.menu_book_rounded,
      color: Colors.red,
      chapters: [],
    ),
  ];
}
