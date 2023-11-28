.PHONY: memoire.pdf

# variables
PAGES_DIR=src/pages
CHAPITRES_DIR=src/chapitres
ANNEXES_DIR=src/annexes
BIBLIOGRAPHY_FILE=src/bibliographie.json
CSL_FILE=etudes-francaises.csl
TMP_DIR=tmp
DATE=$(date +'%Y-%m-%d-%Hh%M')
DOSSIER_FINAL := $(shell date +'%Y-%m-%d-%kh%M')
CITEPROC_OPTIONS=--bibliography=$(BIBLIOGRAPHY_FILE) --csl=$(CSL_FILE)

pages: resume abstract introduction remerciements conclusion # references

clean:
	@echo ""
	@echo "================="
	@echo "  ...Nettoyage..."
	@echo "================="
	@rm -v $(TMP_DIR)/* $(CHAPITRES_DIR)/* $(PAGES_DIR)/* 2>/dev/null || true 

	@echo "  Fichiers dans $(TMP_DIR)/ nettoyés."

figures: figures/*
figures/* : ../../memoire/figures/*
	@mkdir -p figures
	rsync -vr --exclude=.DS_Store ../../memoire/figures/* ./figures/

resume: $(TMP_DIR)/resume.md.tex

$(TMP_DIR)/resume.md.tex : $(PAGES_DIR)/resume.md
	@echo ""
	@echo "======================"
	@echo "📄 Page « Résumé » ..."
	@echo "======================"
	
	pandoc \
    $(PAGES_DIR)/resume.md \
    -o $(TMP_DIR)/resume.md.tex

	@echo "  Fait!"

abstract: $(TMP_DIR)/abstract.md.tex

$(TMP_DIR)/abstract.md.tex : $(PAGES_DIR)/abstract.md
	@echo ""
	@echo "========================"
	@echo "📄 Page « Abstract » ..."
	@echo "========================"
	
	pandoc \
	$(PAGES_DIR)/abstract.md \
	-o $(TMP_DIR)/abstract.md.tex

	@echo "  Fait!"

introduction: $(TMP_DIR)/introduction.md.tex

$(TMP_DIR)/introduction.md.tex : $(PAGES_DIR)/introduction.md
	@echo ""
	@echo "============================"
	@echo "📄 Page « Introduction » ..."
	@echo "============================"
	
	pandoc \
	src/reglages.md \
	--citeproc \
	$(CITEPROC_OPTIONS) \
	--metadata-file=src/suppress-bibliography.yml \
	$(PAGES_DIR)/introduction.md \
	-f markdown+mark \
	-o $(TMP_DIR)/introduction.md.tex
	
	@echo "  Fait!"

conclusion: $(TMP_DIR)/conclusion.md.tex

$(TMP_DIR)/conclusion.md.tex : $(PAGES_DIR)/conclusion.md
	@echo ""
	@echo "=========================="
	@echo "📄 Page « Conclusion » ..."
	@echo "=========================="
	
	pandoc \
	src/reglages.md \
	--citeproc \
	$(CITEPROC_OPTIONS) \
	--metadata-file=src/suppress-bibliography.yml \
	$(PAGES_DIR)/conclusion.md \
	-f markdown+mark \
	-o $(TMP_DIR)/conclusion.md.tex
	
	@echo "  Fait!"

remerciements: $(TMP_DIR)/remerciements.md.tex

$(TMP_DIR)/remerciements.md.tex : $(PAGES_DIR)/remerciements.md
	@echo ""
	@echo "============================="
	@echo "📄 Page « Remerciements » ..."
	@echo "============================="
	
	@pandoc \
	src/reglages.md \
	--citeproc \
	$(CITEPROC_OPTIONS) \
	--metadata-file=src/suppress-bibliography.yml \
	$^ \
	-o $@
	
	@echo "Fait!"

chapitres: $(TMP_DIR)/memoire.tex

# attention: l'ordre de chargement des fichiers de chapitre est important
$(TMP_DIR)/memoire.tex: $(CHAPITRES_DIR)/*.md tmpl/memoire.pandoc.tex $(BIBLIOGRAPHY_FILE)
	@echo ""
	@echo "======================================"
	@echo "📖 En train de faire les chapitres ..."
	@echo "======================================"
	pandoc \
	src/reglages.md \
	--citeproc \
	$(CITEPROC_OPTIONS) \
	--metadata-file=src/suppress-bibliography.yml \
	--top-level-division chapter \
	--template=tmpl/memoire.pandoc.tex \
	-f markdown+mark \
	$(CHAPITRES_DIR)/*.md  \
	-o $@

references: $(TMP_DIR)/references.md.tex

#	--lua-filter=filtres/multibib.lua 

$(TMP_DIR)/references.md.tex : $(PAGES_DIR)/references.md
	@echo ""
	@echo "======================================="
	@echo "📚 En train de faire les references ..."
	@echo "======================================="
	
	pandoc \
	src/reglages.md \
  	--citeproc \
	$(CITEPROC_OPTIONS) \
    $(PAGES_DIR)/references.md \
    -f markdown \
    -t latex \
  	-o $(TMP_DIR)/references.md.tex
	
	@echo "  Fait!"

# references générées en html

references_tmp: $(TMP_DIR)/referencestmp.html

$(TMP_DIR)/referencestmp.html : $(PAGES_DIR)/referencestmp.md
	@echo ""
	@echo "======================================="
	@echo "📚 refs temporaires ..."
	@echo "======================================="
	
	pandoc \
	src/reglages.md \
  	--citeproc \
	$(CITEPROC_OPTIONS) \
    $(PAGES_DIR)/referencestmp.md \
	-o $@
	
	@echo "  Fait!"


memoire.pdf: pages chapitres
	@echo ""
	@echo "================================================"
	@echo "📕 En train de produire le pdf avec pdflatex ..."
	@echo "================================================"
	@mkdir -p "export/${DOSSIER_FINAL}"
	pdflatex \
	-halt-on-error \
	-output-directory "export/${DOSSIER_FINAL}" \
	$(TMP_DIR)/memoire.tex \

	@echo ""
	@echo "Deuxième génération (pour TDM...)"
	@echo ""

	pdflatex \
	-halt-on-error \
	-output-directory "export/${DOSSIER_FINAL}" \
	$(TMP_DIR)/memoire.tex \

	@cp "export/${DOSSIER_FINAL}/$@" $@
	@echo ""
	@echo "---"
	@echo ""
	@echo "* Si tout s’est bien passé, le fichier a été produit dans :"
	@echo ""
	@echo "📂 export/"
	@echo "   📂 ${DOSSIER_FINAL}/"
	@echo "      📕 memoire.pdf"
	@echo ""
