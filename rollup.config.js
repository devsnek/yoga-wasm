'use strict';

const sucrase = require('@rollup/plugin-sucrase');
const commonjs = require('@rollup/plugin-commonjs');

module.exports = {
  input: './index.mjs',
  output: [{
    file: 'build/index.js',
    format: 'cjs',
  }],
  plugins: [
    sucrase({ transforms: ['flow'] }),
    commonjs(),
  ],
};
