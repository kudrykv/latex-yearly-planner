const monthMonday = (year, month) => {
  const anchor = new Date(year, month + 1, 0);
  const days = anchor.getDate();
  let day = new Date(year, month, 1).getDay() - 1;
  day = day < 0 ? 6 : day;

  let s = new Array(day).fill(undefined);
  s = s.concat(...Array(7 - day).keys()).map(k => k >= 0 ? k + 1 : k);

  let ss = [s];
  let p = 8 - day;

  for (let i = 0; i < Math.floor(days / 7); i++) {
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

module.exports.monthMonday = monthMonday;
