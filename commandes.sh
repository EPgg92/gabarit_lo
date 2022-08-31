PAGES_DIR=src/pages
CHAPITRES_DIR=src/chapitres
BIBLIOGRAPHY_FILE=src/bib.json
CSL_FILE=transversalites.csl
TMP_DIR=tmp
DATE=$(date +'%Y-%m-%d-%Hh%M')
DOSSIER_FINAL="export/$DATE"

CITEPROC_OPTIONS="--bibliography=$BIBLIOGRAPHY_FILE --csl=$CSL_FILE"

echo ""
echo "Enregistrement des fonctions suivantes :"
echo ""
echo " pages       Générer les fichiers .tex individuels"
echo " chapitres   Générer le fichier principal avec le corps (chapitres)"
echo " pdf         Produire le PDF dans le dossier export/"
echo " tout        Faire les 3 fonctions ci-dessus"
echo " clean       Nettoyer les fichiers temporaires dans tmp/"
echo ""
echo "Date: $DATE"

function clean() {
	echo ""
	echo "================="
	echo "  ...Nettoyage..."
	echo "================="
	rm tmp/*
}

function resume() {
	echo ""
	echo "======================"
	echo "📄 Page « Résumé » ..."
	echo "======================"

  pandoc $PAGES_DIR/resume.md -o $TMP_DIR/resume.md.tex

	echo "Fait!"
}

function abstract() {
	echo ""
	echo "========================"
	echo "📄 Page « Abstract » ..."
	echo "========================"

  pandoc $PAGES_DIR/abstract.md \
  --citeproc \
  $CITEPROC_OPTIONS \
  -o $TMP_DIR/abstract.md.tex

	echo "Fait!"
}

function introduction() {
	echo ""
	echo "============================"
	echo "📄 Page « Introduction » ..."
	echo "============================"

  pandoc $PAGES_DIR/introduction.md \
  --citeproc \
  $CITEPROC_OPTIONS \
  -o $TMP_DIR/introduction.md.tex

	echo "Fait!"
}

function conclusion() {
	echo ""
	echo "==========================="
	echo "📄 Page « Conclusion » ..."
	echo "==========================="

  pandoc $PAGES_DIR/conclusion.md \
  --citeproc \
  $CITEPROC_OPTIONS \
  -o $TMP_DIR/conclusion.md.tex

	echo "Fait!"
}

function remerciements() {
  pandoc $PAGES_DIR/remerciements.md \
  --citeproc \
  $CITEPROC_OPTIONS \
  -o $TMP_DIR/remerciements.md.tex
}

function pages() {
	echo ""
	echo "==========================="
	echo " On va faire les pages...  "
	echo "         📄 📄 📄         "
	echo "==========================="

  mkdir -p $TMP_DIR;

  resume;
  abstract;
  remerciements;
  introduction;
  conclusion;
}

function chapitres() {
	echo ""
	echo "======================================"
	echo "📖 En train de faire les chapitres ..."
	echo "======================================"

  pandoc \
  	--top-level-division=chapter \
    --citeproc \
    $CITEPROC_OPTIONS \
  	$CHAPITRES_DIR/*.md \
<<<<<<< HEAD
  	-o $TMP_DIR/memoire.tex
=======
  	-o $TMP_DIR/chapitres.tex
>>>>>>> 3df3625 (fonctionne avec pandoc... mais problèmes d’encodage)

  	echo "Fait!"
}

function tex() {
	echo ""
	echo "======================================"
	echo "🛠 Fichier TeX + biblio..."
	echo "======================================"

  pandoc \
  	--standalone \
  	--template=memoire.pandoc.tex \
    -f markdown \
    -t latex \
  	src/reglages.md \
    $TMP_DIR/chapitres.tex \
    -o $TMP_DIR/memoire.tex

  	echo "Fait!"
}

function pdf() {
	echo ""
	echo "================================================"
	echo "📕 En train de produire le pdf avec xelatex ..."
	echo "================================================"

  mkdir -p $DOSSIER_FINAL

  xelatex \
  -halt-on-error \
  -output-directory $DOSSIER_FINAL \
  $TMP_DIR/memoire.tex \

	echo ""
	echo "---"
	echo ""
	echo "* Si tout s’est bien passé, le fichier a été produit dans :"
	echo ""
	echo "📂 export/"
	echo "   📂 $DOSSIER_FINAL/"
	echo "      📕 memoire.pdf"
	echo ""
}

function tout() {
  pages;
  chapitres;
  tex;
  pdf;
  pdf; # PDF 2x pour Table des matières (et autres)
}

# Les commandes exécutées par ce fichier
#pages;
#chapitres;
#pdf;
# c’est tout!

# Allows to call a function based on arguments passed to the script
# Example: `./build.sh pdf`
$*
