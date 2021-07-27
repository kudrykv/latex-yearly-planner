const fs = require('fs');

module.exports.indent = (str, numSpaces = 4) =>
  str.split('\n').map(line => ' '.repeat(numSpaces) + line).join('\n');

module.exports.range = (start, end) =>
  new Array(end - start).fill().map((_, i) => start + i);

module.exports.stringifyRow = row => row.map(item => item > 0 ? '' + item : '');

module.exports.interpolateTpl = (tplName, dict) => {
  let snip = fs.readFileSync(`texsnippets/${tplName}.snip.tex`).toString();

  Object.keys(dict).forEach(key => {
    snip = snip.replaceAll('<'+key+'>', dict[key]);
  })

  return snip;
};

module.exports.formatDate = (year, month, date) =>
  `${year}${(''+(month+1)).padStart(2, '0')}${(''+date).padStart(2, '0')}`;
