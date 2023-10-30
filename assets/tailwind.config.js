// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/*_web.ex",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        current: 'currentColor',
        gray: { 700: '#374151' },
        base: {
          350: '#231F20',
          300: '#1F1C1E',
          250: '#898989',
          225: '#C9C9C9',
          200: '#EFEFEF',
          100: '#FFFFFF',
        },
        toggle: { 100: '#50ACC4' },
        'blue-gallery': {
          400: '#4DAAC6',
          300: '#6696F8',
          200: '#92B6F9',
          100: '#E1EBFD',
        },
        'red-sales': { 300: '#E1662F', 200: '#EF8F83', 100: '#FDF2F2' },
        'blue-planning': { 300: '#4DAAC6', 200: '#86C3CC', 100: '#F2FDFB' },
        'yellow-files': { 300: '#F7CB45', 200: '#FAE46B', 100: '#FEF9E2' },
        'purple-marketing': { 300: '#585DF6', 200: '#7F82E6', 100: '#F8F4FE' },
        'orange-inbox': {
          400: '#FCF0EA',
          300: '#F19D4A',
          200: '#F5BD7F',
          100: '#FDF4E9',
        },
        'green-finances': { 300: '#429467', 200: '#81CF67', 100: '#CFE7CD' },
        'red-error': { 300: '#F60000' },
      },
      spacing: {
        '5px': '15px',
      }
    },
  },
  plugins: [
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "./vendor/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).map(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": theme("spacing.5"),
            "height": theme("spacing.5")
          }
        }
      }, {values})
    })
  ]
}
