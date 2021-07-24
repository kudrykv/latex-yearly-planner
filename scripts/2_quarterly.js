const funcs = require('./funcs');
const act = require('./1_annual');

const qtabular = (selected) => {
  selected++;

  return funcs.range(1, 5)
    .map(num => num === selected ? '\\textbf{Q' + num + '}' : 'Q' + num).join('\\quad{}');
}

const quarter = (year, q) => {
  const tabulars = funcs.range(q * 3, q * 3 + 3).map(qq => {
    const calendar = act.monthTabular(year, qq, true);
    const lines = new Array(11).fill('\\myLineOrd').join('');

    return `{\\noindent\\renewcommand{\\arraystretch}{0}%
\\begin{tabularx}{\\textwidth}{@{}l X@{}}
${calendar} &
\\Repeat{\\myQuarterlyLines}{\\myLineOrd}
\\end{tabularx}}`
  })

  return `
{%
    \\noindent\\LARGE%
    \\renewcommand{\\arraystretch}{1.5}%
    \\begin{tabular}{l | l}
        ${year} & ${qtabular(q)}
    \\end{tabular}
    \\hfill%
}
\\myHfillThick\\medskip
${tabulars.join('\\vfill')}
\\pagebreak
`
}

module.exports.quarter = quarter;
module.exports.qtabular = qtabular;
