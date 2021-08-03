const moment = require('moment');
const funcs = require('../common/funcs');
const ls = require('./latexsnips');

const weekly = (year, curr, prevnext, ddd) => {
  const fw = ddd === 1 ? 'fw' : '';
  const weekStart = curr.clone();
  curr.subtract(1, 'day');
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').clone());

  let monthName = ls.slink(weekStart.add(1, 'day').format('MMMM'));
  const lastDay = ls.slink(curr.format('MMMM'));
  if (monthName !== lastDay) {
    monthName += ' / ' + lastDay;
  }

  const isoWeek = weekStart.isoWeek();
  const quarter = isoWeek > 50 && ddd < 8 ? 1 : Math.floor(weekStart.month() / 3) + 1
  const dm = dates
    .map((v, i) => ({[i + 1]: ls.link(dates[i].format('yyyyMMDD'), v.date() + ' ' + weekDays[i])}))
    .reduce((acc, val) => Object.assign(acc, val));


  const ref = `${fw}Week ${isoWeek}`
  const name = `Week ${isoWeek}`
  const leftList = [ls.slink(year), ls.slink(`Q${quarter}`), monthName, ls.target(ref, name)];
  const rightList = ddd !== 8
    ? prevnext.map(d => ls.slink(`Week ${d.isoWeek()}`))
    : [
      ls.link(`fwWeek ${prevnext[0].isoWeek()}`, `Week ${prevnext[0].isoWeek()}`),
      ls.slink(`Week ${prevnext[1].isoWeek()}`)
    ];

  return `${ls.header(leftList, rightList)}

${funcs.interpolateTpl('weekly', dm)}`
}

const weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const weeklies = year => {
  const arr = [];

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

module.exports.weekly = weekly;
module.exports.weeklies = weeklies;
