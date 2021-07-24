module.exports.indent = (str, numSpaces = 4) =>
  str.split('\n').map(line => ' '.repeat(numSpaces) + line).join('\n');

module.exports.range = (start, end) =>
  new Array(end - start).fill().map((_, i) => start + i);

module.exports.stringifyRow = row => row.map(item => item > 0 ? '' + item : '')
