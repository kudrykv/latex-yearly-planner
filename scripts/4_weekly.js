const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const weekly = (curr) => {
  const weekStart = curr.clone().subtract(1, 'day');
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').date());

  let monthName = weekStart.add(1, 'day').format('MMMM');
  const lastDay = curr.format('MMMM');
  if (monthName !== lastDay && curr.month() > 0) {
    monthName += ' / ' + lastDay;
  }

  return `${ls.header([curr.year(), `Q${Math.floor(weekStart.month() / 3)+1}`, monthName, `Week ${weekStart.isoWeek()}`])}

\\begin{tabularx}{\\textwidth}{@{}XX@{}}
\\myUnderline{${dates[0]} Monday}\\vskip5mm\\myRepeat{\\myWeeklyLines}{\\myLineOrd} &
\\myUnderline{${dates[1]} Tuesday}\\vskip5mm\\myRepeat{\\myWeeklyLines}{\\myLineOrd}
\\end{tabularx}
\\vfill
\\begin{tabularx}{\\textwidth}{@{}XX@{}}
\\myUnderline{${dates[2]} Wednesday}\\vskip5mm\\myRepeat{\\myWeeklyLines}{\\myLineOrd} &
\\myUnderline{${dates[3]} Thursday}\\vskip5mm\\myRepeat{\\myWeeklyLines}{\\myLineOrd}
\\end{tabularx}
\\vfill
\\begin{tabularx}{\\textwidth}{@{}XX@{}}
\\myUnderline{${dates[4]} Friday}\\vskip5mm\\myRepeat{\\myWeeklyLines}{\\myLineOrd} &
  \\myUnderline{${dates[5]} Saturday}\\vskip5mm\\myRepeat{\\myWeeklyLinesSaturday}{\\myLineOrd}\\vskip3.5pt
  \\myUnderline{${dates[6]} Sunday}\\vskip5mm\\myRepeat{\\myWeeklyLinesSunday}{\\myLineOrd}
\\end{tabularx}
`
}

const weeklies = year => {
  const arr = [];

  for (let i = 1; i < 366; i += 7) {
    const curr = moment().year(year).dayOfYear(i);
    arr.push(weekly(curr));
  }

  return arr.join('\\pagebreak\n\n')
};

module.exports.weekly = weekly;
module.exports.weeklies = weeklies;
