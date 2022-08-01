local g = vim.g

g.EditorConfig_core_mode = "external_command"
g.EditorConfig_exec_path = "/usr/local/bin/editorconfig"
g.EditorConfig_exclude_patterns = { "fugitive://.*", "gitgutter://.*" }
