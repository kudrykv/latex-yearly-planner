const fs = require('fs');

export const makeRow = <T>(row: Array<T>): string => row.join(' & ');

export const fmtDay = (year: number, month: number, date: number): string =>
  `${year}${('' + (month + 1)).padStart(2, '0')}${('' + date).padStart(2, '0')}`;

export const interpolateTpl = (tplName: string, dict: Record<string, any>): string => {
  let snip = fs.readFileSync(`texsnippets/${tplName}.snip.tex`).toString();

  Object.keys(dict).forEach(key => {
    snip = snip.replaceAll('<' + key + '>', dict[key]);
  })

  return snip;
};

export const range = (start: number, end: number) =>
  new Array(end - start).fill(undefined).map((_, i) => start + i);
