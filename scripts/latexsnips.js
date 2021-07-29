module.exports.header = (list, list2) =>
  `{%
    \\noindent\\Large%
    \\renewcommand{\\arraystretch}{\\myNumArrayStretch}%
    \\begin{tabular}{|${new Array(list.length).fill('l').join(' | ')}}
        ${list.join(' & ')}
    \\end{tabular}
    \\hfill%
    ${!list2 ? '' : `\\begin{tabular}{${new Array(list2.length).fill('r').join(' | ')}@{}}
      ${list2.join(' & ')}
      \\end{tabular}
    `}
}
\\myHfillThick\\medskip`;

module.exports.link = (ref, text) => `\\hyperlink{${ref}}{${text}}`;
module.exports.slink = (reftext) => `\\hyperlink{${reftext}}{${reftext}}`;
module.exports.target = (ref, text) => `\\hypertarget{${ref}}{${text}}`;
module.exports.starget = (reftext) => `\\hypertarget{${reftext}}{${reftext}}`;

module.exports.tabularx = ({colSetup, hlines, matrix}) => {
  const hline = hlines ? '\\hline' : '';

  return `\\begin{tabularx}{\\linewidth}{${colSetup}}
${hline}
${matrix.map(row => row.join(' & ')).join(`\\\\ ${hline} \n`)} ${hlines ? '\\\\ \\hline \n' : ''}
\\end{tabularx}`
}