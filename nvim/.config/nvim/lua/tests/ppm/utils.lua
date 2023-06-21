local M = {}

function M.addOne(n) return n + 1 end

function M.double(n) return n * 2 end

function M.generateAliasesTests(obj, t)
  describe("aliases", function()
    for original, aliases in pairs(t) do
      describe(original, function()
        for _, alias in ipairs(aliases) do
          it(("should have `%s` as an alias"):format(alias), function()
            assert.is_function(obj[alias])
            assert.are.equals(obj[original], obj[alias])
          end)
        end
      end)
    end
  end)
end

return M
