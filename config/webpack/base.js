const { webpackConfig, merge } = require('@rails/webpacker')
const vueConfig = require('./rules/vue')
const path = require('path')

const customConfig = {
  resolve: {
    extensions: ['.css', '.vue'],
    alias: {
      '@': path.resolve('app/javascript'),
    },
  },
}

module.exports = merge(vueConfig, customConfig, webpackConfig)
