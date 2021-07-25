const moment = require('moment');
const m = require('./month');
const ls = require('./latexsnips');

const monthly = (year, month) => {
  let calendar = m
    .monthMonday(year, month)
    .map(row => row.map(corner))

  const date = new Date(year, month, 1);
  let startingWeek = moment(date).week()
  calendar.forEach(row => {
    row.unshift(rotateWeek(startingWeek));
    startingWeek++;
  })

  calendar = calendar.map(row => row.join(' &\n')).join(' \\\\ \\hline\n') + '\\\\ \\hline';
  const weekdays = getWeekdays().map(day => `\\hfil ${day}`).join(' & ');

  return `${ls.header([year, `Q${Math.floor(month / 3)+1}`, date.toLocaleString('default', {month: 'long'})])}

\\noindent\\begin{tabularx}{\\textwidth}{@{}l!{\\vrule width 1pt}*{7}{@{}X@{}|}}
\\noalign{\\hrule height 1pt}
 & ${weekdays} \\\\ \\noalign{\\hrule height 1pt}
${calendar}
\\end{tabularx}
\\medskip

{Notes\\hfil{}\\quad{}Notes}\\par\\vskip-5pt
\\leavevmode\\leaders\\hrule height 1pt\\hfill\\kern0pt%
\\quad%
\\leavevmode\\leaders\\hrule height 1pt\\hfill\\kern0pt\\par
\\ \\par
\\leaders\\hbox{\\parbox{\\textwidth}{%
\\hrulefill%
\\quad%
\\hrulefill\\vskip 5mm}} \\vfill
`;
}

const rotateWeek = weekNum => `\\rotatebox[origin=tr]{90}{\\makebox[55pt][c]{Week ${weekNum}}}`

const getWeekdays = () => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const corner = (num) => {
  if (!num && num !== 0) return '';

  return `\\begin{tabular}{@{}p{5mm}@{}|}\\hfil${num}\\\\\\hline\\end{tabular}`;
}

module.exports.monthly = monthly;

console.log(monthly(2021, 7))
