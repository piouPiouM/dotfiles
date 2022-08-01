vim.filetype.add({
  extension = {
    mdx = "markdown",
    rasi = "rasi",

    --[[ Drupal
    info = "drini",
    make = "drini",
    build = "drini",
    module = "php",
    install = "php",
    inc = "php",
    profile = "php",
    view = "php",
    theme = "php", ]]
  },
  filename = {
    [".babelrc"] = "jsonc",
    [".prettierrc"] = "jsonc",
    [".eslintrc"] = "jsonc",
    ["tsconfig.json"] = "jsonc",
    ["jsconfig.json"] = "jsonc",
  },
  pattern = {
    [".*/apache2/.*.conf"] = "apache2",
    [".*/git/ignore"] = "gitignore",
    [".*/waybar/config"] = "jsonc",
  },
})
