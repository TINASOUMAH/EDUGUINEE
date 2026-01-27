📘 CAHIER DES CHARGES – APPLICATION EDUGUINÉE
1. Présentation générale

Nom de l’application : EduGuinée
Plateforme : Mobile (Android & iOS)

Technologies

Frontend : Flutter

Backend : Node.js (Express.js)

Base de données : MongoDB

Authentification : JWT + OTP SMS

Assistant IA : API IA (Assistant EduGuinée)

Description

EduGuinée est une application éducative mobile destinée aux élèves guinéens préparant les examens nationaux :

6ème année

10ème année

Terminale (TSS, TSM, TEM)

2. Objectifs du projet
Objectif général

Aider les élèves guinéens à réussir leurs examens nationaux grâce à des ressources pédagogiques modernes, fiables et accessibles.

Objectifs spécifiques

Centraliser les cours officiels guinéens

Proposer des quiz et exercices interactifs

Offrir un planning de révision intelligent

Intégrer un assistant IA éducatif

Créer une interface simple, moderne et motivante

3. Public cible

Élèves guinéens de 6ème, 10ème et Terminale

Utilisation possible en zone urbaine et rurale

4. Parcours utilisateur (UX)
4.1 Splash Screen

Logo EduGuinée

Animation légère Flutter

4.2 Écran de bienvenue

Message :

Bienvenue sur EduGuinée
Préparez-vous à réussir votre examen avec des ressources adaptées.
Apprenez, progressez et réussissez.

Bouton : Commencer

4.3 Choix de la classe

Affichage sous forme de cards modernes :

6ème

10ème

Terminale

4.4 Choix des options (Terminale uniquement)

TSS

TSM

TEM
Affichage en cards interactives

4.5 Accueil principal

Accès via menu hamburger

Design inspiré de GuiSchool BEPC

5. Menu Hamburger (Structure)

Menu simple et clair, identique dans l’esprit de GuiSchool BEPC.

Éléments :

🏠 Accueil

ℹ️ À propos

📞 Contactez-nous

⚙️ Paramètres

Langue

Notifications

Thème clair / sombre (future version)

🔹 Logo EduGuinée affiché en haut du menu

6. Fonctionnalités principales
6.1 Mes cours

Cours classés par matière

Texte + images

Téléchargement PDF (phase future)

6.2 Formules & Méthodes

Mathématiques

Physique

Chimie
Contenus simplifiés et mémorisables

6.3 Quiz

Quiz par matière

Score immédiat

Correction automatique

6.4 Exercices

Exercices progressifs

Correction détaillée

Niveau facile → difficile

6.5 Planning de révision

Planning journalier personnalisé

Notifications de rappel

Adapté à la classe choisie

6.6 Assistant IA – Assistant EduGuinée

Fonctions :

Répondre aux questions

Expliquer les cours simplement

Aider à résoudre les exercices

Conseiller des méthodes de révision

7. Authentification & Compte utilisateur
Boutons

Se connecter

Créer un compte

Inscription

Champs obligatoires :

Nom

Prénom

Numéro de téléphone

Mot de passe

Classe

Option (Terminale : TSS / TSM / TEM)

🔐 Validation par OTP SMS

8. Arborescence pédagogique (TRÈS IMPORTANT)
Exemple : Accès à une matière

Classe → Matière → Chapitres → Leçons → Contenu

Exemple : Mathématiques – 10ème

📘 Mathématiques

Chapitre 1 : Algèbre

Leçon 1 : Expressions algébriques

Leçon 2 : Équations

Quiz

Exercices

Chapitre 2 : Géométrie

Leçon 1 : Théorèmes

Leçon 2 : Figures planes

Quiz

Exercices

Exemple : Terminale TSS – SVT

📘 SVT

Chapitre 1 : Génétique

Leçon 1 : ADN

Leçon 2 : Transmission des caractères

Chapitre 2 : Écologie

Leçon 1 : Écosystèmes

Exercices

Quiz

📌 Chaque leçon contient :

Cours

Résumé

Quiz

Exercices

Aide IA

9. Architecture technique
9.1 Frontend – Flutter

Architecture MVVM

Responsive (mobile & tablette)

Animations modernes

9.2 Backend – Node.js

Express.js

API REST

Authentification JWT

9.3 Base de données – MongoDB

Collections :

Utilisateurs

Classes

Options

Matières

Chapitres

Leçons

Cours

Quiz

Exercices

Planning

10. Sécurité

Authentification sécurisée

Protection des données utilisateurs

OTP + JWT

11. Conclusion

EduGuinée est une application éducative moderne, inspirée de GuiSchool BEPC, enrichie de fonctionnalités innovantes adaptées au système éducatif guinéen.
Elle vise à devenir la référence nationale pour la préparation des examens.
Cours

Affichage des cours par niveau et matière (6ème, 10ème, Terminale ; Math, Français, Physique, Chimie…).

Contenu des cours :

Texte explicatif structuré (titre, sous-titre, exemples)

Images, schémas et tableaux

Formules et méthodes importantes (ex. : formules mathématiques, règles grammaticales, méthodes scientifiques)

Organisation façon GuiSchool :

Chapitres → Sous-chapitres → Exemples → Formules / Méthodes → Exercices

Chaque section indique clairement les points essentiels à retenir

Possibilité de marquer un cours comme “lu” ou “à revoir”

2.2 Formules / Méthodes

Liste des formules clés par matière :

Mathématiques : Formules d’aires, volumes, périmètres, équations

Physique / Chimie : Formules physiques, réactions chimiques

Français / Anglais : Règles de grammaire et conjugaison

Présentation façon GuiSchool :

Chaque formule ou méthode est numérotée et accompagnée d’un exemple concret

Section “Astuce / Mémo” pour faciliter la mémorisation

Option de copier / télécharger la formule pour révision rapide

Méthodes de résolution :

Pas-à-pas pour chaque type d’exercice

Diagrammes ou schémas explicatifs si nécessaire

Résolution guidée similaire aux exercices GuiSchool

2.3 Quiz / Exercices

Quiz thématiques par matière et chapitre

Types de questions :

QCM (choix multiples)

Vrai / Faux

Question ouverte

Correction automatique avec indication de la bonne réponse et rappel de la formule ou méthode associée

Suivi des scores par utilisateur

Historique des quiz pour voir les progrès

Option de répéter un quiz pour s’entraîner davantage

2.4 Planning de révision

Interface pour planifier les révisions par matière et chapitre

Paramètres configurables :

Jour et heure de révision

Priorité du chapitre (important / moyen / léger)

Notifications / rappels pour chaque session

Affichage sous forme de calendrier ou liste des révisions

Statistiques de suivi :

Nombre de chapitres révisés

Pourcentage de matières complétées

Temps total passé à réviser