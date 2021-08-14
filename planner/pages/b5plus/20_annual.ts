import {fancyHeader} from "../../common/texblocks/fancyHeader";

const {range, interpolateTpl} = require('../../common/blocks/funcs');
const ls = require('../../common/texblocks/latexsnips');

interface AnnualTableConfig {
  year: number;
  weeks?: boolean;
  weekStart?: 1 | 7;
}

export const annualTable = ({year, weeks = true, weekStart = 1}: AnnualTableConfig) => {
  const tabulars = range(0, 4)
    .map(qrtr => rowOfMonths({year, qrtr, weeks, weekStart}))
    .map(row => tabularify(3, row))
    .join('\n\\vfill\n');

  return `${fancyHeader({year}, {level: 'none'})}\n${tabulars}`
}

interface RowOfMonthsConfig extends AnnualTableConfig {
  qrtr: number;
}

const rowOfMonths = ({year, qrtr, weeks, weekStart}: RowOfMonthsConfig) =>
  range(qrtr * 3, qrtr * 3 + 3)
    .map(mth => ls.monthlyTabular({year, month: mth + 1, weeks, weekStart}))
    .join(' & ');

const tabularify = (columns, content) => interpolateTpl('calRow', {columns, content});
