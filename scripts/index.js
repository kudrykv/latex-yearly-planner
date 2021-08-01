const fs = require('fs');
const funcs = require('./funcs');
const t = require('./10_title');
const act = require('./1_annual');
const q = require('./2_quarterly');
const m = require('./3_monthly');
const w = require('./4_weekly');
const d = require('./5_daily');
const td = require('./6_todo');
const nt = require('./7_notes');

const year = Number(process.env.PLANNER_YEAR);
if (!year) {
  throw new Error('PLANNER_YEAR must exist and define a year');
}

fs.writeFileSync('tex/title.tex', t.title(year));

fs.writeFileSync('tex/year.tex', act.annualTable(year, true))

fs.writeFileSync('tex/quarterlies.tex', funcs.range(0, 4).map(qn => q.quarter(year, qn)).join('\n'));

fs.writeFileSync('tex/monthlies.tex', funcs.range(0, 12).map(mn => m.monthly(year, mn)).join('\n\\pagebreak\n'))

fs.writeFileSync('tex/weeklies.tex', w.weeklies(year));

fs.writeFileSync('tex/dailies.tex', d.dailySchedule(year));

fs.writeFileSync('tex/todos.tex', td.todos(year));

fs.writeFileSync('tex/notes.tex', nt.notes(year));
