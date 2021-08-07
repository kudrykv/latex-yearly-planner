import {DateTime} from "luxon";
import {fmtDay, range} from "./funcs";
import {link, slink, starget, target} from "./latexsnips";

interface LeftStackConfig {
  year: number;
  quarter?: number;
  nextQuarterOverlap?: boolean;
  month?: number;
  nextMonthOverlap?: boolean;
  week?: number;
  date?: number;
  dateSubPage?: string;
}

type Level = 'month' | 'week' | 'date';

interface RightStackConfig {
  left?: boolean;
  right?: boolean;
  level: Level;
}

export const fancyHeader = (ls: LeftStackConfig, rs: RightStackConfig): string => {
  const {year, quarter, nextQuarterOverlap, month, nextMonthOverlap, week, date, dateSubPage} = ls;
  const llist = [];
  const rlist = [];
  let targetSet = false;

  if (dateSubPage) {
    llist.unshift(target(fmtDay(year, month, date) + dateSubPage, dateSubPage))
    targetSet = true;
  }

  if (date) {
    const f = targetSet ? link : target;
    llist.unshift(f(fmtDay(year, month, date), DateTime.local(year, month, date).toFormat('EEEE, dd')));
    targetSet = true;
  }

  if (week) {
    const f = targetSet ? link : target;
    const prefix = month === 1 && week > 50 ? 'fw' : '';
    llist.unshift(f(prefix + 'Week ' + week, 'Week ' + week));
    targetSet = true;
  }

  if (month) {
    const f = targetSet ? slink : starget;
    let monthToken = f(DateTime.local(year, month, 1).toFormat('MMMM'));
    nextMonthOverlap && (monthToken += ' / ' + f(DateTime.local(year, month + 1, 1).toFormat('MMMM')));
    llist.unshift(monthToken);
    targetSet = true;
  }

  if (quarter) {
    const f = targetSet ? slink : starget;
    let quarterToken = f('Q' + quarter);
    nextQuarterOverlap && (quarterToken += ' / ' + f('Q' + (quarter + 1)))
    llist.unshift(quarterToken);
    targetSet = true;
  }

  const f = targetSet ? slink : starget;
  llist.unshift(f(String(year)));

  if (!targetSet) {
    llist.push(range(1, 5).map(i => slink('Q' + i)).join('\\quad{}'))
  }

  switch (rs.level) {
    case "month":
      rs.left && rlist.push(slink(DateTime.local(year, month - 1, 1).toFormat('MMMM')));
      rs.right && rlist.push(slink(DateTime.local(year, month + 1, 1).toFormat('MMMM')));
      break;

    case 'week':
      const prefix = rs.left && week === 1 ? 'fw' : '';
      const prevWeek = week - 1 <= 0 ? DateTime.local(year - 1, 12, 31).weekNumber : week - 1;
      const nextWeek = month === 1 && week > 50 ? 1 : week + 1;
      rs.left && rlist.push(link(prefix + 'Week ' + prevWeek, 'Week ' + prevWeek));
      rs.right && rlist.push(slink('Week ' + nextWeek))
      break;
  }

  return `{%
    \\noindent\\Large%
    \\renewcommand{\\arraystretch}{\\myNumArrayStretch}%
    \\begin{tabular}{|${new Array(llist.length).fill('l').join(' | ')}}
        ${llist.join(' & ')}
    \\end{tabular}
    \\hfill%
    ${!rlist ? '' : `\\begin{tabular}{${new Array(rlist.length).fill('r').join(' | ')}@{}}
      ${rlist.join(' & ')}
      \\end{tabular}
    `}
}
\\myHfillThick\\medskip`
}