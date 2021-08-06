const funcs = require('../common/funcs');
const ls = require('../common/latexsnips');

export const todos = (year) => {
  const table = ls.tabularx({
    hlines: true,
    colSetup: '|@{}' + (new Array(10).fill('X').join('@{}|@{}')) + '@{}|',
    matrix: funcs
      .range(0, 10)
      .map(
        i => funcs
          .range(i * 10 + 1, i * 10 + 11)
          .map(
            num => funcs
              .interpolateTpl(
                'monthlyCornerDate',
                {date: ls.link(`To Do ${num}`, num)}) + '\\vspace{1.35cm}'
          )
      )
  });

  const refText = 'To Do Index';
  const rightList = [ls.link('Notes Index', 'Notes')];

  const todoPages = funcs
    .range(0, 100)
    .map(num => {
      const page = funcs.interpolateTpl('todoPage', {});

      const leftList = [ls.slink(year), ls.slink(refText), ls.starget(`To Do ${num + 1}`)];
      return `${ls.header(leftList, rightList)}${page}`;
    }).join('\\pagebreak\n')

  return `${ls.header([ls.slink(year), ls.starget(refText)], rightList)}
${funcs.interpolateTpl('todoIndex', {table})}
\\pagebreak
${todoPages}
`;
};
