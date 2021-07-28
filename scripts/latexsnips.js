module.exports.header = list =>
  `{%
    \\noindent\\Large%
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

module.exports.tabularx = ({colSetup, hlines, matrix}) => {
  const hline = hlines ? '\\hline' : '';

  return `\\begin{tabularx}{\\linewidth}{${colSetup}}
${hline}
${matrix.map(row => row.join(' & ')).join(`\\\\ ${hline} \n`)} ${hlines ? '\\\\ \\hline \n' : ''}
\\end{tabularx}`
}