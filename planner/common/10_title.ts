const {interpolateTpl} = require('./funcs');

export const title = (year: number): string =>
  interpolateTpl('title', {year});