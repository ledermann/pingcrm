module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  plugins: [],
  extends: [
    'eslint:recommended',
    'plugin:vue/base',
    'plugin:vue/essential',
    'plugin:vue/strongly-recommended',
    'plugin:vue/recommended',
    'prettier',
    'plugin:prettier/recommended',
  ],
  globals: {},
  rules: {
    'vue/no-unused-vars': 'error',
    'vue/multi-word-component-names': 'off',
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
  },
  parserOptions: {
    sourceType: 'module', // allow the use of imports statements
    ecmaVersion: 2020, // allow the parsing of modern ecmascript
  },
};
