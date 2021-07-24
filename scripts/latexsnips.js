module.exports.header = list =>
  `{%
    \\noindent\\LARGE%
    \\renewcommand{\\arraystretch}{1.5}%
    \\begin{tabular}{${new Array(list.length).fill('l').join(' | ')}}
        ${list.join(' & ')}
    \\end{tabular}
    \\hfill%
}
\\myHfillThick\\medskip`;