const environment = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    require('tailwindcss')('./app/javascript/styles/tailwind.config.js'),
    require('autoprefixer'),
  ]
}

// Only run PurgeCSS in production and test
if (process.env.RAILS_ENV !== 'development') {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/**/*.vue',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js'
      ],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || [],
    })
  )
}

module.exports = environment
