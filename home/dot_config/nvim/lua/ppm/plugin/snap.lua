local snap = require("snap")

snap.maps({
  {
    "<Leader><Leader>",
    snap.config.file({
      producer = snap.get("consumer.fzf")(snap.get "producer.ripgrep.file"),
      select = snap.get("select.file").select,
      multiselect = snap.get("select.file").multiselect,
      views = { snap.get("preview.file") },
    }),
  },

  -- { producer = "ripgrep.file" } },
  -- {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
  -- {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
  -- {"<Leader>ff", snap.config.vimgrep {}},
})
