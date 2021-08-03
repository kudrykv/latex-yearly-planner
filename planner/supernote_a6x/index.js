const fs = require('fs');
const funcs = require('../common/funcs');
const t = require('../common/10_title');

const year = Number(process.env.PLANNER_YEAR);
if (!year) {
  throw new Error('PLANNER_YEAR must exist and define a year');
}

['planner_supernote_a6x', 'macros', 'macros_supernote_a6x'].forEach(name => {
  fs.copyFileSync(`textpl/${name}.tex`, `out/${name}.tex`);
})

fs.writeFileSync('out/title.tex', t.title(year));
