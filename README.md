# LaTeX template (homework + essay)

A general-purpose LaTeX template I fork per assignment/essay. It ships two entry
files that share a common preamble, so the same repo handles both math-y
problem sets and simple long-form essays.

```
hw.tex           homework entry file   -> \usepackage{hwstyle}
essay.tex        essay entry file      -> \usepackage{essaystyle}
parts/           optional: one file per question when you split a document
  _question.tex  hw skeleton copied by `make new`
  _section.tex   essay skeleton copied by `make new`
references.bib   bibliography database for essays
styles/
  preamble.sty   shared: packages, Roboto font, margins, subfiles, math, links
  hwstyle.sty    homework: question/answer environments, HW headers, title page
  essaystyle.sty essay: running headers, bibliography (biblatex/biber)
images/          figures (\graphicspath points here)
build/           auxiliary files (.aux/.log/.bbl/.bcf/...) — git-ignored, auto-cleaned
Makefile         build/new/clean/watch wrappers
.latexmkrc       latexmk config: aux -> build/, PDF at top level, styles/ on path
.helix/          editor config + typewriter writing mode
```

Auxiliary files are written to `build/` (kept out of git), so the working tree
only ever shows your sources and the final PDF — no `make clean` needed between
builds. The `styles/` folder is on the LaTeX search path via `.latexmkrc`, so the
entry files still just say `\usepackage{hwstyle}` with no path prefix.

When you fork it for a specific piece of work, keep the entry file you need
(`hw.tex` or `essay.tex`) and delete the other if you like — the shared
`.sty` files stay either way.

## Building

Uses [`latexmk`](https://mg.readthedocs.io/latexmk.html) (ships with TeX Live),
which handles reruns and runs `biber` for the essay bibliography automatically.

```sh
make                  # build hw.tex (default)
make FILE=essay       # build essay.tex
make watch FILE=essay # rebuild on every save
make wordcount FILE=essay  # prose-aware word count
make clean            # remove aux files, keep the PDF
make cleanall         # remove aux files and the PDF
```

`FILE` is the entry-file name without `.tex` (e.g. `hw`, `essay`, `parts/q1`).

## Splitting a document into per-question files

Long assignments — especially computational ones with big code blocks — get hard
to navigate in an editor without code folding. You can split the master into one
file per question under `parts/`, each a [`subfile`](https://ctan.org/pkg/subfiles)
of `hw.tex` / `essay.tex`:

```sh
make new Q=1            # homework: scaffold parts/q1.tex (a question{} block) + link it
make new Q=1 FILE=essay # essay: scaffold parts/q1.tex (a section{}) + link it
make                   # build the whole master -> one PDF (all parts included)
make FILE=parts/q1     # build ONE part on its own (fast, focused drafting)
make all               # build every part standalone
```

`make new` picks the hw or essay skeleton automatically from the master's style,
copies it to `parts/qN.tex`, and inserts a `\subfile{parts/qN}` line between the
`% PARTS-START` / `% PARTS-END` markers in the master. Each part compiles both
standalone *and* as part of the master (the shared preamble and `references.bib`
come from the master), so citations and cross-references work in both modes.

## Writing in Helix

`.helix/typewriter_mode.toml` adds a centered-scrolling toggle (genuine typewriter
scroll, cursor pinned to the middle of the screen):

- `space w c` — center the cursor
- `space w n` — back to normal scrolling

For focused freewriting that also **prevents deleting/undoing** (to stop you
constantly editing), launch the dedicated mode:

```sh
make write FILE=essay        # or: hx -c .helix/typewriter.toml essay.tex
```

You leave that mode by quitting Helix (`:q`). It's a separate config because
Helix can't toggle keymaps at runtime, and it's best-effort — command mode is
still reachable.

## Source / license

Homework structure adapted from
[latextemplates.com/template/cleese-assignment](https://www.latextemplates.com/template/cleese-assignment)
(CC BY-NC-SA 3.0). Modified for my own use; fork and adapt freely.
