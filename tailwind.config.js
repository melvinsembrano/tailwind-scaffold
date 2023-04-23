module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './lib/tailed/**/*.html.erb',
    './lib/tailed/**/*.rb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
  ]
}
