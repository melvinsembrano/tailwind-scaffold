module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  "theme": {
    "extend": {
      "colors": {
        "tw": {
          "50": "#e6e9ed",
          "100": "#ccd3dc",
          "200": "#99a6b9",
          "300": "#667a95",
          "400": "#334d72",
          "500": "#00214f",
          "600": "#001a3f",
          "700": "#00142f",
          "800": "#000d20",
          "900": "#000710"
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
  ]
}
