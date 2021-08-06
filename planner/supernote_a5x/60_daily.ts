const moment = require('moment');
const funcs = require('../common/funcs');
const ls = require('../common/latexsnips');

export const dailySchedule = (year) => {
  let ptr = moment().year(year).month(0).date(0);
  let last = moment().year(year + 1).month(0).date(0).dayOfYear() + 1;

  return funcs
    .range(1, last)
    .map(n => {
      ptr.add(1, 'day');

      const weekText = 'Week ' + ptr.isoWeek();
      const weekRef = n <= 7 && ptr.isoWeek() > 50
        ? 'fwWeek ' + ptr.isoWeek()
        : weekText;

      const llist = [
        ls.slink(ptr.year()),
        ls.slink('Q' + Math.floor((ptr.month() / 3) + 1)),
        ls.slink(ptr.format('MMMM')),
        ls.link(weekRef, weekText),
        ptr.clone(),
      ];

      const rlist = [];
      if (n > 1) {
        const prevDay = ptr.clone().subtract(1, 'day');
        const prevDayRef = prevDay.format('yyyyMMDD');
        const prevDayFmt = prevDay.format('ddd, DD');
        rlist.push(ls.link(prevDayRef, prevDayFmt));
      }

      if (n + 1 < last) {
        const nextDay = ptr.clone().add(1, 'day');
        const nextDayRef = nextDay.format('yyyyMMDD');
        const nextDayFmt = nextDay.format('ddd, DD');
        rlist.push(ls.link(nextDayRef, nextDayFmt));
      }

      return [llist, rlist];
    })
    .map(([hh, rlist]) => dayTemplate(hh.slice(0, 4), hh.pop(), rlist))
    .join('\n');
};

const dayTemplate = (hh, today, rlist) => {
  const schedule = funcs
    .range(6, 23)
    .map(h => `\\myLineOfColorGray\\myLineHBL${h}\\myLineOfColorLightGray\\vskip\\myHBL`)
    .join('');

  const refFormat = today.format('yyyyMMDD');
  const textFormat = today.format('dddd, D');
  const dailySchedule = funcs.interpolateTpl('daily', {
    schedule,
    dailyNotes: ls.link(refFormat + 'note', 'More'),
    dailyDiary: ls.link(refFormat + 'diary', 'Reflect'),
    allNotes: ls.link('Notes Index', 'All notes'),
    allTodos: ls.link('To Do Index', 'All todos')
  });

  return `${ls.header([...hh, ls.target(refFormat, textFormat)], rlist)}
${dailySchedule}\\pagebreak
${ls.header([...hh, ls.link(refFormat, textFormat), ls.target(refFormat + 'note', 'Notes')])}
${funcs.interpolateTpl('dailyNotes', {})}\\pagebreak
${ls.header([...hh, ls.link(refFormat, textFormat), ls.target(refFormat + 'diary', 'Reflect')])}
${funcs.interpolateTpl('dailyDiary', {})}\\pagebreak`;
}
