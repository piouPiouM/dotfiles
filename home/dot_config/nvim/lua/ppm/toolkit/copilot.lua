local D = require("ppm.toolkit.fp.Dict")
local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp")
local O = require("ppm.toolkit.fp.Option")
local pipe = F.pipe
local M = {}

--- @param scopes Array<string>
function M.get_models(scopes)
  local copilot_client = require("copilot.client").get()
  local models

  require("copilot.api").request(copilot_client, "copilot/models", { bufnr = 0 }, function(err, data)
    if err then
      vim.notify("Error fetching Copilot models: " .. err.message, vim.log.levels.ERROR)
      return
    end

    models = pipe(
      data,
      A.filter(function(model)
        return vim.tbl_contains(
          model.scopes,
          function(v) return vim.tbl_contains(scopes, v) end,
          { predicate = true })
      end)
    )
    P(models)
  end)

  return models or {}
end

function M.list_completion_models()
  return pipe(
    M.get_models({ "completion" }),
    A.map(function(model)
      return {
        id = model.id,
        name = model.name
      }
    end)
  )
end

return M
