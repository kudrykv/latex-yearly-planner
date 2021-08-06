const {
  VENDOR, PLANNER_YEAR, WEEK_START_DAY, DISABLE_WEEKS,
} = process.env;

if (!VENDOR) {
  throw new Error('VENDOR must be set');
}

if (!VENDOR.match(/^\w+$/)) {
  throw new Error('bad VENDOR value, only ^\\w+$ is allowed');
}

if (!PLANNER_YEAR || Number(PLANNER_YEAR) === 0) {
  throw new Error('PLANNER_YEAR must be set');
}

if (WEEK_START_DAY && !['Monday', 'Sunday'].some(value => value === WEEK_START_DAY)) {
  throw new Error('WEEK_START_DAY contains invalid value ' + WEEK_START_DAY + ', allowed Monday or Sunday')
}

interface EnvConfig {
  vendor: string;
  year: number;
  weekStart: 1 | 7;
  disableWeeks: boolean;
}

export type {EnvConfig};

export const envConfig = {
  vendor: VENDOR,
  year: Number(PLANNER_YEAR),
  weekStart: WEEK_START_DAY === 'Monday' ? 1 : 7,
  disableWeeks: DISABLE_WEEKS === 'true'
} as EnvConfig;