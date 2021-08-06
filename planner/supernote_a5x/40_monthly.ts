import {fmtDay} from "../common/funcs";

const moment = require('moment');
const m = require('../common/month');
const ls = require('../common/latexsnips');
const funcs = require('../common/funcs');

export const monthly = (year, month) => {
  let calendar = m
    .monthMonday(year, month)
    .map(row => row.map(date => corner(year, month, date)))

  const date = new Date(year, month, 1);
  let startingWeek = moment(date);
  calendar.forEach(row => {
    row.unshift(rotateWeek(month, startingWeek.isoWeek()));
    startingWeek.add(1, 'week');
  })

  calendar = calendar.map(row => row.join(' &\n')).join(' \\\\ \\hline\n') + '\\\\ \\hline';
  const weekdays = getWeekdays().map(day => `\\hfil ${day}`).join(' & ');
  const leftList = [
    ls.slink(year),
    ls.slink(`Q${Math.floor(month / 3) + 1}`),
    ls.starget(moment(date).format('MMMM'))
  ];

  const rightList = [];
  if (month > 0) {
    const prevMonth = moment(new Date(year, month - 1, 1)).format('MMMM');
    rightList.push(ls.slink(prevMonth))
  }

  if (month < 11) {
    const nextMonth = moment(new Date(year, month + 1, 1)).format('MMMM');
    rightList.push(ls.slink(nextMonth))
  }

  return `${ls.header(leftList, rightList)}\n${funcs.interpolateTpl('monthly', {weekdays, calendar})}\n`;
}

const rotateWeek = (month, weekNum) => {
  const link = month === 0 && weekNum > 50
    ? ls.link('fwWeek ' + weekNum, 'Week ' + weekNum)
    : ls.slink('Week ' + weekNum);

  return funcs.interpolateTpl('rotatedWeekNum', {weekNum: link})
}

const getWeekdays = () => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const corner = (year, month, date) => {
  if (!date && date !== 0) return '';

  const link = ls.link(fmtDay(year, month, date), date)

  return funcs.interpolateTpl('monthlyCornerDate', {date: link});
}