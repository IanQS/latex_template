# latexmk configuration, picked up automatically by `make` and bare `latexmk`.

$pdf_mode = 4;  # build a PDF with LuaLaTeX
$lualatex = 'lualatex -shell-escape -synctex=1 '
          . '-interaction=nonstopmode -file-line-error %O %S';

# Keep auxiliary files (.aux/.log/.bbl/...) out of sight in build/,
# while the final PDF (and synctex) stay at the top level.
$aux_dir = 'build';
$out_dir = '.';

# Let \usepackage{hwstyle} / \RequirePackage{preamble} find the styles/ folder,
# and let biber find references.bib at the top level.
$ENV{'TEXINPUTS'} = '.:styles:' . ($ENV{'TEXINPUTS'} // '') . ':';
$ENV{'BIBINPUTS'} = '.:'         . ($ENV{'BIBINPUTS'} // '') . ':';
