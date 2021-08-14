import {fancyHeader} from "../../common/texblocks/fancyHeader";

const {range, interpolateTpl} = require('../../common/blocks/funcs');
const {monthlyTabular, link, header, slink, target} = require('../../common/texblocks/latexsnips');

interface QuarterConfig {
  year: number;
  quarter: number;
  weeks?: boolean;
  weekStart?: 1 | 7;
}

export const quarter = ({year, quarter, weeks = true, weekStart = 1}: QuarterConfig): string => {
  const hdr2 = fancyHeader({year, quarter, allQuarters: true}, {level: 'none'});

  const tabulars = range((quarter - 1) * 3 + 1, (quarter - 1) * 3 + 4)
    .map(qq => {
      const calendar = monthlyTabular({year, month: qq, weeks, weekStart});
      return interpolateTpl('qrtrRow', {calendar});
    });

  return `${hdr2}\n\n${tabulars.join('\\vfill')}\\pagebreak\n`
}
