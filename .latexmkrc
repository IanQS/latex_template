# latexmk configuration, picked up automatically by `make` and bare `latexmk`.

$pdf_mode = 4;  # build a PDF with LuaLaTeX
$lualatex = 'lualatex -shell-escape -synctex=1 '
          . '-interaction=nonstopmode -file-line-error %O %S';

# Keep auxiliary files (.aux/.log/.bbl/.bcf/...) out of sight in build/,
# while the final PDF (and synctex) stay at the top level.
# $emulate_aux is required on TeX Live: its engines (pdflatex/lualatex/xelatex)
# have no -aux-directory (a MiKTeX-only flag), so latexmk emulates the aux/out
# split with -output-directory and moves the PDF up. Without this, biblatex's
# .bcf leaks to the repo root and biber intermittently fails with
# "Cannot find build/<job>.bcf".
$emulate_aux = 1;
$aux_dir = 'build';
$out_dir = '.';

# Let \usepackage{hwstyle} / \RequirePackage{preamble} find the styles/ folder,
# and let biber find references.bib at the top level.
$ENV{'TEXINPUTS'} = '.:styles:' . ($ENV{'TEXINPUTS'} // '') . ':';
$ENV{'BIBINPUTS'} = '.:'         . ($ENV{'BIBINPUTS'} // '') . ':';
