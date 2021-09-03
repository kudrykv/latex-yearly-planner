\documentclass[9pt]{extarticle}

\usepackage{geometry}
\usepackage[table]{xcolor}
%\usepackage{showframe}
\usepackage{calc}
\usepackage{dashrule}
\usepackage{setspace}
\usepackage{array}
\usepackage{tikz}
\usepackage{varwidth}
\usepackage{blindtext}
\usepackage{tabularx}
\usepackage{wrapfig}
\usepackage{makecell}
\usepackage{graphicx}
\usepackage{multirow}
\usepackage{amssymb}
\usepackage{expl3}
\usepackage{leading}
\usepackage{adjustbox}
\usepackage{pgffor}
\usepackage{hyperref}

\hypersetup{
  hidelinks=true
}


\geometry{paperwidth={{.Cfg.Layout.Paper.Width}}, paperheight={{.Cfg.Layout.Paper.Height}}}
\geometry{
  top={{.Cfg.Layout.Paper.Margin.Top}},
  bottom={{.Cfg.Layout.Paper.Margin.Bottom}},
  left={{.Cfg.Layout.Paper.Margin.Left}},
  right={{.Cfg.Layout.Paper.Margin.Right}}
}

\pagestyle{empty}

\parindent=0pt

\begin{document}

{{template "macro.tpl" .}}

  {{range .Files -}}
    \include{ {{- . -}} }
  {{end}}
\end{document}
