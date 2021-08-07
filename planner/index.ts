import {EnvConfig} from './common/blocks/envConfig';

const {envConfig} = require('./common/blocks/envConfig');

interface Vendor {
  buildFiles(envConfig: EnvConfig);
}

let vendor: Vendor;
try {
  vendor = require('./vendors/'+envConfig.vendor);
} catch (e) {
  throw new Error('Cannot load vendor: ' + e);
}

vendor.buildFiles(envConfig);
