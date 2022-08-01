require("nvim-surround").setup({
  delimiters = {
    invalid_key_behavior = function(char) return { char, char } end,
    pairs = { ["<"] = false },
    HTML = { ["<"] = "type" },
  },
})
