export const header = (llist: Array<any>, rlist: Array<any>): string =>
  `{%
    \\noindent\\Large%
    \\renewcommand{\\arraystretch}{\\myNumArrayStretch}%
    \\begin{tabular}{|${new Array(llist.length).fill('l').join(' | ')}}
        ${llist.join(' & ')}
    \\end{tabular}
    \\hfill%
    ${!rlist ? '' : `\\begin{tabular}{${new Array(rlist.length).fill('r').join(' | ')}@{}}
      ${rlist.join(' & ')}
      \\end{tabular}
    `}
}
\\myHfillThick\\medskip`;

export const link = (ref: string, text: string): string =>
  `\\hyperlink{${ref}}{${text}}`;

export const slink = (reftext: string): string =>
  `\\hyperlink{${reftext}}{${reftext}}`;

export const target = (ref: string, text: string): string =>
  `\\hypertarget{${ref}}{${text}}`;

export const starget = (reftext: string): string =>
  `\\hypertarget{${reftext}}{${reftext}}`;

export const tabularx = ({
  colSetup,
  hlines,
  matrix
}: { colSetup: string, hlines: boolean, matrix: Array<Array<string>> }): string => {
  const hline = hlines ? '\\hline' : '';

  return `\\begin{tabularx}{\\linewidth}{${colSetup}}
${hline}
${matrix.map(row => row.join(' & ')).join(`\\\\ ${hline} \n`)} ${hlines ? '\\\\ \\hline \n' : ''}
\\end{tabularx}`
}