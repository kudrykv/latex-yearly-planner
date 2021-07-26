const moment = require('moment');
const m = require('./month');
const ls = require('./latexsnips');
const funcs = require('./funcs');

const monthly = (year, month) => {
  let calendar = m
    .monthMonday(year, month)
    .map(row => row.map(corner))

  const date = new Date(year, month, 1);
  let startingWeek = moment(date).isoWeek();
  calendar.forEach(row => {
    row.unshift(rotateWeek(startingWeek));
    startingWeek++;
  })

  calendar = calendar.map(row => row.join(' &\n')).join(' \\\\ \\hline\n') + '\\\\ \\hline';
  const weekdays = getWeekdays().map(day => `\\hfil ${day}`).join(' & ');
  const header = [
    ls.slink(year),
    ls.slink(`Q${Math.floor(month / 3)+1}`),
    ls.starget(date.toLocaleString('default', {month: 'long'}))
  ];

  return `${ls.header(header)}\n${funcs.interpolateTpl('monthly', {weekdays, calendar})}\n`;
}

const rotateWeek = weekNum => funcs.interpolateTpl('rotatedWeekNum', {weekNum: ls.slink('Week ' + weekNum)})

const getWeekdays = () => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const corner = (date) => {
  if (!date && date !== 0) return '';

  return funcs.interpolateTpl('monthlyCornerDate', {date});
}

module.exports.monthly = monthly;
