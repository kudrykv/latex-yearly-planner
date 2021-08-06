const {range, interpolateTpl} = require('../common/funcs');
const ls = require('../common/latexsnips');

interface AnnualTableConfig {
  year: number;
  weeks?: boolean;
  weekStart?: 1 | 7;
}

export const annualTable = ({year, weeks = true, weekStart = 1}: AnnualTableConfig) => {
  const tabulars = range(0, 4)
    .map(qrtr => rowOfMonths({year, qrtr, weeks, weekStart}))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  const quarters = range(1, 5).map(n => ls.slink(`Q${n}`)).join('\\quad{}');
  const leftList = [ls.starget(year), quarters];
  const rightList = [ls.link('To Do Index', 'Todos'), ls.link('Notes Index', 'Notes')];

  return `${ls.header(leftList, rightList)}\n${tabulars}`
}

interface RowOfMonthsConfig extends AnnualTableConfig {
  qrtr: number;
}

const rowOfMonths = ({year, qrtr, weeks, weekStart}: RowOfMonthsConfig) =>
  range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => ls.monthlyTabular({year, month: mth + 1, weeks, weekStart}))
    .join(' & ');

const tabularify = (columns, content) => interpolateTpl('calRow', {columns, content});
