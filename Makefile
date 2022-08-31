.PHONY: tout

# variables
DOSSIER_FINAL := $(shell date +'%Y-%m-%d-%kh%M')

tout: pages chapitres pdf # il faut faire pdf 2x pour produire TDM
all: tout # simple alias

pages: resume abstract introduction remerciements conclusion

clean:
	@echo ""
	@echo "================="
	@echo "  ...Nettoyage..."
	@echo "================="
	rm tmp/*

resume:
	@echo ""
	@echo "======================"
	@echo "📄 Page « Résumé » ..."
	@echo "======================"
	pandoc src/pages/resume.md -o tmp/resume.md.tex

abstract:
	@echo ""
	@echo "========================"
	@echo "📄 Page « Abstract » ..."
	@echo "========================"
	pandoc src/pages/abstract.md -o tmp/abstract.md.tex
introduction:
	@echo ""
	@echo "============================"
	@echo "📄 Page « Introduction » ..."
	@echo "============================"
	pandoc src/pages/introduction.md -o tmp/introduction.md.tex
conclusion:
	@echo ""
	@echo "==========================="
	@echo "📄 Page « Conclusion » ..."
	@echo "==========================="
	pandoc src/pages/conclusion.md -o tmp/conclusion.md.tex
remerciements:
	@echo ""
	@echo "============================="
	@echo "📄 Page « Remerciements » ..."
	@echo "============================="
	pandoc src/pages/remerciements.md -o tmp/remerciements.md.tex

chapitres:
	@echo ""
	@echo "======================================"
	@echo "📖 En train de faire les chapitres ..."
	@echo "======================================"
	pandoc \
	--top-level-division=chapter \
	--template=memoire.pandoc.tex \
	src/reglages.md \
	src/chapitres/*.md \
	-o tmp/memoire.tex

pdf: pages chapitres
	@echo ""
	@echo "================================================"
	@echo "📕 En train de produire le pdf avec pdflatex ..."
	@echo "================================================"
	mkdir -p export/${DOSSIER_FINAL}
	pdflatex \
	-halt-on-error \
	-output-directory "export/${DOSSIER_FINAL}" \
	tmp/memoire.tex \

	@echo ""
	@echo "---"
	@echo ""
	@echo "* Si tout s’est bien passé, le fichier a été produit dans :"
	@echo ""
	@echo "📂 export/"
	@echo "   📂 ${DOSSIER_FINAL}/"
	@echo "      📕 memoire.pdf"
	@echo ""
