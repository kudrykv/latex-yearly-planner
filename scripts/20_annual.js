const moment = require('moment');
const m = require('./month');
const {range, interpolateTpl, indent, makeRow, fmtDay} = require('./funcs');
const ls = require('./latexsnips');

const annualTable = (year, weeks) => {
  const tabulars = range(0, 4)
    .map(q => rowOfMonths(year, q, weeks))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  const quarters = range(1, 5).map(n => ls.slink(`Q${n}`)).join('\\quad{}');

  const leftList = [ls.starget(year), quarters];
  const rightList = [ls.link('To Do Index', 'Todos'), ls.link('Notes Index', 'Notes')];
  return `${ls.header(leftList, rightList)}\n${tabulars}`
}

const rowOfMonths = (year, qrtr, weeks) =>
  range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => monthTabular(year, mth, weeks))
    .join(' & ');

const tabularify = (columns, content) => interpolateTpl('calRow', {columns, content});

const monthTabular = (year, month, weeks = false) => {
  let calendar = m.monthMonday(year, month)
    .map(stringifyWeekNumbers)
    .map(row => row.map(date => !date ? '' : ls.link(fmtDay(year, month, date), date)));

  const columns = weeks ? 8 : 7;

  if (weeks) {
    let daynum = 1;
    let startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    calendar.forEach(row => {
      month === 0 && startingWeek > 50
        ? row.unshift(ls.link('fwWeek ' + startingWeek, startingWeek))
        : row.unshift(ls.link('Week ' + startingWeek, startingWeek));
      daynum += 7;
      startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    })
  }

  calendar = calendar.map(makeRow).join(' \\\\\n');

  const date = new Date(year, month, 1);

  return interpolateTpl('calendar', {
    weekColumn: weeks ? 'c |' : '',
    weekTag: weeks ? 'W & ' : '',
    columns: columns,
    monthName: ls.slink(date.toLocaleString('default', {month: 'long'})),
    calendar: indent(calendar)
  })
}

const stringifyWeekNumbers = row => row.map(item => item > 0 ? '' + item : '')

module.exports.annualTable = annualTable;
module.exports.monthTabular = monthTabular;
