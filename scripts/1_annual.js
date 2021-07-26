const moment = require('moment');
const m = require('./month');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const annualTable = (year, weeks) => {
  const tabulars = funcs.range(0, 4)
    .map(q => rowOfMonths(year, q, weeks))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  const quarters = funcs.range(1, 5).map(n => ls.link(`Q${n}`, `Q${n}`)).join('\\quad{}');

  return `${ls.header([ls.target(year, year), quarters])}\n${tabulars}`
}

const rowOfMonths = (year, qrtr, weeks) =>
  funcs
    .range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => monthTabular(year, mth, weeks))
    .join(' & ');

const tabularify = (columns, content) => funcs.interpolateTpl('calRow', {columns, content});

const monthTabular = (year, month, weeks = false) => {
  let calendar = m.monthMonday(year, month)
    .map(stringifyWeekNumbers);

  const columns = weeks ? 8 : 7;

  if (weeks) {
    let daynum = 1;
    let startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    calendar.forEach(row => {
      row.unshift(startingWeek);
      daynum += 7;
      startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    })
  }

  calendar = calendar.map(joinWeekDays).join(' \\\\\n');

  const date = new Date(year, month, 1);

  return funcs.interpolateTpl('calendar', {
    weekColumn: weeks ? 'c |' : '',
    weekTag: weeks ? 'W & ' : '',
    columns: columns,
    monthName: date.toLocaleString('default', {month: 'long'}),
    calendar: funcs.indent(calendar)
  })
}

const stringifyWeekNumbers = row => row.map(item => item > 0 ? '' + item : '')
const joinWeekDays = row => row.join(' & ')

module.exports.annualTable = annualTable;
module.exports.monthTabular = monthTabular;
