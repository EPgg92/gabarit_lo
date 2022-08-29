# gabarit-memoire-udem

Pour construire un mémoire à l’Université de Montréal en Arts et sciences.

À partir du modèle fourni par la faculté ([disponible sur cette page](https://bib.umontreal.ca/gerer-diffuser/communication-savante/rediger-these-memoire/)) (voir le `README` original plus bas).

Voir aussi : [Guide de présentation des mémoires et des thèses (PDF)](https://esp.umontreal.ca/fileadmin/esp/documents/Cheminement/GuidePresentationMemoiresTheses.pdf)

## Prérequis

La méthode s’appuie sur la pile logicielle suivante :

- [Pandoc](https://pandoc.org/)
- [LaTeX](https://www.latex-project.org/)
- [Make](https://fr.wikipedia.org/wiki/Make) (pour lancer les commandes)

## Installation

1. Cloner ce répertoire (`git clone https://git.loupbrun.ca/louis/gabarit-memoire-udem.git`) ou par [téléchargement ZIP](http://git.loupbrun.ca/louis/gabarit-memoire-udem/archive/main.zip).
2. Éditer les fichiers dans le dossier `src/` :
   - 2.1. `src/reglages.md` : paratexte formel ou légal (titre, auteur, date, jury, abbréviations, etc.)
   - 2.2. `src/pages/` : pages à gérer séparément (Résumé, Introduction, etc.)
   - 2.3. `src/chapitres/` : ce qui compose le corps du mémoire, les chapitres. Tout en-tête de niveau 1 dénote un chapitre.
3. Ouvrir un terminal, se déplacer dans le dossier de travail, et lancer les commandes disponibles (voir plus bas).

## Commandes disponibles

- `make all`, `make tout` ou `make` : alias qui fait tout sauf le nettoyage. Ce sera généralement la seule commande utilisée. Elle fait les tâches suivantes :
   - `pages`
   - `chapitres`
   - `pdf`
- `make pages` : générer les pages (introduction, résumé, etc.) de `src/pages/` vers `tmp/`. Requis pour fabriquer le PDF.
- `make chapitres` générer les chapitres (le corps du texte) de `src/chapitres/` vers `tmp/memoire.tex`. Requis pour fabriquer le PDF.
- `make pdf` : générer le PDF final dans le dossier `export/`. Les étapes `pages` et `chapitres` doivent avoir été lancés au préalable.
- `make clean` : nettoyer les fichiers temporaires.

Exemple d’utilisation en ligne de commande :

```shell
make tout

# ... ou juste `make` tout court
make
```

---

## README original

```
Fichiers :
 -- README           Ce fichier
 -- dms.cls          La classe
 -- gabarit.tex      Document de travail. Renommer à
                     un nom convenable (p.ex. titre_nom.tex).
 -- ref.bib          Exemple de fichier pour bibTeX
 -- gabarit.pdf      Document compilé par pdflatex
 -- figures/         Contient des images en format pdf

Langues :
  La classe <dms> procure les commandes \francais
  et \anglais pour passer d'une langue à l'autre.
  Elles changent dynamiquement la plupart des mots-clés
  comme théorème/theorem, lemme/lemma, etc.
  Les entêtes (Chapitre/Chapter, Table des matières/Contents, etc.)
  sont figées une fois que le \begin{document} est passé. Pour
  qu'elles changent dynamiquement avec \francais et \anglais,
  utilisez \entetedynamique. Attention! Il serait très
  étrange que l'entête d'un chapitre soit Chapitre, mais
  que le suivant soit Chapter. Notez que ceci affecte aussi
  les entrées de la table des matières.

  Le package <babel> n'est donc pas strictement nécessaire,
  mais il reste compatible pour l'utiliser, p.ex.,
  pour la bibliographie ou pour un package comme <natbib>.
  Si <babel> est utilisé, il est tout de même recommandé
  d'utiliser \francais et \anglais plutôt que \selectlanguage,
  car ces premières appellent \selectlanguage lorsque <babel>
  est chargé, mais elles changent quand même les entêtes, ce
  que \selectlanguage ne fera pas.

Thèses par articles :
  IL EST IMPORTANT DE CONSULTER LE GUIDE DE PRÉSENTATION
  DES MÉMOIRES ET DES THÈSES POUR AVOIR L'INFORMATION À
  JOUR.

  En ce jour (2018), une thèse par article doit être en français,
  en moins d'avoir la permission de l'écrire en anglais. Il est
  cependant permis d'inclure ses articles dans d'autres langues. Si un
  article en anglais est inclus, il faut naturellement ajouter
  \anglais au début de l'article.

  La classe offre quelques macros pour faciliter la mise en
  page d'une thèse par article.
  \article{<titre de l'article>}  Débute un article (semblable
                                  à \chapter ou \section)
  \auteur{<nom de l'auteur>}      Auteur de l'article. L'appeler
                                  une fois pour chaque auteur
  \adresse{<adresse du            Adresse de l'auteur nommé par
           dernier auteur nommé>} le dernier \auteur
  \begin{resume}[<mots-clés>]     Résumé de l'article en français
  \begin{abstract}[<mots-clés>]   Résumé de l'article en anglais
  \revue[<phrase>]{<nom>}         Revue dans laquelle l'article
                                  a été publié. La <phrase> est
                                  optionnelle; elle permet d'introduire
                                  la revue autrement que par défaut
                                  (p.ex. « Cette article a été
                                  soumis à la revue ».)
  \contributions[<phrase>]        (Optionnel) Contributions de
                   {<texte>}      l'étudiant, s'il n'est pas seul
                                  auteur (C'est optionel, car les
                                  contributions peuvent apparaître
                                  ailleurs, mais elles doivent
                                  apparaître quelque part.) Il
                                  est important de consulter le
                                  guide. Le rôle de chaque auteur
                                  doit être décrit!
                                  La <phrase> est optionnel; elle
                                  permet d'introduire le <texte>
                                  autrement que la phrase par défaut.
  \maketitle                      Appeler une fois que tous les
                                  auteurs sont nommés
  \articleenchapitre              \article sera traité comme un
                                  chapitre plutôt qu'une partie
                                  (changement estétique, laissé
                                  au choix de l'étudiant)

Options de la classes :
  Au \documentclass, il est possible de passer des options à
  la classe

  \documentclass[option1, option2,..., optionN]{dms}

  Voici les options disponibles pour la classe <dms> :

  phd           Thèse de doctorat (standard ou par articles)
  maitrise      Mémoire de maîtrise
  rapport       Rapport de stage (maîtrise)
  travail       Travail dirigé (maîtrise)
  nobabel       Obselète
  initial       Obselète (Prépare le document au dépôt inital (pages de garde) )
  pagetitreart  (Thèse par articles) Place un page titre avant que l'article commence

  Toutes les options habituelles de LaTeX et de la classe
  <amsbook> sont aussi disponibles. En voici quelques unes
  utiles ou recommandées :

  12pt     Police de caractères en 12pt (10pt par défaut)
  twoside  Prépare le document pour une impression recto-verso
  reqno    Numéro d'équation à droite (par défaut pour la classe <dms>)
  leqno    Numéro d'équation à gauche
  draft    Montre les défauts de la mise en page et
           empêche l'inclusion d'images (utile pour
           un document en construction lourd à compiler
           à cause d'un grand nombre de figures)


Document scindé :
  Pour des documents d'envergure, comme une thèse, il est
  recommandé de diviser le ficher .tex principal en petits
  fichiers <chapitre*.tex>.  Ensuite, ce chapitre est
  inclus dans le fichier principal par

  \include{chapitre1}  %chapitre*

  Le fichier chapitre1.tex ne doit PAS contenir ni préambule
  (\documentclass, \usepackage, etc.), ni \begin{document},
  ni \end{document}.  Par conséquent, chapitre1.tex ne peut
  pas être compilé seul.
```
