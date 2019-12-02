process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

environment.splitChunks()

module.exports = environment.toWebpackConfig()
