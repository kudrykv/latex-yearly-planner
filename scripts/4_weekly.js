const moment = require('moment');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const weekly = (year, weekNumber) => {
  const weekStart = moment().day('Monday').week(weekNumber).year(year).subtract(1, 'day');
  const curr = moment(weekStart);
  const dates = funcs.range(0, 7).map(() => curr.add(1, 'day').date());

  let monthName = weekStart.add(1, 'day').format('MMMM');
  const lastDay = curr.format('MMMM');
  if (monthName !== lastDay) {
    monthName += ' / ' + lastDay;
  }

  return `${ls.header([year, `Q${Math.floor(weekStart.month() / 3)+1}`, monthName, `Week ${weekStart.week()}`])}

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
  const lastWeek = moment().year(year+1).week(1).subtract(1, 'week').week();

  return funcs.range(1, lastWeek+1).map(week => weekly(year, week)).join('\\pagebreak\n\n');
};

module.exports.weekly = weekly;
module.exports.weeklies = weeklies;
