const {interpolateTpl} = require('../blocks/funcs');

export const title = (year: number): string =>
  interpolateTpl('title', {year});