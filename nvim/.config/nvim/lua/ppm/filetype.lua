local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp.function")

local M = {}

M.jsx = {
  "javascriptreact",
  "javascript.jsx",
  "typescriptreact",
  "typescript.tsx",
}

M.typescript = F.pipe({ "javascript", "typescript" }, A.concat(M.jsx))

return M