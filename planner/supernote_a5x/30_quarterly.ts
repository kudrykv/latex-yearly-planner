const {range, interpolateTpl} = require('../common/funcs');
const {monthlyTabular, link, header, slink, target} = require('../common/latexsnips');

interface QuarterConfig {
  year: number;
  quarter: number;
  weeks?: boolean;
  weekStart?: 1 | 7;
}

export const quarter = ({year, quarter, weeks = true, weekStart = 1}: QuarterConfig): string => {
  const llist = [slink(year), qrtrs(quarter)];
  const rlist = [link('To Do Index', 'Todos'), link('Notes Index', 'Notes')];
  const hdr = header(llist, rlist);

  const tabulars = range((quarter - 1) * 3 + 1, (quarter - 1) * 3 + 4)
    .map(qq => {
      const calendar = monthlyTabular({year, month: qq, weeks, weekStart});
      return interpolateTpl('qrtrRow', {calendar});
    });

  return `${hdr}\n\n${tabulars.join('\\vfill')}\\pagebreak\n`
}


const qrtrs = (selected: number): string =>
  range(1, 5)
    .map(num => num === selected ? target('Q' + num, '\\textbf{Q' + num + '}') : slink('Q' + num))
    .join('\\quad{}');
