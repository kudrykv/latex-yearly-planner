import {range} from "./funcs";

const {DateTime} = require('luxon');

export const monthMonday = (year: number, month: number): Array<Array<number | undefined | null>> => {
  const anchor = new Date(year, month + 1, 0);
  const days = anchor.getDate();
  let day = new Date(year, month, 1).getDay() - 1;
  day = day < 0 ? 6 : day;

  let s = new Array(day).fill(undefined);
  s = s.concat(...Array(7 - day).keys()).map(k => k >= 0 ? k + 1 : k);

  let ss = [s];
  let p = 8 - day;

  for (let i = p; i <= days; i += 7) {
    s = []

    if (p > days) break;

    for (let j = p; j < p + 7; j++) {
      s = s.concat(j <= days ? j : null)
    }

    ss.push(s);
    p += 7;
  }

  return ss;
}

/**
 *
 * @param year
 * @param month
 * @param weekStart what should be the first day of the week. 1 is Monday, 7 is Sunday
 */
export const month = (year: number, month: number, weekStart = 1): Array<Array<number | null>> => {
  const monthInfo = DateTime.local(year, month, 1);
  const daysInWeek = 7;
  const emptyDaysInFirstWeek = monthInfo.weekday - 1 + ((8 - weekStart) % daysInWeek);
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
