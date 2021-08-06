const moment = require('moment');
const funcs = require('../../common/funcs');
const ls = require('../../common/latexsnips');

export const weekly = (year, curr, prevnext, ddd) => {
  const weekStart = curr.clone();

  curr.subtract(1, 'day');
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').clone());

  const month = weekStart.year() + 1 === year ? 1 : weekStart.month() + 1;
  const nextMonth = curr.month() + 1;
  const nextMonthOverlap = nextMonth > month && month !== nextMonth;
  const quarter = weekStart.year() + 1 === year ? 1 : weekStart.quarter();
  const nextQuarter = curr.quarter();
  const nextQuarterOverlap = nextQuarter > quarter && quarter !== nextQuarter;

  const week = weekStart.isoWeek();
  const dm = dates
    .map((v, i) => ({[i + 1]: ls.link(dates[i].format('yyyyMMDD'), v.date() + ' ' + weekDays[i])}))
    .reduce((acc, val) => Object.assign(acc, val));

  const hhh = ls.fancyHeader(
    {year, quarter, month, week, nextQuarterOverlap, nextMonthOverlap},
    {level: 'week', left: ddd !== 1, right: curr.year() === year}
  )

  return `${hhh}\n\n${funcs.interpolateTpl('weekly', dm)}`
}

const weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

export const weeklies = (year: number): string => {
  const arr = [] as string[];

  const curr = moment().year(year).month(0).date(1).startOf('isoWeek');
  for (let i = 1; i <= 366; i += 7) {
    const prevAndNext = [];
    if (i > 1) {
      prevAndNext.push(curr.clone().subtract(1, 'week'));
    }

    if (i + 7 <= 366) {
      prevAndNext.push(curr.clone().add(1, 'week'));
    }

    arr.push(weekly(year, curr.clone(), prevAndNext, i));
    curr.add(1, 'week');
  }

  return arr.join('\n\n')
};
