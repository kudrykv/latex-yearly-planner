module.exports.header = (llist, rlist) =>
  `{%
    \\noindent\\Large%
    \\renewcommand{\\arraystretch}{\\myNumArrayStretch}%
    \\begin{tabular}{|${new Array(llist.length).fill('l').join(' | ')}}
        ${llist.join(' & ')}
    \\end{tabular}
    \\hfill%
    ${!rlist ? '' : `\\begin{tabular}{${new Array(rlist.length).fill('r').join(' | ')}@{}}
      ${rlist.join(' & ')}
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