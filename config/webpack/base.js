const { webpackConfig, merge } = require('@rails/webpacker')
const vueConfig = require('./rules/vue')
const path = require('path')

const customConfig = {
  resolve: {
    extensions: ['.css', '.vue'],
    alias: {
      '@': path.resolve('app/packs'),
    },
  },
}

module.exports = merge(vueConfig, customConfig, webpackConfig)
