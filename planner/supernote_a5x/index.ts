const fs = require('fs');
const funcs = require('../common/funcs');
const t = require('../common/10_title');
const act = require('./20_annual');
const q = require('./30_quarterly');
const m = require('./40_monthly');
const w = require('./50_weekly');
const d = require('./60_daily');
const td = require('./70_todo');
const nt = require('./80_notes');

const year = Number(process.env.PLANNER_YEAR);
if (!year) {
  throw new Error('PLANNER_YEAR must exist and define a year');
}

['planner_supernote_a5x', 'macros', 'macros_supernote_a5x'].forEach(name => {
  fs.copyFileSync(`textpl/${name}.tex`, `out/${name}.tex`);
})

fs.writeFileSync('out/title.tex', t.title(year));
fs.writeFileSync('out/year.tex', act.annualTable({year}))
fs.writeFileSync('out/quarterlies.tex', funcs.range(0, 4).map(qn => q.quarter(year, qn)).join('\n'));
fs.writeFileSync('out/monthlies.tex', funcs.range(0, 12).map(mn => m.monthly(year, mn)).join('\n\\pagebreak\n'))
fs.writeFileSync('out/weeklies.tex', w.weeklies(year));
fs.writeFileSync('out/dailies.tex', d.dailySchedule(year));
fs.writeFileSync('out/todos.tex', td.todos(year));
fs.writeFileSync('out/notes.tex', nt.notes(year));
