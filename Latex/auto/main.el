(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "english" "twoside" "12pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("babel" "english") ("geometry" "centering" "left=3.5cm" "right=2.5cm" "textheight=24cm") ("nowidow" "defaultlines=4" "all")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "textcomp"
    "times"
    "amsmath"
    "amsfonts"
    "amssymb"
    "amsthm"
    "fontenc"
    "inputenc"
    "graphicx"
    "xcolor"
    "enumitem"
    "babel"
    "geometry"
    "natbib"
    "listings"
    "url"
    "hyperref"
    "longtable"
    "float"
    "caption"
    "subcaption"
    "wrapfig"
    "pdflscape"
    "sgame"
    "nowidow")
   (LaTeX-add-labels
    "eq:this-is-very-important-equation"
    "tab:exceptional-table"
    "fig:xxx1"
    "fig:xxxa"
    "fig:xxxb"
    "fig:xxx"
    "fig:yyy"
    "tab:1"
    "tab:nowatablica1")
   (LaTeX-add-bibliographies
    "refs"
    "new-name")
   (LaTeX-add-amsthm-newtheorems
    "condition"
    "example"
    "definition"
    "proposition"
    "theorem"
    "cor"
    "remark"))
 :latex)

