const funcs = require('./funcs');
const act = require('./1_annual');
const ls = require('./latexsnips');

const qtabular = (selected) => {
  selected++;

  return funcs.range(1, 5)
    .map(num => num === selected ? ls.target('Q' + num, '\\textbf{Q' + num + '}') : ls.link('Q' + num, 'Q' + num)).join('\\quad{}');
}

const quarter = (year, q) => {
  const tabulars = funcs.range(q * 3, q * 3 + 3).map(qq => {
    const calendar = act.monthTabular(year, qq, true);

    return funcs.interpolateTpl('qrtrRow', {calendar});
  })

  return `${ls.header([year, qtabular(q)])}

${tabulars.join('\\vfill')}
\\pagebreak
`
}

module.exports.quarter = quarter;
module.exports.qtabular = qtabular;
