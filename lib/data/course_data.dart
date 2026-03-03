import 'package:flutter/material.dart';
import '../models/course_models.dart';

class CourseData {
  static List<CourseSubject> getSubjectsForClass(String className, {String? option}) {
    if (className.contains('6ème')) {
      return _get6emeSubjects();
    } else if (className.contains('10ème')) {
      return _get10emeSubjects();
    } else if (className.contains('Terminale')) {
      if (option == 'TSM') return _getTSMSubjects();
      if (option == 'TEM' || option == 'TSE') return _getTEMSubjects();
      if (option == 'TSS') return _getTSSSubjects();
      return _getTSMSubjects(); // Default
    } else {
      return _get6emeSubjects(); // Default to 6ème
    }
  }

  static List<CourseSubject> _get6emeSubjects() {
    return [
      CourseSubject(
        id: '6_fr',
        name: 'Français',
        description: 'Lecture, grammaire, orthographe et conjugaison.',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF4A90E2),
        chapters: [
          CourseChapter(
            id: '6_fr_gram',
            title: 'Grammaire',
            description: 'Étude des phrases et des classes de mots.',
            subChapters: [
              CourseSubChapter(
                id: '6_fr_gram_s1', 
                title: 'La phrase (types et formes)', 
                sections: [
                  CourseSection(
                    id: '6_fr_gram_s1_t1',
                    type: CourseSectionType.text,
                    title: 'Définition',
                    content: 'Une phrase est une suite de mots qui a un sens. Elle commence par une majuscule et se termine par un point.',
                  ),
                  CourseSection(
                    id: '6_fr_gram_s1_t2',
                    type: CourseSectionType.method,
                    title: 'Les 4 types de phrases',
                    content: '1. Déclarative (donne une information)\n2. Interrogative (pose une question)\n3. Exclamative (exprime un sentiment)\n4. Impérative (donne un ordre).',
                  ),
                  CourseSection(
                    id: '6_fr_gram_s1_ex1',
                    type: CourseSectionType.exercise,
                    title: 'À ton tour !',
                    content: 'Transforme cette phrase déclarative en phrase interrogative : "Il pleut."',
                    subContent: 'Réponse : Pleut-il ? ou Est-ce qu\'il pleut ?',
                  ),
                ],
              ),
              CourseSubChapter(id: '6_fr_gram_s2', title: 'Les classes de mots (nature)', sections: [
                 CourseSection(
                    id: '6_fr_gram_s2_t1',
                    type: CourseSectionType.text,
                    title: 'Les mots variables',
                    content: 'Le nom, le déterminant, l\'adjectif, le pronom et le verbe.',
                  ),
              ]),
              CourseSubChapter(id: '6_fr_gram_s3', title: 'Les fonctions grammaticales', sections: []),
              CourseSubChapter(id: '6_fr_gram_s4', title: 'La phrase complexe', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_fr_conj',
            title: 'Conjugaison',
            description: 'Verbes et temps de l\'indicatif.',
            subChapters: [
              CourseSubChapter(
                id: '6_fr_conj_s1', 
                title: 'Le verbe et ses groupes', 
                sections: [
                  CourseSection(
                    id: '6_fr_conj_s1_t1',
                    type: CourseSectionType.text,
                    content: 'Le verbe est le noyau de la phrase. Il exprime une action ou un état.',
                  ),
                  CourseSection(
                    id: '6_fr_conj_s1_m1',
                    type: CourseSectionType.method,
                    title: 'Les trois groupes',
                    content: '- 1er groupe : en -er (sauf aller)\n- 2ème groupe : en -ir (finissant en -issant)\n- 3ème groupe : tous les autres.',
                  ),
                ]
              ),
              CourseSubChapter(id: '6_fr_conj_s2', title: 'Le présent de l\'indicatif', sections: []),
              CourseSubChapter(id: '6_fr_conj_s3', title: 'L\'imparfait et le passé simple', sections: []),
              CourseSubChapter(id: '6_fr_conj_s4', title: 'Le futur simple', sections: []),
              CourseSubChapter(id: '6_fr_conj_s5', title: 'Les temps composés', sections: []),
              CourseSubChapter(id: '6_fr_conj_s6', title: 'Impératif et conditionnel présent', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_fr_orth',
            title: 'Orthographe',
            description: 'Règles d\'accord et homophones.',
            subChapters: [
              CourseSubChapter(id: '6_fr_orth_s1', title: 'L\'accord dans le groupe nominal', sections: []),
              CourseSubChapter(id: '6_fr_orth_s2', title: 'L\'accord sujet-verbe', sections: []),
              CourseSubChapter(id: '6_fr_orth_s3', title: 'L\'accord du participe passé', sections: []),
              CourseSubChapter(id: '6_fr_orth_s4', title: 'Les homophones grammaticaux', sections: []),
            ],
          ),
           CourseChapter(
            id: '6_fr_vocab',
            title: 'Vocabulaire',
            description: 'Enrichissement du lexique.',
            subChapters: [
              CourseSubChapter(id: '6_fr_vocab_s1', title: 'Synonymes et antonymes', sections: []),
              CourseSubChapter(id: '6_fr_vocab_s2', title: 'Les familles de mots', sections: []),
              CourseSubChapter(id: '6_fr_vocab_s3', title: 'Polysémie et sens figuré', sections: []),
              CourseSubChapter(id: '6_fr_vocab_s4', title: 'Préfixes et suffixes', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_fr_exp',
            title: 'Expression Écrite',
            description: 'Rédaction et types de textes.',
            subChapters: [
              CourseSubChapter(id: '6_fr_exp_s1', title: 'Le texte narratif', sections: []),
              CourseSubChapter(id: '6_fr_exp_s2', title: 'Le texte descriptif', sections: []),
              CourseSubChapter(id: '6_fr_exp_s3', title: 'La lettre', sections: []),
              CourseSubChapter(id: '6_fr_exp_s4', title: 'Le compte-rendu', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '6_calcul',
        name: 'Calcul',
        description: 'Opérations, problèmes et géométrie de base.',
        icon: Icons.calculate_rounded,
        color: const Color(0xFF6366F1),
        chapters: [
          CourseChapter(
            id: '6_calc_num',
            title: 'Nombres et Calculs',
            description: 'Opérations sur les nombres entiers et décimaux.',
            subChapters: [
              CourseSubChapter(id: '6_calc_num_s1', title: 'Les nombres entiers et décimaux', sections: []),
              CourseSubChapter(id: '6_calc_num_s2', title: 'Addition et Soustraction', sections: []),
              CourseSubChapter(id: '6_calc_num_s3', title: 'Multiplication et Division', sections: []),
              CourseSubChapter(id: '6_calc_num_s4', title: 'Les Fractions', sections: []),
              CourseSubChapter(id: '6_calc_num_s5', title: 'Divisibilité et Multiples', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_calc_mes',
            title: 'Mesures et Grandeurs',
            description: 'Conversions et calculs de mesures.',
            subChapters: [
              CourseSubChapter(id: '6_calc_mes_s1', title: 'Longueurs, Masses et Capacités', sections: []),
              CourseSubChapter(id: '6_calc_mes_s2', title: 'Aires et Périmètres', sections: []),
              CourseSubChapter(id: '6_calc_mes_s3', title: 'Mesures du temps (Durées)', sections: []),
              CourseSubChapter(id: '6_calc_mes_s4', title: 'Volumes', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_calc_geom',
            title: 'Géométrie',
            description: 'Figures géométriques et espace.',
            subChapters: [
              CourseSubChapter(id: '6_calc_geom_s1', title: 'Droites et Angles', sections: []),
              CourseSubChapter(id: '6_calc_geom_s2', title: 'Les Triangles et Quadrilatères', sections: []),
              CourseSubChapter(id: '6_calc_geom_s3', title: 'Le Cercle', sections: []),
              CourseSubChapter(id: '6_calc_geom_s4', title: 'Symétrie et Solides', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_calc_prob',
            title: 'Problèmes et Données',
            description: 'Proportionnalité et résolution de problèmes.',
            subChapters: [
              CourseSubChapter(id: '6_calc_prob_s1', title: 'La Proportionnalité', sections: []),
              CourseSubChapter(id: '6_calc_prob_s2', title: 'Règle de trois et Pourcentages', sections: []),
              CourseSubChapter(id: '6_calc_prob_s3', title: 'Organisation de données', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '6_hist',
        name: 'Histoire',
        description: 'Préhistoire, grands empires et histoire de la Guinée.',
        icon: Icons.history_edu_rounded,
        color: const Color(0xFFF5A623),
        chapters: [
          CourseChapter(
            id: '6_hist_pre',
            title: 'Introduction et Préhistoire',
            description: 'Les origines de l\'humanité.',
            subChapters: [
              CourseSubChapter(id: '6_hist_pre_s1', title: 'L\'échelle du temps', sections: []),
              CourseSubChapter(id: '6_hist_pre_s2', title: 'La Préhistoire Africaine', sections: []),
              CourseSubChapter(id: '6_hist_pre_s3', title: 'Sites préhistoriques en Guinée', sections: []),
              CourseSubChapter(id: '6_hist_pre_s4', title: 'L\'invention de l\'écriture et du fer', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_hist_emp',
            title: 'Les Grands Empires Ouest-Africains',
            description: 'Ghana, Mali, Songhaï et autres royaumes.',
            subChapters: [
              CourseSubChapter(id: '6_hist_emp_s1', title: 'L\'Empire du Ghana', sections: []),
              CourseSubChapter(id: '6_hist_emp_s2', title: 'Le Royaume Sosso', sections: []),
              CourseSubChapter(id: '6_hist_emp_s3', title: 'L\'Empire du Mali', sections: []),
              CourseSubChapter(id: '6_hist_emp_s4', title: 'L\'Empire Songhaï', sections: []),
              CourseSubChapter(id: '6_hist_emp_s5', title: 'Les Royaumes Mossi et Haoussa', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_hist_contact',
            title: 'Contacts et Échanges',
            description: 'Royaumes Bantous et premiers contacts.',
            subChapters: [
              CourseSubChapter(id: '6_hist_cont_s1', title: 'Le Royaume du Congo', sections: []),
              CourseSubChapter(id: '6_hist_cont_s2', title: 'Les Royaumes du Golfe de Guinée', sections: []),
              CourseSubChapter(id: '6_hist_cont_s3', title: 'Contacts Transsahariens et Afrique-Asie', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_hist_col',
            title: 'La Période Coloniale',
            description: 'De la conquête aux résistances.',
            subChapters: [
              CourseSubChapter(id: '6_hist_col_s1', title: 'Les grandes découvertes et la Traite', sections: []),
              CourseSubChapter(id: '6_hist_col_s2', title: 'La pénétration coloniale en Guinée', sections: []),
              CourseSubChapter(id: '6_hist_col_s3', title: 'Samory Touré et les résistances', sections: []),
              CourseSubChapter(id: '6_hist_col_s4', title: 'La colonisation française', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_hist_contemp',
            title: 'Vers l\'Indépendance',
            description: 'Le chemin vers la liberté.',
            subChapters: [
              CourseSubChapter(id: '6_hist_cont_s1', title: 'Les Guerres Mondiales (14-18 & 39-45)', sections: []),
              CourseSubChapter(id: '6_hist_cont_s2', title: 'Lutte pour l\'indépendance de la Guinée', sections: []),
              CourseSubChapter(id: '6_hist_cont_s3', title: 'Le 2 Octobre 1958', sections: []),
              CourseSubChapter(id: '6_hist_cont_s4', title: 'L\'OUA et l\'ONU', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '6_geo',
        name: 'Géographie',
        description: 'La Terre et les régions naturelles de la Guinée.',
        icon: Icons.public_rounded,
        color: const Color(0xFF7ED321),
        chapters: [
          CourseChapter(
            id: '6_geo_gen',
            title: 'Géographie Générale',
            description: 'La Terre dans l\'univers.',
            subChapters: [
              CourseSubChapter(id: '6_geo_gen_s1', title: 'La Terre et le Système Solaire', sections: []),
              CourseSubChapter(id: '6_geo_gen_s2', title: 'Les Mouvements de la Terre', sections: []),
              CourseSubChapter(id: '6_geo_gen_s3', title: 'Les Zones Climatiques', sections: []),
              CourseSubChapter(id: '6_geo_gen_s4', title: 'Représentation de la Terre (Cartes)', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_geo_gui_phys',
            title: 'La Guinée Physique',
            description: 'Relief, climat et hydrographie.',
            subChapters: [
              CourseSubChapter(id: '6_geo_gui_phys_s1', title: 'Situation et Limites', sections: []),
              CourseSubChapter(id: '6_geo_gui_phys_s2', title: 'Les 4 Régions Naturelles', sections: []),
              CourseSubChapter(id: '6_geo_gui_phys_s3', title: 'Le Relief et les Cours d\'eau', sections: []),
              CourseSubChapter(id: '6_geo_gui_phys_s4', title: 'Climat et Végétation', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_geo_gui_hum',
            title: 'La Guinée Humaine et Économique',
            description: 'Population et activités.',
            subChapters: [
              CourseSubChapter(id: '6_geo_gui_hum_s1', title: 'Population et Villes principales', sections: []),
              CourseSubChapter(id: '6_geo_gui_hum_s2', title: 'Agriculture, Élevage et Pêche', sections: []),
              CourseSubChapter(id: '6_geo_gui_hum_s3', title: 'Mines et Industries', sections: []),
              CourseSubChapter(id: '6_geo_gui_hum_s4', title: 'Transports et Commerce', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_geo_afr',
            title: 'L\'Afrique et le Monde',
            description: 'Le continent africain.',
            subChapters: [
              CourseSubChapter(id: '6_geo_afr_s1', title: 'Généralités sur l\'Afrique', sections: []),
              CourseSubChapter(id: '6_geo_afr_s2', title: 'Relief et Climats en Afrique', sections: []),
              CourseSubChapter(id: '6_geo_afr_s3', title: 'Population Africaine', sections: []),
              CourseSubChapter(id: '6_geo_afr_s4', title: 'La coopération internationale', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '6_science',
        name: "Sciences d'observation",
        description: 'Étude du corps humain, des plantes et des animaux.',
        icon: Icons.biotech_rounded,
        color: const Color(0xFF06B6D4),
        chapters: [
          CourseChapter(
            id: '6_sci_corps',
            title: 'Le Corps Humain et Santé',
            description: 'Fonctionnement et hygiène.',
            subChapters: [
              CourseSubChapter(id: '6_sci_corps_s1', title: 'Le Squelette et les Muscles', sections: []),
              CourseSubChapter(id: '6_sci_corps_s2', title: 'La Digestion et l\'Appareil Digestif', sections: []),
              CourseSubChapter(id: '6_sci_corps_s3', title: 'La Respiration et l\'Appareil Respiratoire', sections: []),
              CourseSubChapter(id: '6_sci_corps_s4', title: 'La Circulation Sanguine', sections: []),
              CourseSubChapter(id: '6_sci_corps_s5', title: 'Le Système Nerveux et les Sens', sections: []),
              CourseSubChapter(id: '6_sci_corps_s6', title: 'La Peau et l\'Excrétion', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_sci_maladies',
            title: 'Maladies et Hygiène',
            description: 'Prévention et soins.',
            subChapters: [
              CourseSubChapter(id: '6_sci_mal_s1', title: 'Les Microbes et l\'Hygiène', sections: []),
              CourseSubChapter(id: '6_sci_mal_s2', title: 'Paludisme, Choléra et Rage', sections: []),
              CourseSubChapter(id: '6_sci_mal_s3', title: 'MST et SIDA', sections: []),
              CourseSubChapter(id: '6_sci_mal_s4', title: 'Méfaits de l\'Alcool, Tabac et Drogues', sections: []),
              CourseSubChapter(id: '6_sci_mal_s5', title: 'Vaccins et Sérums', sections: []),
              CourseSubChapter(id: '6_sci_mal_s6', title: 'Secourisme (Noyade, Asphyxie)', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_sci_vivant',
            title: 'Le Monde Vivant et l\'Environnement',
            description: 'Plantes, animaux et écologie.',
            subChapters: [
              CourseSubChapter(id: '6_sci_viv_s1', title: 'Les Plantes (Riz, Manioc, Tomate)', sections: []),
              CourseSubChapter(id: '6_sci_viv_s2', title: 'La Reproduction des Plantes (Greffage)', sections: []),
              CourseSubChapter(id: '6_sci_viv_s3', title: 'L\'Élevage (La Poule)', sections: []),
              CourseSubChapter(id: '6_sci_viv_s4', title: 'L\'Écosystème et l\'Environnement', sections: []),
              CourseSubChapter(id: '6_sci_viv_s5', title: 'Pollution et Protection de la Nature', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_sci_matiere',
            title: 'Matière et Énergie',
            description: 'Physique et technologie.',
            subChapters: [
              CourseSubChapter(id: '6_sci_mat_s1', title: 'États de la Matière (Solide, Liquide, Gazeux)', sections: []),
              CourseSubChapter(id: '6_sci_mat_s2', title: 'Métaux (Or, Aluminium)', sections: []),
              CourseSubChapter(id: '6_sci_mat_s3', title: 'L\'Eau et l\'Air', sections: []),
              CourseSubChapter(id: '6_sci_mat_s4', title: 'Électricité et Sources d\'Énergie', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '6_ecm',
        name: "Éducation Civique et Morale",
        description: 'Valeurs, droits et institutions de la République.',
        icon: Icons.people_rounded,
        color: const Color(0xFFEF4444),
        chapters: [
          CourseChapter(
            id: '6_ecm_sociale',
            title: 'Vie Sociale et Morale',
            description: 'Vivre ensemble et valeurs.',
            subChapters: [
              CourseSubChapter(id: '6_ecm_soc_s1', title: 'Le Mariage et la Famille', sections: []),
              CourseSubChapter(id: '6_ecm_soc_s2', title: 'Le Cousinage à plaisanterie', sections: []),
              CourseSubChapter(id: '6_ecm_soc_s3', title: 'Respect de soi et d\'autrui', sections: []),
              CourseSubChapter(id: '6_ecm_soc_s4', title: 'L\'Unité Nationale et la Paix', sections: []),
              CourseSubChapter(id: '6_ecm_soc_s5', title: 'Droits et Devoirs du Citoyen', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_ecm_env',
            title: 'Hygiène et Environnement',
            description: 'Santé et protection de la nature.',
            subChapters: [
              CourseSubChapter(id: '6_ecm_env_s1', title: 'Hygiène du corps et alimentaire', sections: []),
              CourseSubChapter(id: '6_ecm_env_s2', title: 'Hygiène du milieu (École, Habitat)', sections: []),
              CourseSubChapter(id: '6_ecm_env_s3', title: 'Protection de l\'environnement', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_ecm_nation',
            title: 'La Nation et ses Symboles',
            description: 'Patriotisme et identité.',
            subChapters: [
              CourseSubChapter(id: '6_ecm_nat_s1', title: 'L\'Indépendance et l\'Histoire', sections: []),
              CourseSubChapter(id: '6_ecm_nat_s2', title: 'Le Drapeau et la Devise', sections: []),
              CourseSubChapter(id: '6_ecm_nat_s3', title: 'L\'Hymne National', sections: []),
              CourseSubChapter(id: '6_ecm_nat_s4', title: 'Le Patriotisme', sections: []),
              CourseSubChapter(id: '6_ecm_nat_s5', title: 'L\'Armée et la Sécurité', sections: []),
            ],
          ),
          CourseChapter(
            id: '6_ecm_inst',
            title: 'Les Institutions de la République',
            description: 'Organisation de l\'État.',
            subChapters: [
              CourseSubChapter(id: '6_ecm_inst_s1', title: 'La Constitution (Loi Fondamentale)', sections: []),
              CourseSubChapter(id: '6_ecm_inst_s2', title: 'Administration Locale (Quartier, Commune, Préfecture)', sections: []),
              CourseSubChapter(id: '6_ecm_inst_s3', title: 'Le Gouvernement et l\'Assemblée Nationale', sections: []),
              CourseSubChapter(id: '6_ecm_inst_s4', title: 'La Justice', sections: []),
              CourseSubChapter(id: '6_ecm_inst_s5', title: 'Institutions Internationales (UA, ONU)', sections: []),
            ],
          ),
        ],
      ),
    ];
  }

  static List<CourseSubject> _get10emeSubjects() {
    return [
      CourseSubject(
        id: '10_fr',
        name: 'Français',
        description: 'Littérature africaine, grammaire et expression écrite.',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF4A90E2),
        chapters: [
          CourseChapter(
            id: '10_fr_lit',
            title: 'Littérature Africaine',
            description: 'Étude des auteurs et courants littéraires.',
            subChapters: [
              CourseSubChapter(
                id: '10_fr_lit_s1', 
                title: 'L\'Enfant Noir (Camara Laye)', 
                sections: [
                   CourseSection(
                    id: '10_fr_lit_s1_t1',
                    type: CourseSectionType.text,
                    title: 'Présentation de l\'œuvre',
                    content: 'L\'Enfant Noir est un roman autobiographique de l\'écrivain guinéen Camara Laye, publié en 1953. Il raconte l\'enfance de l\'auteur à Kouroussa.',
                  ),
                  CourseSection(
                    id: '10_fr_lit_s1_t2',
                    type: CourseSectionType.text,
                    title: 'Thèmes principaux',
                    content: '1. Le respect des traditions\n2. L\'exil et la nostalgie\n3. Le passage de l\'enfance à l\'âge adulte\n4. Le rôle de la forge et du totem (le petit serpent noir).',
                  ),
                  CourseSection(
                    id: '10_fr_lit_s1_m1',
                    type: CourseSectionType.method,
                    title: 'Analyse du titre',
                    content: 'Le titre met en avant l\'identité africaine ("Noir") et l\'universalité du sentiment d\'appartenance à un foyer ("L\'Enfant").',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_fr_lit_s2', title: 'Sous l\'orage (Seydou Badian)', sections: []),
              CourseSubChapter(id: '10_fr_lit_s3', title: 'Ville Cruelle (Eza Boto)', sections: []),
              CourseSubChapter(id: '10_fr_lit_s4', title: 'La Poésie (Négritude)', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_fr_gram',
            title: 'Grammaire et Syntaxe',
            description: 'Analyses logiques et syntaxiques.',
            subChapters: [
              CourseSubChapter(
                id: '10_fr_gram_s1', 
                title: 'La proposition subordonnée', 
                sections: [
                  CourseSection(
                    id: '10_fr_gram_s1_t1',
                    type: CourseSectionType.text,
                    title: 'La proposition relative',
                    content: 'Elle est introduite par un pronom relatif (qui, que, quoi, dont, où...). Elle complète un nom appelé antécédent.',
                  ),
                ]
              ),
              CourseSubChapter(id: '10_fr_gram_s2', title: 'L\'expression du temps et de la cause', sections: []),
              CourseSubChapter(id: '10_fr_gram_s3', title: 'Styles direct et indirect', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_fr_exp',
            title: 'Expression Écrite',
            description: 'Méthodologie de la rédaction et dissertation.',
            subChapters: [
              CourseSubChapter(
                id: '10_fr_exp_s1', 
                title: 'La Dissertation', 
                sections: [
                  CourseSection(
                    id: '10_fr_exp_s1_m1',
                    type: CourseSectionType.method,
                    title: 'Structure de l\'introduction',
                    content: '1. Amener le sujet (contexte)\n2. Poser la problématique (question)\n3. Annoncer le plan.',
                  ),
                  CourseSection(
                    id: '10_fr_exp_s1_m2',
                    type: CourseSectionType.method,
                    title: 'Structure du développement',
                    content: 'Thèse (Arguments + Exemples) / Antithèse (Arguments + Exemples) / Synthèse.',
                  ),
                ],
              ),
              CourseSubChapter(
                id: '10_fr_exp_s2', 
                title: 'Le Commentaire de texte', 
                sections: [
                  CourseSection(
                    id: '10_fr_exp_s2_m1',
                    type: CourseSectionType.method,
                    title: 'Les étapes de l\'analyse',
                    content: '1. Repérer les figures de style\n2. Analyser les champs lexicaux\n3. Étudier la structure du texte.',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_maths',
        name: 'Mathématiques',
        description: 'Algèbre, géométrie vectorielle et analytique.',
        icon: Icons.functions_rounded,
        color: const Color(0xFF6366F1),
        chapters: [
          CourseChapter(
            id: '10_math_alg',
            title: 'Algèbre',
            description: 'Calcul littéral et équations.',
            subChapters: [
              CourseSubChapter(
                id: '10_math_alg_s1', 
                title: 'Racines carrées', 
                sections: [
                  CourseSection(
                    id: '10_math_alg_s1_t1',
                    type: CourseSectionType.text,
                    title: 'Définition',
                    content: 'La racine carrée d\'un nombre positif "a" est le nombre positif dont le carré est "a". On le note √a.',
                  ),
                  CourseSection(
                    id: '10_math_alg_s1_m1',
                    type: CourseSectionType.method,
                    title: 'Propriétés fondamentales',
                    content: '1. √a × √b = √(a × b)\n2. √(a/b) = √a / √b\n3. Attention : √(a + b) ≠ √a + √b !',
                  ),
                  CourseSection(
                    id: '10_math_alg_s1_ex1',
                    type: CourseSectionType.exercise,
                    title: 'Application',
                    content: 'Calcule √(16) + √(9) et compare avec √(16 + 9).',
                    subContent: 'Réponse : √(16)+√(9)=4+3=7. Or √(16+9)=√25=5. On voit bien que 7 ≠ 5.',
                  ),
                ]
              ),
              CourseSubChapter(
                id: '10_math_alg_s2', 
                title: 'Calcul littéral (Identités remarquables)', 
                sections: [
                  CourseSection(
                    id: '10_math_alg_s2_f1',
                    type: CourseSectionType.formula,
                    title: 'Carré d\'une somme',
                    content: '(a + b)² = a² + 2ab + b²',
                  ),
                  CourseSection(
                    id: '10_math_alg_s2_f2',
                    type: CourseSectionType.formula,
                    title: 'Carré d\'une différence',
                    content: '(a - b)² = a² - 2ab + b²',
                  ),
                  CourseSection(
                    id: '10_math_alg_s2_f3',
                    type: CourseSectionType.formula,
                    title: 'Produit d\'une somme par une différence',
                    content: '(a + b)(a - b) = a² - b²',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_math_alg_s3', title: 'Équations et Inéquations du 1er degré', sections: []),
              CourseSubChapter(id: '10_math_alg_s4', title: 'Systèmes d\'équations', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_math_geom',
            title: 'Géométrie',
            description: 'Vecteurs, Thalès, Pythagore et Trigonométrie.',
            subChapters: [
              CourseSubChapter(id: '10_math_geom_s1', title: 'Vecteurs et Translations', sections: []),
              CourseSubChapter(
                id: '10_math_geom_s2', 
                title: 'Théorème de Thalès', 
                sections: [
                  CourseSection(
                    id: '10_math_geom_s2_m1',
                    type: CourseSectionType.method,
                    title: 'Énoncé du théorème',
                    content: 'Si deux droites sont parallèles et coupées par deux sécantes, alors elles déterminent des segments proportionnels.',
                  ),
                  CourseSection(
                    id: '10_math_geom_s2_f1',
                    type: CourseSectionType.formula,
                    title: 'Égalité de rapports',
                    content: 'AM/AB = AN/AC = MN/BC',
                    subContent: 'Utilisé pour calculer des longueurs dans un triangle.',
                  ),
                ],
              ),
              CourseSubChapter(
                id: '10_math_geom_s3', 
                title: 'Théorème de Pythagore', 
                sections: [
                  CourseSection(
                    id: '10_math_geom_s3_f1',
                    type: CourseSectionType.formula,
                    title: 'Relation de Pythagore',
                    content: 'BC² = AB² + AC²',
                    subContent: 'Dans un triangle ABC rectangle en A.',
                  ),
                  CourseSection(
                    id: '10_math_geom_s3_m1',
                    type: CourseSectionType.method,
                    title: 'Calculer une longueur',
                    content: 'Pour trouver l\'hypoténuse, on additionne les carrés des autres côtés. Pour un côté de l\'angle droit, on soustrait.',
                  ),
                ],
              ),
              CourseSubChapter(
                id: '10_math_geom_s4', 
                title: 'Trigonométrie', 
                sections: [
                  CourseSection(
                    id: '10_math_geom_s4_f1',
                    type: CourseSectionType.formula,
                    title: 'Cosinus',
                    content: 'cos = Adj / Hyp',
                  ),
                  CourseSection(
                    id: '10_math_geom_s4_f2',
                    type: CourseSectionType.formula,
                    title: 'Sinus',
                    content: 'sin = Opp / Hyp',
                  ),
                  CourseSection(
                    id: '10_math_geom_s4_f3',
                    type: CourseSectionType.formula,
                    title: 'Tangente',
                    content: 'tan = Opp / Adj',
                  ),
                  CourseSection(
                    id: '10_math_geom_s4_m1',
                    type: CourseSectionType.method,
                    title: 'Moyen mnémotechnique',
                    content: 'SOH CAH TOA (Sin=Opp/Hyp, Cos=Adj/Hyp, Tan=Opp/Adj)',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_math_geom_s5', title: 'Géométrie analytique (Repère)', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_phys',
        name: 'Physique',
        description: 'Mécanique, optique et électricité.',
        icon: Icons.bolt_rounded,
        color: const Color(0xFFF59E0B),
        chapters: [
          CourseChapter(
            id: '10_phys_mec',
            title: 'Mécanique',
            description: 'Forces, équilibre et mouvement.',
            subChapters: [
              CourseSubChapter(
                id: '10_phys_mec_s1', 
                title: 'Poids et Masse', 
                sections: [
                  CourseSection(
                    id: '10_phys_mec_s1_f1',
                    type: CourseSectionType.formula,
                    title: 'Relation Poids-Masse',
                    content: 'P = m × g',
                    subContent: 'P en Newton (N), m en kg, g intensité de pesanteur (~9.8 N/kg).',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_phys_mec_s2', title: 'Équilibre d\'un solide', sections: []),
              CourseSubChapter(
                id: '10_phys_mec_s3', 
                title: 'Travail et Puissance', 
                sections: [
                  CourseSection(
                    id: '10_phys_mec_s3_f1',
                    type: CourseSectionType.formula,
                    title: 'Travail d\'une force',
                    content: 'W = F × d',
                    subContent: 'W en Joule (J), F en Newton (N), d en mètre (m).',
                  ),
                  CourseSection(
                    id: '10_phys_mec_s3_f2',
                    type: CourseSectionType.formula,
                    title: 'Puissance mécanique',
                    content: 'P = W / t',
                    subContent: 'P en Watt (W), t en seconde (s).',
                  ),
                ],
              ),
            ],
          ),
          CourseChapter(
            id: '10_phys_elec',
            title: 'Électricité',
            description: 'Courant, tension et puissance.',
            subChapters: [
              CourseSubChapter(
                id: '10_phys_elec_s1', 
                title: 'Loi d\'Ohm (Résistance)', 
                sections: [
                  CourseSection(
                    id: '10_phys_elec_s1_f1',
                    type: CourseSectionType.formula,
                    title: 'Loi d\'Ohm',
                    content: 'U = R × I',
                    subContent: 'U en Volt (V), R en Ohm (Ω), I en Ampère (A).',
                  ),
                ],
              ),
              CourseSubChapter(
                id: '10_phys_elec_s2', 
                title: 'Puissance électrique', 
                sections: [
                  CourseSection(
                    id: '10_phys_elec_s2_f1',
                    type: CourseSectionType.formula,
                    title: 'Puissance électrique',
                    content: 'P = U × I',
                  ),
                  CourseSection(
                    id: '10_phys_elec_s2_f2',
                    type: CourseSectionType.formula,
                    title: 'Énergie électrique',
                    content: 'E = P × t',
                    subContent: 'E en Joule (J) ou kWh.',
                  ),
                ],
              ),
            ],
          ),
          CourseChapter(
            id: '10_phys_opt',
            title: 'Optique',
            description: 'Lumière et lentilles.',
            subChapters: [
              CourseSubChapter(
                id: '10_phys_opt_s1', 
                title: 'Lentilles minces', 
                sections: [
                  CourseSection(
                    id: '10_phys_opt_s1_f1',
                    type: CourseSectionType.formula,
                    title: 'Vergence d\'une lentille',
                    content: 'C = 1 / f\'',
                    subContent: 'C en Dioptrie (δ), f\' distance focale en mètre (m).',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_phys_opt_s2', title: 'Construction d\'images', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_chim',
        name: 'Chimie',
        description: 'Matière, atomes et réactions chimiques.',
        icon: Icons.science_rounded,
        color: const Color(0xFF06B6D4),
        chapters: [
          CourseChapter(
            id: '10_chim_gen',
            title: 'Chimie Générale',
            description: 'Atomes, ions et molécules.',
            subChapters: [
              CourseSubChapter(
                id: '10_chim_gen_s1', 
                title: 'L\'atome et sa structure', 
                sections: [
                  CourseSection(
                    id: '10_chim_gen_s1_f1',
                    type: CourseSectionType.formula,
                    title: 'Nombre de masse',
                    content: 'A = Z + N',
                    subContent: 'A (nucléons), Z (protons), N (neutrons).',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_chim_gen_s2', title: 'Les ions et solutions ioniques', sections: []),
              CourseSubChapter(
                id: '10_chim_gen_s3', 
                title: 'Le pH des solutions', 
                sections: [
                  CourseSection(
                    id: '10_chim_gen_s3_m1',
                    type: CourseSectionType.method,
                    title: 'Échelle de pH',
                    content: 'pH < 7 : Acide\npH = 7 : Neutre\npH > 7 : Basique',
                  ),
                ],
              ),
            ],
          ),
          CourseChapter(
            id: '10_chim_org',
            title: 'Chimie Organique',
            description: 'Hydrocarbures et combustion.',
            subChapters: [
              CourseSubChapter(
                id: '10_chim_org_s1', 
                title: 'Alcanes et Alcènes', 
                sections: [
                  CourseSection(
                    id: '10_chim_org_s1_f1',
                    type: CourseSectionType.formula,
                    title: 'Formule générale des Alcanes',
                    content: 'CnH2n+2',
                  ),
                  CourseSection(
                    id: '10_chim_org_s1_f2',
                    type: CourseSectionType.formula,
                    title: 'Formule générale des Alcènes',
                    content: 'CnH2n',
                  ),
                ],
              ),
              CourseSubChapter(id: '10_chim_org_s2', title: 'Combustion des hydrocarbures', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_bio',
        name: 'Biologie (SVT)',
        description: 'Le corps humain, génétique et environnement.',
        icon: Icons.biotech_rounded,
        color: const Color(0xFF10B981),
        chapters: [
          CourseChapter(
            id: '10_bio_corps',
            title: 'Anatomie et Physiologie',
            description: 'Systèmes du corps humain.',
            subChapters: [
              CourseSubChapter(id: '10_bio_corps_s1', title: 'Le système nerveux', sections: []),
              CourseSubChapter(id: '10_bio_corps_s2', title: 'Le système immunitaire', sections: []),
              CourseSubChapter(id: '10_bio_corps_s3', title: 'La reproduction humaine', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_bio_gen',
            title: 'Génétique',
            description: 'Transmission des caractères.',
            subChapters: [
              CourseSubChapter(id: '10_bio_gen_s1', title: 'Chromosomes et ADN', sections: []),
              CourseSubChapter(id: '10_bio_gen_s2', title: 'Hérédité humaine', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_hist',
        name: 'Histoire',
        description: 'Le monde contemporain et l\'Afrique moderne.',
        icon: Icons.history_edu_rounded,
        color: const Color(0xFFF43F5E),
        chapters: [
          CourseChapter(
            id: '10_hist_monde',
            title: 'Histoire du Monde',
            description: 'Les grands conflits et évolutions.',
            subChapters: [
              CourseSubChapter(id: '10_hist_monde_s1', title: 'La Seconde Guerre Mondiale', sections: []),
              CourseSubChapter(id: '10_hist_monde_s2', title: 'La Guerre Froide', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_hist_afr',
            title: 'Histoire de l\'Afrique et Guinée',
            description: 'Décolonisation et indépendances.',
            subChapters: [
              CourseSubChapter(id: '10_hist_afr_s1', title: 'La décolonisation en Afrique Noire', sections: []),
              CourseSubChapter(id: '10_hist_afr_s2', title: 'La 1ère République de Guinée', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_geo',
        name: 'Géographie',
        description: 'Étude des continents et économie guinéenne.',
        icon: Icons.public_rounded,
        color: const Color(0xFF8B5CF6),
        chapters: [
          CourseChapter(
            id: '10_geo_monde',
            title: 'Géographie du Monde',
            description: 'Les grandes puissances et ensembles.',
            subChapters: [
              CourseSubChapter(id: '10_geo_monde_s1', title: 'L\'Asie (Chine/Japon)', sections: []),
              CourseSubChapter(id: '10_geo_monde_s2', title: 'L\'Amérique (USA)', sections: []),
              CourseSubChapter(id: '10_geo_monde_s3', title: 'L\'Europe (UE)', sections: []),
            ],
          ),
          CourseChapter(
            id: '10_geo_gui',
            title: 'Économie de la Guinée',
            description: 'Potentiels et défis.',
            subChapters: [
              CourseSubChapter(id: '10_geo_gui_s1', title: 'Le secteur minier guinéen', sections: []),
              CourseSubChapter(id: '10_geo_gui_s2', title: 'L\'agriculture et ses problèmes', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: '10_ecm',
        name: 'ECM',
        description: 'Civisme, démocratie et citoyenneté.',
        icon: Icons.gavel_rounded,
        color: const Color(0xFF64748B),
        chapters: [
          CourseChapter(
            id: '10_ecm_dem',
            title: 'Démocratie et État',
            description: 'Principes démocratiques.',
            subChapters: [
              CourseSubChapter(id: '10_ecm_dem_s1', title: 'Les partis politiques', sections: []),
              CourseSubChapter(id: '10_ecm_dem_s2', title: 'La corruption et ses méfaits', sections: []),
              CourseSubChapter(id: '10_ecm_dem_s3', title: 'La bonne gouvernance', sections: []),
            ],
          ),
        ],
      ),
    ];
  }

  static List<CourseSubject> _getTSMSubjects() {
    return [
      CourseSubject(
        id: 'tsm_maths',
        name: 'Mathématiques',
        description: 'Analyse, Algèbre et Géométrie Terminale.',
        icon: Icons.calculate_rounded,
        color: const Color(0xFF6366F1),
        chapters: [
          CourseChapter(
            id: 'tsm_maths_ana',
            title: 'Analyse',
            description: 'Limites, Dérivées et Intégrales.',
            subChapters: [
              CourseSubChapter(id: 'tsm_maths_ana_s1', title: 'Fonctions Logarithmes', sections: []),
              CourseSubChapter(id: 'tsm_maths_ana_s2', title: 'Fonctions Exponentielles', sections: []),
              CourseSubChapter(id: 'tsm_maths_ana_s3', title: 'Calcul Intégral', sections: []),
              CourseSubChapter(id: 'tsm_maths_ana_s4', title: 'Équations Différentielles', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tsm_maths_alg',
            title: 'Algèbre',
            description: 'Nombres Complexes et Arithmétique.',
            subChapters: [
              CourseSubChapter(id: 'tsm_maths_alg_s1', title: 'Nombres Complexes', sections: []),
              CourseSubChapter(id: 'tsm_maths_alg_s2', title: 'Arithmétique dans Z', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_phys',
        name: 'Physique',
        description: 'Mécanique Newtonienne et Électromagnétisme.',
        icon: Icons.bolt_rounded,
        color: const Color(0xFFF59E0B),
        chapters: [
          CourseChapter(
            id: 'tsm_phys_mec',
            title: 'Mécanique',
            description: 'Lois de Newton et applications.',
            subChapters: [
              CourseSubChapter(id: 'tsm_phys_mec_s1', title: 'Mouvement d\'un projectile', sections: []),
              CourseSubChapter(id: 'tsm_phys_mec_s2', title: 'Mouvements des planètes et satellites', sections: []),
              CourseSubChapter(id: 'tsm_phys_mec_s3', title: 'Systèmes oscillants', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tsm_phys_elec',
            title: 'Électricité',
            description: 'Circuits RC, RL et RLC.',
            subChapters: [
              CourseSubChapter(id: 'tsm_phys_elec_s1', title: 'Le dipôle RC', sections: []),
              CourseSubChapter(id: 'tsm_phys_elec_s2', title: 'Le dipôle RL', sections: []),
              CourseSubChapter(id: 'tsm_phys_elec_s3', title: 'Oscillations électriques libres', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_chim',
        name: 'Chimie',
        description: 'Cinétique, Équilibres et Chimie Organique.',
        icon: Icons.science_rounded,
        color: const Color(0xFF06B6D4),
        chapters: [
          CourseChapter(
            id: 'tsm_chim_cin',
            title: 'Cinétique Chimique',
            description: 'Vitesse de réaction et facteurs cinétiques.',
            subChapters: [
              CourseSubChapter(id: 'tsm_chim_cin_s1', title: 'Suivi temporel d\'une transformation', sections: []),
              CourseSubChapter(id: 'tsm_chim_cin_s2', title: 'Facteurs cinétiques et catalyse', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tsm_chim_eq',
            title: 'Équilibres Chimiques',
            description: 'Acides, bases et pH.',
            subChapters: [
              CourseSubChapter(id: 'tsm_chim_eq_s1', title: 'Le pH des solutions aqueuses', sections: []),
              CourseSubChapter(id: 'tsm_chim_eq_s2', title: 'Réactions Acide-Base', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_philo',
        name: 'Philosophie',
        description: 'La Conscience, l\'Inconscient et l\'État.',
        icon: Icons.psychology_rounded,
        color: const Color(0xFF8B5CF6),
        chapters: [
          CourseChapter(
            id: 'tsm_philo_c1',
            title: 'Le Sujet',
            description: 'La conscience, l\'inconscient, le désir.',
            subChapters: [
              CourseSubChapter(id: 'tsm_philo_c1_s1', title: 'La Conscience et l\'Inconscient', sections: []),
              CourseSubChapter(id: 'tsm_philo_c1_s2', title: 'Le Désir', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_eco',
        name: 'Économie',
        description: 'Macroéconomie et développement.',
        icon: Icons.trending_up_rounded,
        color: const Color(0xFF10B981),
        chapters: [
          CourseChapter(
            id: 'tsm_eco_c1',
            title: 'Activité Économique',
            description: 'Production, croissance et crises.',
            subChapters: [
              CourseSubChapter(id: 'tsm_eco_c1_s1', title: 'La croissance économique', sections: []),
              CourseSubChapter(id: 'tss_eco_c1_s2', title: 'Le rôle de l\'État', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_fr',
        name: 'Français',
        description: 'Littérature et méthodologie du résumé.',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF4A90E2),
        chapters: [
          CourseChapter(
            id: 'tsm_fr_c1',
            title: 'Littérature',
            description: 'Œuvres intégrales et groupements de textes.',
            subChapters: [
              CourseSubChapter(id: 'tsm_fr_c1_s1', title: 'Analyse d\'œuvres africaines', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tsm_ang',
        name: 'Anglais',
        description: 'Technical English and communication.',
        icon: Icons.language_rounded,
        color: const Color(0xFF475569),
        chapters: [
          CourseChapter(
            id: 'tsm_ang_c1',
            title: 'Language Skills',
            description: 'Grammar and professional vocabulary.',
            subChapters: [
              CourseSubChapter(id: 'tsm_ang_c1_s1', title: 'Conditional Sentences', sections: []),
              CourseSubChapter(id: 'tsm_ang_c1_s2', title: 'Passive Voice', sections: []),
            ],
          ),
        ],
      ),
    ];
  }

  static List<CourseSubject> _getTEMSubjects() {
    return [
      CourseSubject(
        id: 'tem_chim',
        name: 'Chimie',
        description: 'Cinétique, Équilibres et Chimie Organique.',
        icon: Icons.science_rounded,
        color: const Color(0xFF06B6D4),
        chapters: [
          CourseChapter(
            id: 'tem_chim_c1',
            title: 'Chimie Organique',
            description: 'Étude des composés du carbone.',
            subChapters: [
              CourseSubChapter(id: 'tem_chim_c1_s1', title: 'Les Alcools', sections: []),
              CourseSubChapter(id: 'tem_chim_c1_s2', title: 'Amines et Acides Aminés', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tem_chim_c2',
            title: 'Solutions Aqueuses',
            description: 'pH-métrie et dosages.',
            subChapters: [
              CourseSubChapter(id: 'tem_chim_c2_s1', title: 'Acides forts et Bases fortes', sections: []),
              CourseSubChapter(id: 'tem_chim_c2_s2', title: 'Couples Acide-Base faibles', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_phys',
        name: 'Physique',
        description: 'Mécanique, Électricité et Nucléaire.',
        icon: Icons.bolt_rounded,
        color: const Color(0xFFF59E0B),
        chapters: [
          CourseChapter(
            id: 'tem_phys_c1',
            title: 'Physique Nucléaire',
            description: 'Radioactivité et énergie.',
            subChapters: [
              CourseSubChapter(id: 'tem_phys_c1_s1', title: 'La Radioactivité', sections: []),
              CourseSubChapter(id: 'tem_phys_c1_s2', title: 'Réactions nucléaires', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tem_phys_c2',
            title: 'Électricité',
            description: 'Phénomènes d\'induction.',
            subChapters: [
              CourseSubChapter(id: 'tem_phys_c2_s1', title: 'Auto-induction', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_bio',
        name: 'Biologie (SVT)',
        description: 'Génétique et Physiologie humaine.',
        icon: Icons.biotech_rounded,
        color: const Color(0xFF10B981),
        chapters: [
          CourseChapter(
            id: 'tem_bio_c1',
            title: 'Génétique Humaine',
            description: 'Transmission des caractères héréditaires.',
            subChapters: [
              CourseSubChapter(id: 'tem_bio_c1_s1', title: 'Les lois de Mendel', sections: []),
              CourseSubChapter(id: 'tem_bio_c1_s2', title: 'Le brassage génétique', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_geol',
        name: 'Géologie',
        description: 'Tectonique des plaques et chronologie.',
        icon: Icons.layers_rounded,
        color: const Color(0xFF78350F),
        chapters: [
          CourseChapter(
            id: 'tem_geol_c1',
            title: 'Dynamique Interne',
            description: 'Séismes et volcanisme.',
            subChapters: [
              CourseSubChapter(id: 'tem_geol_c1_s1', title: 'La dérive des continents', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_fr',
        name: 'Français',
        description: 'Littérature et Dissertation.',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF4A90E2),
        chapters: [
          CourseChapter(
            id: 'tem_fr_c1',
            title: 'Littérature Africaine',
            description: 'Auteurs et œuvres majeures.',
            subChapters: [
              CourseSubChapter(id: 'tem_fr_c1_s1', title: 'Le Roman contemporain', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_maths',
        name: 'Mathématiques',
        description: 'Analyse et Statistiques.',
        icon: Icons.calculate_rounded,
        color: const Color(0xFF6366F1),
        chapters: [
          CourseChapter(
            id: 'tem_maths_c1',
            title: 'Analyse',
            description: 'Fonctions et calcul intégral.',
            subChapters: [
              CourseSubChapter(id: 'tem_maths_c1_s1', title: 'Fonction Exponentielle', sections: []),
              CourseSubChapter(id: 'tem_maths_c1_s2', title: 'Primitives et Intégrales', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tem_ang',
        name: 'Anglais',
        description: 'English for Sciences and Communication.',
        icon: Icons.language_rounded,
        color: const Color(0xFF475569),
        chapters: [
          CourseChapter(
            id: 'tem_ang_c1',
            title: 'Language Skills',
            description: 'Vocabulary and grammar.',
            subChapters: [
              CourseSubChapter(id: 'tem_ang_c1_s1', title: 'Scientific Terminology', sections: []),
            ],
          ),
        ],
      ),
    ];
  }

  static List<CourseSubject> _getTSSSubjects() {
    return [
      CourseSubject(
        id: 'tss_fr',
        name: 'Français',
        description: 'Littérature, analyse de texte et dissertation.',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF4A90E2),
        chapters: [
          CourseChapter(
            id: 'tss_fr_c1',
            title: 'La Littérature Africaine',
            description: 'Les grands courants et auteurs du continent.',
            subChapters: [
              CourseSubChapter(id: 'tss_fr_c1_s1', title: 'La Négritude', sections: []),
              CourseSubChapter(id: 'tss_fr_c1_s2', title: 'Le Roman de la contestation', sections: []),
              CourseSubChapter(id: 'tss_fr_c1_s3', title: 'Littérature et engagement', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_fr_c2',
            title: 'Méthodologie',
            description: 'Les outils de l\'analyse littéraire.',
            subChapters: [
              CourseSubChapter(id: 'tss_fr_c2_s1', title: 'La Dissertation littéraire', sections: []),
              CourseSubChapter(id: 'tss_fr_c2_s2', title: 'Le Commentaire composé', sections: []),
              CourseSubChapter(id: 'tss_fr_c2_s3', title: 'Le Résumé de texte', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_hist',
        name: 'Histoire',
        description: 'La Décolonisation et le Monde Contemporain.',
        icon: Icons.history_edu_rounded,
        color: const Color(0xFFF43F5E),
        chapters: [
          CourseChapter(
            id: 'tss_hist_c1',
            title: 'Le Monde après 1945',
            description: 'Relations internationales et Guerre Froide.',
            subChapters: [
              CourseSubChapter(id: 'tss_hist_c1_s1', title: 'La Guerre Froide (1947-1991)', sections: []),
              CourseSubChapter(id: 'tss_hist_c1_s2', title: 'L\'ONU : Rôles et limites', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_hist_c2',
            title: 'Décolonisation et Indépendances',
            description: 'Le mouvement d\'émancipation des peuples.',
            subChapters: [
              CourseSubChapter(id: 'tss_hist_c2_s1', title: 'Causes de la décolonisation', sections: []),
              CourseSubChapter(id: 'tss_hist_c2_s2', title: 'L\'indépendance de la Guinée', sections: []),
              CourseSubChapter(id: 'tss_hist_c2_s3', title: 'Le Tiers-Monde', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_geo',
        name: 'Géographie',
        description: 'La Mondialisation et les Grands Ensembles.',
        icon: Icons.public_rounded,
        color: const Color(0xFF8B5CF6),
        chapters: [
          CourseChapter(
            id: 'tss_geo_c1',
            title: 'Espace Mondial et Mondialisation',
            description: 'Les dynamiques de l\'économie mondiale.',
            subChapters: [
              CourseSubChapter(id: 'tss_geo_c1_s1', title: 'Le processus de mondialisation', sections: []),
              CourseSubChapter(id: 'tss_geo_c1_s2', title: 'Les centres d\'impulsion', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_geo_c2',
            title: 'Les Grands Ensembles Économiques',
            description: 'Pôles de puissance mondiale.',
            subChapters: [
              CourseSubChapter(id: 'tss_geo_c2_s1', title: 'L\'Union Européenne', sections: []),
              CourseSubChapter(id: 'tss_geo_c2_s2', title: 'L\'Amérique du Nord (USA/Canada)', sections: []),
              CourseSubChapter(id: 'tss_geo_c2_s3', title: 'L\'Asie Orientale', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_philo',
        name: 'Philosophie',
        description: 'La Morale, la Politique et la Science.',
        icon: Icons.psychology_rounded,
        color: const Color(0xFF6366F1),
        chapters: [
          CourseChapter(
            id: 'tss_philo_c1',
            title: 'La Connaissance',
            description: 'Science, vérité et raison.',
            subChapters: [
              CourseSubChapter(id: 'tss_philo_c1_s1', title: 'La Raison et le Réel', sections: []),
              CourseSubChapter(id: 'tss_philo_c1_s2', title: 'La Science et la Technique', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_philo_c2',
            title: 'L\'Action Humaine',
            description: 'Liberté, morale et politique.',
            subChapters: [
              CourseSubChapter(id: 'tss_philo_c2_s1', title: 'La Liberté', sections: []),
              CourseSubChapter(id: 'tss_philo_c2_s2', title: 'L\'État et la Justice', sections: []),
              CourseSubChapter(id: 'tss_philo_c2_s3', title: 'La Morale', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_maths',
        name: 'Mathématiques',
        description: 'Statistiques, probabilités et analyse de base.',
        icon: Icons.calculate_rounded,
        color: const Color(0xFFF5A623),
        chapters: [
          CourseChapter(
            id: 'tss_maths_c1',
            title: 'Statistiques et Probabilités',
            description: 'Outils d\'analyse de données.',
            subChapters: [
              CourseSubChapter(id: 'tss_maths_c1_s1', title: 'Statistiques à une variable', sections: []),
              CourseSubChapter(id: 'tss_maths_c1_s2', title: 'Probabilités élémentaires', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_maths_c2',
            title: 'Analyse',
            description: 'Étude de fonctions.',
            subChapters: [
              CourseSubChapter(id: 'tss_maths_c2_s1', title: 'Suites numériques', sections: []),
              CourseSubChapter(id: 'tss_maths_c2_s2', title: 'Fonctions logarithmes', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_eco',
        name: 'Économie',
        description: 'Économie générale et développement.',
        icon: Icons.trending_up_rounded,
        color: const Color(0xFF10B981),
        chapters: [
          CourseChapter(
            id: 'tss_eco_c1',
            title: 'Économie Générale',
            description: 'Les bases de l\'analyse économique.',
            subChapters: [
              CourseSubChapter(id: 'tss_eco_c1_s1', title: 'La production et les revenus', sections: []),
              CourseSubChapter(id: 'tss_eco_c1_s2', title: 'La consommation et l\'épargne', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_eco_c2',
            title: 'Développement et Guinée',
            description: 'Défis du développement en Afrique.',
            subChapters: [
              CourseSubChapter(id: 'tss_eco_c2_s1', title: 'Croissance et Développement', sections: []),
              CourseSubChapter(id: 'tss_eco_c2_s2', title: 'L\'économie guinéenne', sections: []),
            ],
          ),
        ],
      ),
      CourseSubject(
        id: 'tss_ang',
        name: 'Anglais',
        description: 'Grammar, vocabulary and comprehension.',
        icon: Icons.language_rounded,
        color: const Color(0xFF475569),
        chapters: [
          CourseChapter(
            id: 'tss_ang_c1',
            title: 'Grammar and Syntax',
            description: 'Improving writing and speaking skills.',
            subChapters: [
              CourseSubChapter(id: 'tss_ang_c1_s1', title: 'Tenses and Aspects', sections: []),
              CourseSubChapter(id: 'tss_ang_c1_s2', title: 'Reported Speech', sections: []),
            ],
          ),
          CourseChapter(
            id: 'tss_ang_c2',
            title: 'Reading and Writing',
            description: 'Text analysis and essay writing.',
            subChapters: [
              CourseSubChapter(id: 'tss_ang_c2_s1', title: 'Reading Comprehension', sections: []),
              CourseSubChapter(id: 'tss_ang_c2_s2', title: 'Essay Writing Method', sections: []),
            ],
          ),
        ],
      ),
    ];
  }

  static final List<CourseSubject> subjects = _get6emeSubjects(); 
}
