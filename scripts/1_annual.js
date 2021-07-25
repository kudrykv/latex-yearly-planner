const moment = require('moment');
const m = require('./month');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const rowOfMonths = (year, qrtr, weeks) =>
  funcs.range(qrtr * 3, qrtr * 3 + 3).map(mth => monthTabular(year, mth, weeks)).join(' & ');

const tabularify = (cols, content) =>
  `\\begin{tabularx}{\\linewidth}{@{}${new Array(cols).fill('X').join('')}@{}}\n${content}\n\\end{tabularx}`

const annualTable = (year, weeks) => {
  const tabulars = funcs.range(0, 4)
    .map(q => rowOfMonths(year, q, weeks))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  return `${ls.header([year, 'Q1\\quad{}Q2\\quad{}Q3\\quad{}Q4'])}\n${tabulars}`
}

const monthTabular = (year, month, weeks = false) => {
  let calendar = m.monthMonday(year, month)
    .map(stringifyWeekNumbers);

  const columns = weeks ? 8 : 7;

  if (weeks) {
    let daynum = 1;
    let startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    calendar.forEach(row => {
      row.unshift(startingWeek);
      daynum+=7;
      startingWeek = moment(new Date(year, month, daynum)).isoWeek();
    })
  }

  calendar = calendar.map(joinWeekDays).join(' \\\\\n');

  const date = new Date(year, month, 1);

  return `{\\renewcommand{\\arraystretch}{1.5}\\setlength{\\tabcolsep}{3.5pt}%
    \\begin{tabular}[t]{${weeks ? 'c |' : ''} c c c c c c >{\\bf}c}
    \\multicolumn{${columns}}{c}{${date.toLocaleString('default', {month: 'long'})}} \\\\
    ${weeks ? 'W & ' : ''}M & T & W & T & F & S & S \\\\
${funcs.indent(calendar)}
\\end{tabular}}`
}

const stringifyWeekNumbers = row => row.map(item => item > 0 ? '' + item : '')
const joinWeekDays = row => row.join(' & ')

module.exports.annualTable = annualTable;
module.exports.monthTabular = monthTabular;

console.log(monthTabular(2021, 7, true))
