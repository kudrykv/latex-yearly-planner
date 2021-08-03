const {interpolateTpl} = require('./funcs');

const title = year => interpolateTpl('title', {year});

module.exports.title = title;