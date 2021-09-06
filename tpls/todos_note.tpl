{{- template "header.tpl" dict "Cfg" $.Cfg "Header" .Header -}}

\Repeat{2}{
  \parbox{\myLenTwoCol}{%
    \myUnderline{\myLineHeightButLine}
    \Repeat{\myNumTodoLinesInTodoPage}{\myTodoLineGray}
  }%
  \hspace{\myLenTwoColSep}%
  \parbox{\myLenTwoCol}{%
    \myUnderline{\myLineHeightButLine}
    \Repeat{\myNumTodoLinesInTodoPage}{\myTodoLineGray}
  }
  \vfill
}
\parbox{\myLenTwoCol}{%
  \myUnderline{\myLineHeightButLine}
  \Repeat{\myNumTodoLinesInTodoPage}{\myTodoLineGray}
}%
\hspace{\myLenTwoColSep}%
\parbox{\myLenTwoCol}{%
  \myUnderline{\myLineHeightButLine}
  \Repeat{\myNumTodoLinesInTodoPage}{\myTodoLineGray}
}
\par\pagebreak
