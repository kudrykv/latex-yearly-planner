const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const dailySchedule = (year) => {
  let ptr = moment().year(year).month(0).date(0);
  let last = moment().year(year + 1).month(0).date(0).dayOfYear() + 1;

  return funcs
    .range(1, last)
    .map(() => ptr.add(1, 'day') && [
      ls.slink(ptr.year()),
      ls.slink('Q'+Math.floor((ptr.month() / 3)+1)),
      ls.slink(ptr.format('MMMM')),
      ls.slink('Week ' + ptr.isoWeek()),
      ls.target(ptr.format('yyyyMMDD'), ptr.format('dddd, D')),
    ])
    .map(hh => dayTemplate(hh))
    .join('\n');
};

const dayTemplate = hh => {
  const schedule = funcs
    .range(6, 23)
    .map(h => `\\myLinePlain\\myLineHBL${h}\\par\\myLinePlain\\vskip\\myHBL`)
    .join('');

  return `${ls.header(hh)}
${funcs.interpolateTpl('daily', {schedule})}`;
}

module.exports.dailySchedule = dailySchedule;
