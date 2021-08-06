const {range, interpolateTpl} = require('../common/funcs');
const {monthlyTabular, link, header, slink, target} = require('../common/latexsnips');

export const quarter = ({
  year,
  q,
  weeks = true,
  weekStart = 1
}: { year: number, q: number, weeks?: boolean, weekStart?: 1 | 7 }) => {
  const llist = [slink(year), qtabular(q)];
  const rightList = [link('To Do Index', 'Todos'), link('Notes Index', 'Notes')];
  const tabulars = range((q - 1) * 3 + 1, (q - 1) * 3 + 4)
    .map(qq => interpolateTpl('qrtrRow', {calendar: monthlyTabular({year, month: qq, weeks, weekStart})}));

  return `${header(llist, rightList)}\n\n${tabulars.join('\\vfill')}\\pagebreak\n`
}


const qtabular = (selected) =>
  range(1, 5)
    .map(num => num === selected ? target('Q' + num, '\\textbf{Q' + num + '}') : slink('Q' + num))
    .join('\\quad{}');
