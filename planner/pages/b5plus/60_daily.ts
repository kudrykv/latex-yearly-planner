import {DateTime} from "luxon";
import {fancyHeader} from "../../common/texblocks/fancyHeader";
import {link} from "../../common/texblocks/latexsnips";

const funcs = require('../../common/blocks/funcs');

export const dailySchedule = (year: number) => {
  let ptr = DateTime.local(year, 1, 1).minus({day: 1});
  const last = ptr.daysInYear + 1;

  return funcs
    .range(1, last)
    .map(() => {
      ptr = ptr.plus({day: 1});
      const {quarter, month, weekNumber, day} = ptr;

      return [
        {year, quarter, month, week: weekNumber, date: day},
        {level: 'date', left: month > 1 || (month === 1 && day > 1), right: month < 12 || (month === 12 && day < 31)},
        ptr
      ];
    })
    .map(([ls, rs, ptr]) => dayTemplate(ls, rs, ptr))
    .join('\n');
};

const dayTemplate = (ls, rs, ptr) => {
  const refFormat = ptr.toFormat('yyyyMMdd');

  const lsNote = {...ls, dateSubPage: 'Note'}
  const rsNote = {...rs, level: 'Note'}

  const lsDiary = {...ls, dateSubPage: 'Reflect'}
  const rsDiary = {...rs, level: 'Reflect'}

  const dailySchedule = funcs.interpolateTpl('daily', {
    dailyNotes: link(refFormat + 'Note', 'More'),
    dailyDiary: link(refFormat + 'Reflect', 'Reflect'),
    allNotes: link('Notes Index', 'All notes'),
    allTodos: link('To Do Index', 'All todos')
  });

  return `${fancyHeader(ls, rs)}
${dailySchedule}\\pagebreak
${fancyHeader(lsNote, rsNote)}
${funcs.interpolateTpl('dailyNotes', {})}\\pagebreak
${fancyHeader(lsDiary, rsDiary)}
${funcs.interpolateTpl('dailyDiary', {})}\\pagebreak`;
}
