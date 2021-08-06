import {range} from "./funcs";

const {DateTime} = require('luxon');

/**
 *
 * @param year
 * @param month
 * @param weekStart what should be the first day of the week. 1 is Monday, 7 is Sunday
 */
export const month = (year: number, month: number, weekStart = 1): Array<Array<number | null>> => {
  const monthInfo = DateTime.local(year, month, 1);
  const daysInWeek = 7;
  const emptyDaysInFirstWeek = (monthInfo.weekday - 1 + ((8 - weekStart) % daysInWeek)) % daysInWeek;
  const daysInFirstWeek = daysInWeek - emptyDaysInFirstWeek;
  const remainingWeeks = Math.ceil((monthInfo.daysInMonth - daysInFirstWeek) / daysInWeek);

  const mth = [[
    ...range(0, emptyDaysInFirstWeek).fill(null),
    ...range(0, daysInFirstWeek).map((_, i) => i + 1)
  ]];

  range(0, remainingWeeks).forEach((_, week) => {
    mth.push(range(0, daysInWeek).map((_, idx) => daysInFirstWeek + week * daysInWeek + idx + 1));
  });

  const lastWeek = mth.length-1;
  mth[lastWeek] = mth[lastWeek]
    .map(day => day > monthInfo.daysInMonth ? null : day);

  return mth;
};
