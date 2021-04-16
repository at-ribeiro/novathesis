SILENT = -silent

B = template
F = -shell-escape -synctex=1 $(FLAGS)
T = $(B).pdf
S = $(B).tex
L = latexmk $(F)
V = open -a skim

default: pdf

$(T): $(S)
	make

.PHONY: pdf
pdf: $(S)
	$(L) -pdf $(SILENT) $(B)

.PHONY: verb verbose
verb verbose:
	$(L) -pdf $(B)

.PHONY: 2019 2020
2019 2020:
	PATH="/usr/local/texlive/$@/bin/x86_64-darwin/:$(PATH)" $(L) -pdf $(SILENT) $(B)

.PHONY: xe lua
xe lua: $(S)
	$(L) -pdf$@ $(SILENT) $(B)

.PHONY: v view
v view: $(T)
	$(V) $(T)

.PHONY: clean
clean:
	$(L) -c $(B)

.PHONY: rc
rc:
	Scripts/latex-clean-temp.sh

.PHONY: rcb
rcb:
	Scripts/latex-clean-temp.sh
	rm -rf `biber -cache`
	biber -cache

