const moment = require('moment');
const {monthMonday} = require('../common/month');
const {range, interpolateTpl, makeRow, fmtDay} = require('../common/funcs');
const {link, slink, starget, header} = require('../common/latexsnips');

const annualTable = (year) => {
  const tabulars = range(0, 4)
    .map(q => rowOfMonths(year, q))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  const quarters = range(1, 5).map(n => slink(`Q${n}`)).join('\\quad{}');

  const leftList = [starget(year), quarters];
  const rightList = [link('To Do Index', 'Todos'), link('Notes Index', 'Notes')];
  return `${header(leftList, rightList)}\n${tabulars}`
}

const rowOfMonths = (year, qrtr) =>
  range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => monthTabular(year, mth))
    .join(' & ');

const monthTabular = (year, month) => {
  const date = moment(new Date(year, month, 1));
  const monthName = slink(date.format('MMMM'));
  const calendar = monthMonday(year, month)
    .map(row => linkifyDays(year, month, row))
    .map(makeRow)
    .join(' \\\\\n');

  return interpolateTpl('calWoWeeks', {columns: 7, monthName, calendar});
}

const tabularify = (columns, content) => interpolateTpl('calRow', {columns, content});
const linkifyDays = (year, month, row) =>
  row.map(date => !date ? '' : link(fmtDay(year, month, date), date));

module.exports.annualTable = annualTable;
