clean:
	rm *.fls; rm *.log;rm *.aux; rm *.fdb_latexmk; rm *.gz;

build:
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -recorder sol.tex && \
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -recorder sol.tex; \
	rm *.fls; rm *.aux; rm *.fdb_latexmk; rm *.gz;
