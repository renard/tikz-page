##


export TEXMFHOME="~/texmf:"
PACKAGE = tikz-page

cleanext := $(wildcard *.dvi *.aux *.glo *.ilg *.ind *.toc *.hd *.idx *.listing *.log *.out _minted-*)

objects := $(PACKAGE).sty $(PACKAGE).pdf

LATEX := $(shell which latex)
PDFLATEX := $(shell which pdflatex)

all: $(objects)

%.sty: %.dtx
	$(RM) -f $@
	$(LATEX) '\let\install=y\input{$<}'

%.pdf: %.dtx
	TEXMFHOME="~/texmf:" $(PDFLATEX) -shell-escape $<
	makeindex -s gind.ist $(PACKAGE).idx
	TEXMFHOME="~/texmf:" $(PDFLATEX) -shell-escape $<
	#$(PDFLATEX) -shell-escape $<

clean:
	$(RM) -fr $(cleanext)

distclean: clean
	$(RM) -f $(objects)

.PHONY: %.dty
