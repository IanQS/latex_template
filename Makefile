# LaTeX template Makefile. Build settings live in .latexmkrc (aux -> build/,
# PDF stays at top level, styles/ on the search path).
#
#   make                 build hw.tex (the default)
#   make FILE=essay      build essay.tex (runs biber for the bibliography)
#   make watch FILE=...  rebuild continuously as you edit
#   make write FILE=...  open the file in Helix "typewriter" mode
#   make wordcount FILE=... prose-aware word count (skips LaTeX markup)
#   make clean           remove the build/ aux files (keep the PDF)
#   make cleanall        remove the build/ aux files AND the PDF
#
# FILE is the entry-file name without the .tex extension.

FILE ?= hw

.PHONY: build watch write wordcount clean cleanall

build:
	latexmk $(FILE).tex

watch:
	latexmk -pvc $(FILE).tex

write:
	hx -c .helix/typewriter_mode.toml $(FILE).tex

clean:
	latexmk -c $(FILE).tex

cleanall:
	latexmk -C $(FILE).tex
