##


PACKAGE = tikz-page

cleanext := $(wildcard *.dvi *.aux *.glo *.ilg *.ind *.toc *.hd *.idx *.listing *.log *.out _minted-*)

objects := $(PACKAGE).sty $(PACKAGE).pdf

LATEX := $(shell which latex)
PDFLATEX := $(shell which pdflatex)

ALL: $(objects)

%.sty: %.dtx
	$(RM) -f $@
	$(LATEX) '\let\install=y\input{$<}'

%.pdf: %.dtx
	$(PDFLATEX) -shell-escape $<
	makeindex -s gind.ist $(PACKAGE).idx
	$(PDFLATEX) -shell-escape $<
	#$(PDFLATEX) -shell-escape $<

clean:
	$(RM) -fr $(cleanext)

distclean: clean
	$(RM) -f $(objects)

.PHONY: %.dty
