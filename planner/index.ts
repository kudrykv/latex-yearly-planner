import {EnvConfig} from './common/envConfig';

const {envConfig} = require('./common/envConfig');

interface Vendor {
  buildFiles(envConfig: EnvConfig)
}

let vendor: Vendor;
try {
  vendor = require('./vendors/'+envConfig.vendor);
} catch (e) {
  throw new Error('Cannot load vendor: ' + e);
}

vendor.buildFiles(envConfig);
