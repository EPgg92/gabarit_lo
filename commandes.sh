PAGES_DIR=src/pages
CHAPITRES_DIR=src/chapitres
TMP_DIR=tmp
DATE=$(date +'%Y-%m-%d-%kh%M')
DOSSIER_FINAL="export/$DATE"

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

  pandoc $PAGES_DIR/abstract.md -o $TMP_DIR/abstract.md.tex

	echo "Fait!"
}

function introduction() {
	echo ""
	echo "============================"
	echo "📄 Page « Introduction » ..."
	echo "============================"

  pandoc $PAGES_DIR/introduction.md -o $TMP_DIR/introduction.md.tex

	echo "Fait!"
}

function remerciements() {
  pandoc $PAGES_DIR/remerciements.md -o $TMP_DIR/remerciements.md.tex
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
}

function chapitres() {
	echo ""
	echo "======================================"
	echo "📖 En train de faire les chapitres ..."
	echo "======================================"

  pandoc \
  	--top-level-division=chapter \
  	--template=memoire.pandoc.tex \
  	src/reglages.md \
  	$CHAPITRES_DIR/*.md \
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

# Les commandes exécutées par ce fichier
#pages;
#chapitres;
#pdf;
# c’est tout!
