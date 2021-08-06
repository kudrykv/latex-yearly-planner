module.exports = {
  "preset": "ts-jest",
  "roots": [
    "<rootDir>/planner"
  ],
  "testMatch": [
    "**/?(*.)+(spec|test).+(ts|tsx|js)"
  ],
  "transform": {
    '^.+\\.tsx?$': 'ts-jest'
  }
}