const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

const path = require('path')
environment.config.merge({
  resolve: {
    alias: {
      '@': path.resolve('app/javascript'),
      vue$: 'vue/dist/vue.runtime.esm.js',
    },
  },
})

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment
