import {DateTime} from "luxon";
import {fancyHeader} from "../../common/texblocks/fancyHeader";

const funcs = require('../../common/blocks/funcs');
const ls = require('../../common/texblocks/latexsnips');

export const weekly = (year: number, curr: DateTime, leftmostDay) => {
  const dates = funcs.range(0, 7).map(i => curr.plus({day: i})) as DateTime[];
  const last = dates[dates.length - 1];

  const month = curr.year + 1 === year ? 1 : curr.month;
  const nextMonth = last.month;
  const nextMonthOverlap = nextMonth > month && month !== nextMonth;
  const quarter = curr.year + 1 === year ? 1 : curr.quarter;
  const nextQuarter = last.quarter;
  const nextQuarterOverlap = nextQuarter > quarter && quarter !== nextQuarter;

  const week = curr.weekNumber;
  const dm = dates
    .map((v, i) => ({[i + 1]: ls.link(dates[i].toFormat('yyyyMMdd'), v.day + ' ' + weekDays[i])}))
    .reduce((acc, val) => Object.assign(acc, val));

  const hhh = fancyHeader(
    {year, quarter, month, week, nextQuarterOverlap, nextMonthOverlap},
    {level: 'week', left: leftmostDay !== 1, right: last.year === year}
  )

  return `${hhh}\n\n${funcs.interpolateTpl('weekly', dm)}`
}

const weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

export const weeklies = (year: number): string => {
  const arr = [] as string[];

  let curr = DateTime.local(year, 1, 1).startOf('week');
  for (let i = 1; i <= 366; i += 7) {
    arr.push(weekly(year, curr, i));
    curr = curr.plus({week: 1});
  }

  return arr.join('\n\n')
};
