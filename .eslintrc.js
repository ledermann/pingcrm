module.exports = {
  root: true,
  env: {
    node: true,
  },
  plugins: [],
  extends: [
    'eslint:recommended',
    'plugin:vue/base',
    'plugin:vue/essential',
    'plugin:vue/strongly-recommended',
    'plugin:vue/recommended',
  ],
  globals: {},
  rules: {
    'vue/no-unused-vars': 'error',
    'vue/multi-word-component-names': 'off',
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-extra-semi': 'error',
    'semi': ['error', 'never'],
    'quotes': ['warn', 'single'],
    'comma-dangle': ['warn', 'always-multiline'],
  },
  parserOptions: {
    parser: '@babel/eslint-parser',
  },
}
