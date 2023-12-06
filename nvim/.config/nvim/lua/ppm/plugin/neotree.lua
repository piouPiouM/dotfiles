vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "TelescopePrompt", "lspsagaoutline" },
  filesystem = {
    filtered_items = { hide_by_name = { "node_modules" }, always_show = { ".config" }, never_show = { ".DS_Store" } },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    window = { mappings = { ["h"] = "toggle_hidden" } },
  },
})