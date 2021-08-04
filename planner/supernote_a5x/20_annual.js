const moment = require('moment');
const m = require('../common/month');
const {range, interpolateTpl, indent, makeRow, fmtDay} = require('../common/funcs');
const ls = require('../common/latexsnips');

const annualTable = (year) => {
  const tabulars = range(0, 4)
    .map(q => rowOfMonths(year, q))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  const quarters = range(1, 5).map(n => ls.slink(`Q${n}`)).join('\\quad{}');

  const leftList = [ls.starget(year), quarters];
  const rightList = [ls.link('To Do Index', 'Todos'), ls.link('Notes Index', 'Notes')];
  return `${ls.header(leftList, rightList)}\n${tabulars}`
}

const rowOfMonths = (year, qrtr) =>
  range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => monthTabular(year, mth))
    .join(' & ');

const tabularify = (columns, content) => interpolateTpl('calRow', {columns, content});

const monthTabular = (year, month) => {
  const monthStart = new Date(year, month, 1);
  const week = moment(monthStart).subtract(1, 'week');
  const date = moment(monthStart);

  const calendar = m.monthMonday(year, month)
    .map(row => [week.add(1, 'week').isoWeek(), ...row])
    .map(row => [linkifyWeekNumbers(month, row[0]), ...row.slice(1)])
    .map(row => [row[0], ...linkifyDays(year, month, row.slice(1))])
    .map(makeRow)
    .join(' \\\\\n');

  return interpolateTpl('calendar', {
    weekColumn: 'c |',
    weekTag: 'W & ',
    columns: 8,
    monthName: ls.slink(date.format('MMMM')),
    calendar: indent(calendar)
  })
}

const linkifyWeekNumbers = (month, item) =>
  month === 0 && item > 50
    ? ls.link('fwWeek ' + item, item)
    : ls.link('Week ' + item, item);

const linkifyDays = (year, month, row) =>
  row.map(date => !date ? '' : ls.link(fmtDay(year, month, date), date));

module.exports.annualTable = annualTable;
module.exports.monthTabular = monthTabular;
