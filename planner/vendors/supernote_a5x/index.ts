import {EnvConfig} from "../../common/blocks/envConfig";

const fs = require('fs');
const funcs = require('../../common/blocks/funcs');
const t = require('../../common/texblocks/title');
const act = require('../../pages/b5plus/20_annual');
const q = require('../../pages/b5plus/30_quarterly');
const m = require('../../pages/b5plus/40_monthly');
const w = require('../../pages/b5plus/50_weekly');
const d = require('../../pages/b5plus/60_daily');
const td = require('../../pages/b5plus/70_todo');
const nt = require('../../pages/b5plus/80_notes');

export const buildFiles = (cfg: EnvConfig): void => {
  const {year, weekStart, disableWeeks} = cfg;
  ['preamble', 'supernote_a5x', 'macros', 'macros_supernote_a5x'].forEach(name => {
    fs.copyFileSync(`textpl/${name}.tex`, `out/${name}.tex`);
  })

  fs.writeFileSync('out/title.tex', t.title(year));
  fs.writeFileSync('out/year.tex', act.annualTable({year, weekStart, weeks: !disableWeeks}))
  fs.writeFileSync('out/quarterlies.tex', funcs.range(1, 5).map(quarter => q.quarter({
    year,
    quarter,
    weekStart,
    weeks: !disableWeeks
  })).join('\n'));
  fs.writeFileSync('out/monthlies.tex', funcs.range(0, 12).map(mn => m.monthlyPage({
    year,
    month: mn,
    weekStart,
    weeks: !disableWeeks
  })).join('\n\\pagebreak\n'))
  fs.writeFileSync('out/weeklies.tex', w.weeklies(year));
  fs.writeFileSync('out/dailies.tex', d.dailySchedule(year));
  fs.writeFileSync('out/todos.tex', td.todos(year));
  fs.writeFileSync('out/notes.tex', nt.notes(year));
}
