{{- .Body.HeadingMOS -}}
{}\hfill%
{\renewcommand{\arraystretch}{\myNumArrayStretch} {{ .Body.Extra2.Table false }} }%
\medskip%
\myLineThick%
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{\myLenHeaderSideMonthsWidth}{*{11}{Y|}Y}
      \hline
      {{range $i, $month := .Body.SideMonths -}}
      {{$month.Display}} {{if ne $i 11}}
      & {{else}} \\{{- $.Cfg.Layout.Lengths.HeaderSideCellHeight -}} \hline {{end}}
    {{end}}
    \end{tabularx}%
    \quad%
    \begin{tabularx}{\myLenHeaderSideQuartersWidth}{*{3}{Y|}Y}
      \hline
      {{range $i, $quarter := .Body.SideQuarters -}}
      {{$quarter.Display}} {{if ne $i 3}}
      & {{else}} \\{{- $.Cfg.Layout.Lengths.HeaderSideCellHeight -}} \hline {{end}}
    {{end}}
    \end{tabularx}%
  }%
}%
\medskip
