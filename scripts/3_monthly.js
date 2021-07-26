const moment = require('moment');
const m = require('./month');
const ls = require('./latexsnips');
const funcs = require('./funcs');

const monthly = (year, month) => {
  let calendar = m
    .monthMonday(year, month)
    .map(row => row.map(corner))

  const date = new Date(year, month, 1);
  let startingWeek = moment(date).week()
  calendar.forEach(row => {
    row.unshift(rotateWeek(startingWeek));
    startingWeek++;
  })

  calendar = calendar.map(row => row.join(' &\n')).join(' \\\\ \\hline\n') + '\\\\ \\hline';
  const weekdays = getWeekdays().map(day => `\\hfil ${day}`).join(' & ');

  return `${ls.header([year, `Q${Math.floor(month / 3)+1}`, date.toLocaleString('default', {month: 'long'})])}
${funcs.interpolateTpl('monthly', {weekdays, calendar})}
`;
}

const rotateWeek = weekNum => funcs.interpolateTpl('rotatedWeekNum', {weekNum})

const getWeekdays = () => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const corner = (date) => {
  if (!date && date !== 0) return '';

  return funcs.interpolateTpl('monthlyCornerDate', {date});
}

module.exports.monthly = monthly;
