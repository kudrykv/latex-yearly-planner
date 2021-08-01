const funcs = require('./funcs');

const title = (year) => funcs.interpolateTpl('title', {year});

module.exports.title = title;