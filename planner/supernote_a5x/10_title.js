const {interpolateTpl} = require('../common/funcs');

const title = (year) => interpolateTpl('title', {year});

module.exports.title = title;