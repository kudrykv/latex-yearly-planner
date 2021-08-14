import {buildFiles} from "../rm2_ddvk";
import {copyFileSync} from "fs";

['preamble', 'rm2_vanilla', 'macros', 'macros_rm2_ddvk'].forEach(name => {
  copyFileSync(`textpl/${name}.tex`, `out/${name}.tex`);
})

export {buildFiles};
