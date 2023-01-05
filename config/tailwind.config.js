const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: {
    safelist: [
      'bg-sky-100',
      'bg-sky-300',
      'bg-amber-200',
      'bg-orange-400',
      'bg-red-500'
    ],
  },
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
