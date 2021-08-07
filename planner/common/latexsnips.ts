const {DateTime} = require('luxon');
const {fmtDay, interpolateTpl, makeRow} = require('./funcs');
const m = require('./month');

export const header = (llist: Array<any>, rlist: Array<any>): string =>
  `{%
    \\noindent\\Large%
    \\renewcommand{\\arraystretch}{\\myNumArrayStretch}%
    \\begin{tabular}{|${new Array(llist.length).fill('l').join(' | ')}}
        ${llist.join(' & ')}
    \\end{tabular}
    \\hfill%
    ${!rlist ? '' : `\\begin{tabular}{${new Array(rlist.length).fill('r').join(' | ')}@{}}
      ${rlist.join(' & ')}
      \\end{tabular}
    `}
}
\\myHfillThick\\medskip`;

export const link = (ref: string, text: string): string =>
  `\\hyperlink{${ref}}{${text}}`;

export const slink = (reftext: string): string =>
  `\\hyperlink{${reftext}}{${reftext}}`;

export const target = (ref: string, text: string): string =>
  `\\hypertarget{${ref}}{${text}}`;

export const starget = (reftext: string): string =>
  `\\hypertarget{${reftext}}{${reftext}}`;

export const tabularx = ({
  colSetup,
  hlines,
  matrix
}: { colSetup: string, hlines: boolean, matrix: Array<Array<string>> }): string => {
  const hline = hlines ? '\\hline' : '';

  return `\\begin{tabularx}{\\linewidth}{${colSetup}}
${hline}
${matrix.map(row => row.join(' & ')).join(`\\\\ ${hline} \n`)} ${hlines ? '\\\\ \\hline \n' : ''}
\\end{tabularx}`
}

const linkifyWeekNumbers = (month: number, item: number): string =>
  month === 1 && item > 50
    ? link('fwWeek ' + item, String(item))
    : link('Week ' + item, String(item));

const linkifyDays = (year: number, month: number, row: number[]): string[] =>
  row.map(date => !date ? '' : link(fmtDay(year, month, date), String(date)));

export const monthlySemiFinished = ({
  year,
  month,
  weeks = true,
  weekStart = 1
}: { year: number, month: number, weeks?: boolean, weekStart?: 1 | 7 }) => {
  let cal = m.month(year, month, weekStart);

  if (weeks) {
    cal.forEach(row => {
      const day = row.find(day => day && DateTime.local(year, month, day).weekday === 1) || row.find(item => item);
      row.unshift(DateTime.local(year, month, day).weekNumber)
    });

    if (cal[cal.length-2][0] === cal[cal.length-1][0]) {
      cal[cal.length-1][0]++
    }
  }

  return cal
    .map(row => {
      const daysRow = weeks ? row.slice(1) : row;
      const linkifiedDays = linkifyDays(year, month, daysRow);
      return weeks ? [row[0], ...linkifiedDays] : linkifiedDays;
    });
}

export const monthlyTabular = ({
  year,
  month,
  weeks = true,
  weekStart = 1
}: { year: number, month: number, weeks?: boolean, weekStart?: 1 | 7 }): string => {
  const calendar = monthlySemiFinished({year, month, weeks, weekStart})
    .map(row => weeks ? [linkifyWeekNumbers(month, row[0]), ...row.slice(1)] : row)
    .map(makeRow)
    .join('\\\\ \n')

  return interpolateTpl('calendar', {
    monthName: slink(DateTime.local(year, month).monthLong),
    colWeek: weeks ? 'c|' : '',
    colSetup: weekStart === 1 ? 'c'.repeat(6) + '>{\\bf}c' : '>{\\bf}c' + 'c'.repeat(6),
    weekColumn: weeks ? 'c | ' : '',
    columns: weeks ? 8 : 7,
    weekTag: weeks ? 'W &' : '',
    weekLayout: weekStart === 1 ? 'M & T & W & T & F & S & S' : 'S & M & T & W & T & F & S',
    calendar
  });
};

export const monthlyCalContents = ({
  year,
  month,
  weeks = true,
  weekStart = 1
}: { year: number, month: number, weeks?: boolean, weekStart?: 1 | 7 }): string => {
  let cal = monthlySemiFinished({year, month, weeks, weekStart});

  if (weeks) {
    cal = cal.map(row => [rotateWeek(month, row[0]), ...row.slice(1)]);
  }

  return cal
    .map(row => weeks ? [row[0], ...row.slice(1).map(corner)] : row.map(corner))
    .map(row => weeks ? row : row.map(item => item && item + '\\vspace{\\dimexpr\\myLenMonthlyCellHeight-\\baselineskip}'))
    .map(row => row.join(' &\n')).join(' \\\\ \\hline \n') + '\\\\ \\hline';
};

const rotateWeek = (month: number, weekNum: number): string => {
  const wn = month === 0 && weekNum > 50
    ? link('fwWeek ' + weekNum, 'Week ' + weekNum)
    : slink('Week ' + weekNum);

  return interpolateTpl('rotatedWeekNum', {weekNum: wn})
}

const corner = (date: string): string => {
  return date ? interpolateTpl('monthlyCornerDate', {date}) : '';
}

