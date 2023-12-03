local M = {}

function M.addOne(n) return n + 1 end

function M.subOne(n) return n - 1 end

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

function M.generateSemigroupLawTests(monoid, value)
  local concat = monoid.concat

  it("should have an associative `concat` operation", function()
    assert.are.equals(
      concat(value, concat(value, value)),
      concat(concat(value, value), value)
    )
  end)
end

function M.generateMonoidLawTests(monoid, value)
  local concat = monoid.concat
  local empty = monoid.empty

  M.generateSemigroupLawTests(monoid, value)

  it("should have `empty` as neutral element", function()
    assert.are.equals(concat(value, empty), value)
    assert.are.equals(concat(empty, value), value)
  end)
end

return M
