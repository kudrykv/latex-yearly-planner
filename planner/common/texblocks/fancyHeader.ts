import {DateTime} from "luxon";
import {fmtDay, range} from "../blocks/funcs";
import {link, slink, starget, target} from "./latexsnips";

interface LeftStackConfig {
  year: number;
  quarter?: number;
  allQuarters?: boolean;
  nextQuarterOverlap?: boolean;
  month?: number;
  nextMonthOverlap?: boolean;
  week?: number;
  date?: number;
  dateSubPage?: string;
}

type Level = 'none' | 'month' | 'week' | 'date' | SubLevel;
type SubLevel = 'Note' | 'Reflect';

interface RightStackConfig {
  left?: boolean;
  right?: boolean;
  level: Level;
}

export const fancyHeader = (ls: LeftStackConfig, rs: RightStackConfig): string => {
  const {year, quarter, allQuarters, nextQuarterOverlap, month, nextMonthOverlap, week, date, dateSubPage} = ls;
  const llist = [];
  const rlist = [];
  let targetSet = false;
  let shorter = false;

  if (dateSubPage) {
    llist.unshift(target(fmtDay(year, month, date) + dateSubPage, dateSubPage))
    targetSet = true;
    shorter = process.env.ALLOW_SHORTER_BREADCRUMB === 'true';
  }

  if (date) {
    const f = targetSet ? link : target;
    const refDate = fmtDay(year, month, date);
    const dateTimeDate = DateTime.local(year, month, date);
    const dateFormat = shorter ? 'EEE, d' : 'EEEE, d';
    llist.unshift(f(refDate, dateTimeDate.toFormat(dateFormat)));
    targetSet = true;
  }

  if (process.env.DISABLE_WEEKS !== 'true' && week) {
    const f = targetSet ? link : target;
    const prefix = month === 1 && week > 50 ? 'fw' : '';
    llist.unshift(f(prefix + 'Week ' + week, 'Week ' + week));
    targetSet = true;
  }

  if (month) {
    const f = targetSet ? slink : starget;
    const formatMonth = shorter ? 'MMM' : 'MMMM';
    let monthToken = f(DateTime.local(year, month, 1).toFormat(formatMonth));
    nextMonthOverlap && (monthToken += ' / ' + f(DateTime.local(year, month + 1, 1).toFormat(formatMonth)));
    llist.unshift(monthToken);
    targetSet = true;
  }

  if (quarter) {
    if (allQuarters) {
      const token = range(1, 5)
        .map(
          i =>
            i === quarter
              ? target('Q' + i, '\\textbf{Q' + i + '}')
              : slink('Q' + i))
        .join('\\quad{}');
      llist.unshift(token);
    } else {
      const f = targetSet ? slink : starget;
      let quarterToken = f('Q' + quarter);
      nextQuarterOverlap && (quarterToken += ' / ' + f('Q' + (quarter + 1)))
      llist.unshift(quarterToken);
    }

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

    case 'date':
      const moment = DateTime.local(year, month, date);
      const left = moment.minus({day: 1});
      const right = moment.plus({day: 1});

      rs.left && rlist.push(link(left.toFormat('yyyyMMdd'), left.toFormat('EEE, d')));
      rs.right && rlist.push(link(right.toFormat('yyyyMMdd'), right.toFormat('EEE, d')));
      break;

    case 'Note':
    case 'Reflect':
      const submoment = DateTime.local(year, month, date);
      const subleft = submoment.minus({day: 1});
      const subright = submoment.plus({day: 1});

      rs.left && rlist.push(link(subleft.toFormat('yyyyMMdd') + rs.level, subleft.toFormat('EEE, d')));
      rs.right && rlist.push(link(subright.toFormat('yyyyMMdd') + rs.level, subright.toFormat('EEE, d')));
      break;

    case 'none':
      rlist.push(link('To Do Index', 'Todos'), link('Notes Index', 'Notes'));
  }

  if (process.env.RM2_VANILLA === 'true') {
    rlist.push('\\hspace*{7mm}');
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