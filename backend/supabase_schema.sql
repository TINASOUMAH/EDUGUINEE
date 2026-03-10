-- SCHEMA DE BASE POUR EDUGUINEE
-- A executer dans l'Editeur SQL de Supabase

-- 1. Table des PROFILS (Etend auth.users)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  phone TEXT,
  class_name TEXT, -- '6ème année', '10ème année', 'Terminale'
  option TEXT,     -- 'TSS', 'TSM', 'TEM' (si Terminale)
  avatar_url TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Table des NOTIFICATIONS
CREATE TABLE notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Table des CLASSES
CREATE TABLE classes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

-- 4. Table des MATIERES (Subjects)
CREATE TABLE subjects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID REFERENCES classes(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  icon TEXT, -- Nom de l'icône Material
  color TEXT -- Code hexadécimal
);

-- 5. Table des CHAPITRES
CREATE TABLE chapters (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT
);

-- 6. Table des CONTENUS (Cours, Exercices)
CREATE TABLE contents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  chapter_id UUID REFERENCES chapters(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL, -- 'course', 'exercise'
  title TEXT NOT NULL,
  file_url TEXT -- URL vers le PDF dans le Storage
);

-- 7. Table des ANCIENS SUJETS (Past Papers)
CREATE TABLE past_papers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID REFERENCES classes(id) ON DELETE CASCADE NOT NULL,
  subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE NOT NULL,
  year INTEGER NOT NULL,
  title TEXT NOT NULL,
  file_url TEXT NOT NULL, -- Lien vers le PDF
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 8. Table des QUIZ
CREATE TABLE quizzes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  duration_minutes INTEGER DEFAULT 15,
  difficulty TEXT DEFAULT 'Moyen', -- 'Facile', 'Moyen', 'Difficile'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 9. Table des QUESTIONS DE QUIZ
CREATE TABLE quiz_questions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
  question_text TEXT NOT NULL,
  options JSONB NOT NULL, -- Liste des choix: ["A", "B", "C", "D"]
  correct_option INTEGER NOT NULL, -- Index de la bonne réponse
  explanation TEXT, -- Explication après réponse
  points INTEGER DEFAULT 1
);

-- 10. Table des SCORES (Tentatives de Quiz)
CREATE TABLE quiz_scores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE NOT NULL,
  score INTEGER NOT NULL,
  total_points INTEGER NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- SECURITE (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Les utilisateurs peuvent voir leur propre profil" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Les utilisateurs peuvent modifier leur propre profil" ON profiles FOR UPDATE USING (auth.uid() = id);

ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Les utilisateurs voient leurs propres notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);

-- CONTENU PUBLIC (En lecture seule pour les utilisateurs authentifiés)
ALTER TABLE classes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les classes" ON classes FOR SELECT USING (true);

ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les matieres" ON subjects FOR SELECT USING (true);

ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les chapitres" ON chapters FOR SELECT USING (true);

ALTER TABLE contents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les contenus" ON contents FOR SELECT USING (true);

ALTER TABLE past_papers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les anciens sujets" ON past_papers FOR SELECT USING (true);

ALTER TABLE quizzes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les quiz" ON quizzes FOR SELECT USING (true);

ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lecture publique pour les questions" ON quiz_questions FOR SELECT USING (true);

ALTER TABLE quiz_scores ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Les utilisateurs voient leurs propres scores" ON quiz_scores FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Les utilisateurs peuvent enregistrer leurs scores" ON quiz_scores FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 11. DECLENCHEUR (Trigger) pour créer un profil automatiquement à l'inscription
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, first_name, last_name, phone, class_name, option)
  VALUES (
    new.id,
    new.raw_user_meta_data->>'first_name',
    new.raw_user_meta_data->>'last_name',
    new.raw_user_meta_data->>'phone',
    new.raw_user_meta_data->>'class_name',
    new.raw_user_meta_data->>'option'
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Autoriser l'insertion initiale dans profiles (via le trigger)
CREATE POLICY "Le système peut créer des profils" ON profiles FOR INSERT WITH CHECK (true);
