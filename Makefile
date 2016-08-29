##


export TEXMFHOME="~/texmf:"
PACKAGE = tikz-page

cleanext := $(wildcard *.dvi *.aux *.glo *.ilg *.ind *.toc *.hd *.idx *.listing *.log *.out _minted-*)

listings := $(wildcard $(PACKAGE)-*.tex wildcard $(PACKAGE)-*.md5 wildcard $(PACKAGE)-*.pdf)

objects := $(PACKAGE).sty $(PACKAGE).pdf

LATEX := $(shell which latex)
PDFLATEX := $(shell which pdflatex)
PANDOC := $(shell which pandoc)

all: $(objects) README

%.sty: %.dtx
	$(RM) -f $@
	$(LATEX) '\let\install=y\input{$<}'

%.pdf: %.dtx
	TEXMFHOME="~/texmf:" $(PDFLATEX) -shell-escape $<
	makeindex -s gind.ist $(PACKAGE).idx
	TEXMFHOME="~/texmf:" $(PDFLATEX) -shell-escape $<
	#$(PDFLATEX) -shell-escape $<

clean:
	$(RM) -fr $(cleanext) $(listings)

distclean: clean
	$(RM) -f $(objects)

README: README.md
	$(PANDOC) -t plain -o $@ $<

.PHONY: %.dty
