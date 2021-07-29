const moment = require('moment');
const m = require('./month');
const ls = require('./latexsnips');
const funcs = require('./funcs');

const monthly = (year, month) => {
  let calendar = m
    .monthMonday(year, month)
    .map(row => row.map(date => corner(year, month, date)))

  const date = new Date(year, month, 1);
  let startingWeek = moment(date);
  calendar.forEach(row => {
    row.unshift(rotateWeek(startingWeek.isoWeek()));
    startingWeek.add(1, 'week');
  })

  calendar = calendar.map(row => row.join(' &\n')).join(' \\\\ \\hline\n') + '\\\\ \\hline';
  const weekdays = getWeekdays().map(day => `\\hfil ${day}`).join(' & ');
  const leftList = [
    ls.slink(year),
    ls.slink(`Q${Math.floor(month / 3)+1}`),
    ls.starget(moment(date).format('MMMM'))
  ];

  const rightList = [];
  if (month > 0) {
    const prevMonth = moment(new Date(year, month-1, 1)).format('MMMM');
    rightList.push(ls.slink(prevMonth))
  }

  if (month < 11) {
    const nextMonth = moment(new Date(year, month+1, 1)).format('MMMM');
    rightList.push(ls.slink(nextMonth))
  }

  return `${ls.header(leftList, rightList)}\n${funcs.interpolateTpl('monthly', {weekdays, calendar})}\n`;
}

const rotateWeek = weekNum => funcs.interpolateTpl('rotatedWeekNum', {weekNum: ls.slink('Week ' + weekNum)})

const getWeekdays = () => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const corner = (year, month, date) => {
  if (!date && date !== 0) return '';

  const link = ls.link(funcs.formatDate(year, month, date), date)

  return funcs.interpolateTpl('monthlyCornerDate', {date: link});
}

module.exports.monthly = monthly;
