import {monthlyCalContents} from '../../common/texblocks/latexsnips';
import {interpolateTpl} from '../../common/blocks/funcs';
import {fancyHeader} from "../../common/texblocks/fancyHeader";

export const monthlyPage = ({
  year,
  month,
  weeks = true,
  weekStart = 1
}: { year: number, month: number, weeks?: boolean, weekStart?: 1 | 7 }) => {
  const fh = fancyHeader(
    {year, quarter: Math.floor(month / 3) + 1, month: month + 1},
    {level: 'month', left: month > 0, right: month < 11}
  )

  return `${fh}\n${interpolateTpl('monthly', {
    weekCols: weeks ? 'l!{\\vrule width \\myLenLineThicknessThick}' : '|',
    weekCol: weeks ? '&' : '',
    weekdays: getWeekdays(weekStart).map(day => `\\hfil ${day}`).join(' & '),
    calendar: monthlyCalContents({year, month: month + 1, weeks, weekStart})
  })}\n`;
}

const getWeekdays = (weekStart: 1 | 7) => {
  const base = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  weekStart === 1 ? base.push('Sunday') : base.unshift('Sunday');

  return base;
}
