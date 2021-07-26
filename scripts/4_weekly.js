const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const weekly = (curr) => {
  const weekStart = curr.clone().subtract(1, 'day');
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').date());

  let monthName = weekStart.add(1, 'day').format('MMMM');
  const lastDay = curr.format('MMMM');
  if (monthName !== lastDay) {
    monthName +=' / ' + lastDay;
  }

  const isoWeek = weekStart.isoWeek();
  const quarter = isoWeek === 53 ? 1 : Math.floor(weekStart.month() / 3)+1
  return `${ls.header([curr.year(), `Q${quarter}`, monthName, `Week ${isoWeek}`])}

\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[0]} Monday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLines}{\\myLineOrd}%
}
\\hspace{0.5em}
\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[1]} Tuesday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLines}{\\myLineOrd}%
}
\\vfill
\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[2]} Wednesday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLines}{\\myLineOrd}%
}
\\hspace{0.5em}
\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[3]} Thursday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLines}{\\myLineOrd}%
}
\\vfill
\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[4]} Friday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLines}{\\myLineOrd}%
}
\\hspace{0.5em}
\\parbox{\\dimexpr.5\\linewidth-.5em}{%
\\myUnderline{${dates[5]} Saturday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLinesSaturday}{\\myLineOrd}\\vskip3pt
\\myUnderline{${dates[6]} Sunday}\\vskip\\myHBL\\myRepeat{\\myWeeklyLinesSunday}{\\myLineOrd}
}
\\pagebreak`
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
