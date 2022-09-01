PAGES_DIR=src/pages
CHAPITRES_DIR=src/chapitres
ANNEXES_DIR=src/annexes
BIBLIOGRAPHY_FILE=src/bib.json
CSL_FILE=transversalites.csl
TMP_DIR=tmp
DATE=$(date +'%Y-%m-%d-%Hh%M')
DOSSIER_FINAL="export/$DATE"

CITEPROC_OPTIONS="--bibliography=$BIBLIOGRAPHY_FILE --csl=$CSL_FILE"

echo ""
echo "Enregistrement des fonctions suivantes :"
echo ""
echo " pages       Générer les fichiers .tex individuels dans le dossier $TMP_DIR/"
echo " annexes     Générer les annexes dans le dossier $TMP_DIR/"
echo " tex         Générer le fichier TeX principal avec le corps (chapitres + intro + conclusion)"
echo " pdf         Produire le PDF dans le dossier export/ (il faut faire 2x)"
echo " tout        Faire les 4 fonctions ci-dessus (incluant pdf 2x)"
echo " clean       Nettoyer les fichiers temporaires dans tmp/"
echo ""
echo "Date: $DATE"

function clean() {
	echo ""
	echo "================="
	echo "  ...Nettoyage..."
	echo "================="

	rm $TMP_DIR/*

	echo "  Fichiers dans $TMP_DIR/ nettoyés."
}

function resume() {
	echo ""
	echo "======================"
	echo "📄 Page « Résumé » ..."
	echo "======================"

  pandoc \
    $PAGES_DIR/resume.md \
    -o $TMP_DIR/resume.md.tex

	echo "Fait!"
}

function abstract() {
	echo ""
	echo "========================"
	echo "📄 Page « Abstract » ..."
	echo "========================"

  pandoc \
    $PAGES_DIR/abstract.md \
    -o $TMP_DIR/abstract.md.tex

	echo "Fait!"
}

function introduction() {
	echo ""
	echo "============================"
	echo "📄 Page « Introduction » ..."
	echo "============================"

  pandoc \
  	--citeproc \
  	--csl=$CSL_FILE \
    $PAGES_DIR/introduction.md \
    -o $TMP_DIR/introduction.md.tex

	echo "Fait!"
}

function conclusion() {
	echo ""
	echo "==========================="
	echo "📄 Page « Conclusion » ..."
	echo "==========================="

  pandoc \
  	--citeproc \
  	$CITEPROC_OPTIONS \
    $PAGES_DIR/conclusion.md \
    -o $TMP_DIR/conclusion.md.tex

	echo "Fait!"
}

function remerciements() {
  pandoc \
  	--citeproc \
  	$CITEPROC_OPTIONS \
    $PAGES_DIR/remerciements.md \
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
  # on n’inclut pas introduction ni conclusion pour maintenir la continuité
  # des références dans les corps du texte
#  introduction;
#  conclusion;
}

function references() {
	echo ""
	echo "======================================="
	echo "📚 En train de faire les references ..."
	echo "======================================="

  pandoc \
  	--lua-filter multiple-bibliographies.lua \
  	--citeproc \
  	--csl=$CSL_FILE \
    $PAGES_DIR/references.md \
    -f markdown \
    -t latex \
  	-o $TMP_DIR/references.md.tex

  echo "Fait!"
}

function annexes() {
	echo ""
	echo "====================================="
	echo "📎 En train de faire les annexes ..."
	echo "===================================="

  pandoc \
    --top-level-division=chapter \
    $ANNEXES_DIR/*.md \
    -f markdown \
    -t latex \
  	-o $TMP_DIR/annexes.md.tex

  echo "Fait!"
}

function tex() {
	echo ""
	echo "================================================"
	echo "📖 En train de faire le corps du TeX + modèle..."
	echo "================================================"

  pandoc \
  	--standalone \
  	--top-level-division=chapter \
  	--citeproc \
  	$CITEPROC_OPTIONS \
  	--template=memoire.pandoc.tex \
    -f markdown \
    -t latex \
  	src/reglages.md \
  	src/pages/introduction.md \
  	src/chapitres/*.md \
  	src/pages/conclusion.md \
    -o $TMP_DIR/memoire.tex

  echo "Fait!"
}

function pdf() {
	echo ""
	echo "================================================"
	echo "📕 En train de produire le pdf avec pdflatex ..."
	echo "================================================"

  mkdir -p $DOSSIER_FINAL

  pdflatex \
    -output-directory $DOSSIER_FINAL \
    $TMP_DIR/memoire.tex \

	echo ""
	echo "---"
	echo ""
	echo "Si tout s’est bien passé, le fichier PDF a été produit dans :"
	echo ""
	echo "📂 export/"
	echo "   📂 $DATE/"
	echo "      📕 memoire.pdf"
	echo ""
}

function tout() {
  pages;
  references;
  annexes;
  tex;
  echo "PDF: il faut faire 2 fois pour la table des matières (et autres...)"
  pdf;
  pdf; # PDF 2x pour Table des matières (et autres)
}

# Allows to call a function based on arguments passed to the script
# Example: `./build.sh pdf`
$*
