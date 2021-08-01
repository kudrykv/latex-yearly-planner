const funcs = require('./funcs');
const act = require('./20_annual');
const ls = require('./latexsnips');

const qtabular = (selected) => {
  selected++;

  return funcs.range(1, 5)
    .map(num => num === selected ? ls.target('Q' + num, '\\textbf{Q' + num + '}') : ls.slink('Q' + num))
    .join('\\quad{}');
}

const quarter = (year, q) => {
  const tabulars = funcs.range(q * 3, q * 3 + 3).map(qq => {
    const calendar = act.monthTabular(year, qq);

    return funcs.interpolateTpl('qrtrRow', {calendar});
  })

  const rightList = [ls.link('To Do Index', 'Todos'), ls.link('Notes Index', 'Notes')];
  return `${ls.header([ls.slink(year), qtabular(q)], rightList)}

${tabulars.join('\\vfill')}
\\pagebreak
`
}

module.exports.quarter = quarter;
module.exports.qtabular = qtabular;
