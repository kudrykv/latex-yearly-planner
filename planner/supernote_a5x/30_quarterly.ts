const funcs = require('../common/funcs');
const act = require('./20_annual');
const ls = require('../common/latexsnips');

export const qtabular = (selected) =>
  funcs.range(1, 5)
    .map(num => num === selected + 1 ? ls.target('Q' + num, '\\textbf{Q' + num + '}') : ls.slink('Q' + num))
    .join('\\quad{}');


export const quarter = (year, q) => {
  const tabulars = funcs
    .range(q * 3, q * 3 + 3)
    .map(qq => funcs.interpolateTpl('qrtrRow', {calendar: act.monthTabular(year, qq)}));

  const rightList = [ls.link('To Do Index', 'Todos'), ls.link('Notes Index', 'Notes')];
  return `${ls.header([ls.slink(year), qtabular(q)], rightList)}

${tabulars.join('\\vfill')}
\\pagebreak
`
}
