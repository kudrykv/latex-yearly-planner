const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const dailySchedule = (year) => {
  let ptr = moment().year(year).month(0).date(0);
  let last = moment().year(year + 1).month(0).date(0).dayOfYear() + 1;

  return funcs
    .range(1, last)
    .map(() => ptr.add(1, 'day') && [ptr.year(), 'Q'+Math.floor((ptr.month() / 3)+1), ptr.format('MMMM'), ptr.format('dddd, D')])
    .map(hh => dayTemplate(hh))
    .join('\n');
};

const dayTemplate = hh => {
  const shedule = funcs
    .range(6, 23)
    .map(h => `\\myLinePlain\\myLineHBL${h}\\par\\myLinePlain\\vskip\\myHBL`)
    .join('');

  return `${ls.header(hh)}
\\parbox[t]{\\dimexpr0.5\\linewidth-0.5em}{%
    \\myUnderline{To Do}
    \\myRepeat{16}{\\myLineHBL$\\square$\\myLinePlain}
    \\vskip \\dimexpr7mm-1.6pt
    \\myUnderline{Notes}
    \\myLineHBL\\par
    \\myRepeat{16}{\\myLineOrd}
}
\\hspace{0.5em}
\\parbox[t]{\\dimexpr0.5\\linewidth-0.5em}{%
    \\myUnderline{Schedule}\\vskip-0.4pt
    ${shedule}
    \\myLinePlain
}`;
}

module.exports.dailySchedule = dailySchedule;
