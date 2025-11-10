---@meta

---@alias Template.ExtendType "before" | "after"

---@generic T : Frontmatter.Metadata
---@class Template.FrontmatterFields<T>
---@field before? string[] List of template(s) to load before the content.
---@field after? string[] List of template(s) to load after the content.
---@field [string]? T

---@generic T
---@class Template
---@field frontmatter Template.FrontmatterFields<T>
---@field content string
