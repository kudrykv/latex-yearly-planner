module.exports.header = list =>
  `{%
    \\noindent\\LARGE%
    \\renewcommand{\\arraystretch}{1.5}%
    \\begin{tabular}{|${new Array(list.length).fill('l').join(' | ')}}
        ${list.join(' & ')}
    \\end{tabular}
    \\hfill%
}
\\myHfillThick\\medskip`;

module.exports.link = (ref, text) => `\\hyperlink{${ref}}{${text}}`;
module.exports.slink = (reftext) => `\\hyperlink{${reftext}}{${reftext}}`;
module.exports.target = (ref, text) => `\\hypertarget{${ref}}{${text}}`;
module.exports.starget = (reftext) => `\\hypertarget{${reftext}}{${reftext}}`;