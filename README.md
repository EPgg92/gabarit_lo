# gabarit-memoire-udem

Pour construire un mémoire à l’Université de Montréal en Arts et sciences.

À partir du modèle fourni par la faculté ([disponible sur cette page](https://bib.umontreal.ca/gerer-diffuser/communication-savante/rediger-these-memoire/)) (voir le `README` original plus bas).

Voir aussi : [Guide de présentation des mémoires et des thèses (PDF)](https://esp.umontreal.ca/fileadmin/esp/documents/Cheminement/GuidePresentationMemoiresTheses.pdf)

## Pourquoi ce projet?

**En résumé : rédiger en Markdown tout en utilisant le gabarit officiel pour produire un PDF impeccable.**

Le modèle fourni par la faculté est un excellent point de départ, mais il suppose que le contenu sera inséré à même le fichier `.tex`.
Le format `.tex` est excellent pour la composition (mise en page), beaucoup moins pour la rédaction.
Grâce à [Pandoc](https://pandoc.org/) et en adaptant le fichier gabarit, le processus de rédaction est simple et demeure séparé de la mise en forme, laquelle est automatisée (plus fiable et moins chronophage pour l’utilisateur·trice).

## Prérequis

La stratégie s’appuie sur la pile logicielle suivante :

- [Pandoc](https://pandoc.org/)
- [LaTeX](https://www.latex-project.org/)
- [Make](https://www.gnu.org/software/make/) (la distribution GNU spécifiquement; celle distribuée sous macOS, BSD, ne garantit pas des résultats cohérents)
- ... sinon, un terminal avec un shell style [`bash`](https://www.gnu.org/software/bash/) ou [`zsh`](https://www.zsh.org/) (pour exécuter les commandes transférées dans `commandes.sh`), mais Make est préférable

## Installation

1. Cloner ce répertoire (`git clone https://git.loupbrun.ca/louis/gabarit-memoire-udem.git`) ou par [téléchargement ZIP](http://git.loupbrun.ca/louis/gabarit-memoire-udem/archive/main.zip), dépaqueter et y entrer.
2. Éditer les fichiers dans le dossier `src/` :
   - 2.1. `src/reglages.md` : paratexte formel ou légal (titre, auteur, date, jury, abbréviations, etc.)
   - 2.2. `src/pages/` : pages à gérer séparément (Résumé, Introduction, etc.)
   - 2.3. `src/chapitres/` : ce qui compose le corps du mémoire, les chapitres. Tout en-tête de niveau 1 dénote un chapitre.
- 2.4. `src/bibliographie.json` : la bibliographie exportée à partir de Zotero.
- 2.5. `src/biblio__<section>.json` : chaque `<section>` de la bibliographie exportée à partir de Zotero (à raccorder avec `src/pages/references.md`).
3. Ouvrir un terminal, se déplacer dans le dossier de travail, et lancer les commandes disponibles (voir plus bas).

## Fichiers et édition

Tous les fichiers sources (édités par quelqu’un) vont dans le dossier `src/`. On y trouve :

- `chapitres/` : les fichiers des chapitres, dans l’ordre dans lequel ils seront listés. Le découpage des fichiers n’est pas important, ce qui importe c’est que chaque en-tête de niveau 1 correspond à un nouveau chapitre.
- `pages/`
- `reglages.md`

## Commandes disponibles

<details>
<summary>
Avec Make (recommandé)
</summary>

```bash
make memoire.pdf
```

**Note** : si pandoc ne recoonnaît pas l'option _hanging indent_, une intervention manuelle doit être faite dans la bibliographie générée dans un état intermédiaire `tmp/bibliographie.tex`.

```tex
%% Si pandoc ne reconnaît pas la classe `.hanging-indent`, il faut
%% renseigner le premier paramètre avec `1`.
%\begin{CSLReferences}{0}{0} %% problème! le premier paramètre est `0`

\begin{CSLReferences}{1}{0}  %% correction manuelle
```

Relancer la commande `make memoire.pdf` après la correction de ce fichier.

</details>

<details>
<summary>
Avec bash/zsh
</summary>

Au préalable, enregistrer les commandes (ceci devra être fait à chaque session de terminal) :

```shell
source commandes.sh
```

À présent, les commandes ci-dessous seront disponibles :

- `tout` : commande unique qui fait tout sauf le nettoyage. Ce sera généralement la seule commande utilisée. Elle fait les tâches suivantes :
   - `pages`
   - `chapitres`
   - `pdf`
- `pages` : générer les pages (introduction, résumé, etc.) de `src/pages/` vers `tmp/`. Requis pour fabriquer le PDF.
- `chapitres` générer les chapitres (le corps du texte) de `src/chapitres/` vers `tmp/memoire.tex`. Requis pour fabriquer le PDF.
- `pdf` : générer le PDF final dans le dossier `export/`. Les étapes `pages` et `chapitres` doivent avoir été lancées au préalable.
- `clean` : nettoyer les fichiers temporaires.

Exemple d’utilisation en ligne de commande :

```shell
tout
```

</details>

## Rédaction

Quelques trucs pour la rédaction.

### Épigraphe

Il est possible d’utiliser la commnade `epigraph` de LaTeX.

```latex
\begin{singlespace}
\epigraph{\itshape J’ai beau prendre la plus éclatante de mes voix, les hommes ne veulent point l’entendre}
{\sc--- Madeleine-Angélique de Gomez}
\end{singlespace}
```

---

<details>
<summary>

## README original

</summary>

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
</details>