const moment = require('moment');
const m = require('./month');
const funcs = require('./funcs');
const ls = require('./latexsnips');

const annualTable = (year, weeks) => {
  const tabulars = funcs.range(0, 4).map(
    q => funcs.range(q * 3, q * 3 + 3)
      .map(month => monthTabular(year, month, weeks))
      .join('\n&\n')
  )
    .map(row => {
      return `\\noindent\\begin{tabularx}{\\textwidth}{@{}XXX@{}}
${row}
\\end{tabularx}
      `
    }).join('\n\\vfill\n');

  return `${ls.header([year, 'Q1\\quad{}Q2\\quad{}Q3\\quad{}Q4'])}

${tabulars}
\\smallskip`
}

const monthTabular = (year, month, weeks = false) => {
  let calendar = m.monthMonday(year, month)
    .map(stringifyWeekNumbers);

  const columns = weeks ? 8 : 7;

  if (weeks) {
    let startingWeek = moment(new Date(year, month, 1)).week()
    calendar.forEach(row => {
      row.unshift(startingWeek);
      startingWeek++;
    })
  }

  calendar = calendar
    .map(joinWeekDays)
    .join(' \\\\\n')

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
