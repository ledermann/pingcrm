const environment = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 3,
    }),
    require('tailwindcss')('./app/javascript/styles/tailwind.config.js'),
    require('autoprefixer'),
  ],
}

module.exports = environment
