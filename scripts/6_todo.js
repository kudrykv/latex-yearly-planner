const funcs = require('./funcs');
const ls = require('./latexsnips');

const todos = (year) => {
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
  const todoPages = funcs
    .range(0, 100)
    .map(num => {
      const page = funcs.interpolateTpl('todoPage', {});

      return `${ls.header([ls.slink(year), ls.slink(refText), ls.starget(`To Do ${num+1}`)])}${page}`;
    }).join('\\pagebreak\n')

  return `${ls.header([ls.slink(year), ls.starget(refText)])}
${funcs.interpolateTpl('todoIndex', {table})}
\\pagebreak
${todoPages}
`;
};

module.exports.todos = todos;
