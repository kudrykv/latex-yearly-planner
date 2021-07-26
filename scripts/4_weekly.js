const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const weekly = (curr) => {
  const weekStart = curr.clone().subtract(1, 'day');
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').date());

  let monthName = ls.slink(weekStart.add(1, 'day').format('MMMM'));
  const lastDay = ls.slink(curr.format('MMMM'));
  if (monthName !== lastDay) {
    monthName +=' / ' + lastDay;
  }

  const isoWeek = weekStart.isoWeek();
  const quarter = isoWeek === 53 ? 1 : Math.floor(weekStart.month() / 3)+1
  const dm = dates.map((v, i) => ({[i+1]: v})).reduce((acc, val) => Object.assign(acc, val));
  return `${ls.header([ls.slink(curr.year()), ls.slink(`Q${quarter}`), monthName, ls.starget(`Week ${isoWeek}`)])}

${funcs.interpolateTpl('weekly', dm)}`
}

const weeklies = year => {
  const arr = [];

  const curr = moment().year(year).month(0).week(1);
  for (let i = 1; i < 366; i += 7) {
    arr.push(weekly(curr.clone()));
    curr.add(1, 'week');
  }

  return arr.join('\n\n')
};

module.exports.weekly = weekly;
module.exports.weeklies = weeklies;
