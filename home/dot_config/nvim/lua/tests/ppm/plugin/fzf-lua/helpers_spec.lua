describe("FzfLua helpers", function()
  local Module = require("ppm.plugin.fzf-lua.helpers")

  describe("join_first_words()", function()
      local separator = ":"

    it("should return the first word with an extra separator", function()
      local actual = Module.join_first_words(separator)({ "a b" })
      assert.are.equals("a:", actual)
    end)

    it("should concatenate together first words with an extra separator", function()
      local actual = Module.join_first_words(separator)({ "a b", "c d" })
      assert.are.equals("a:c:", actual)
    end)

    it("should return an empty string when an empty array is given", function ()
      local actual = Module.join_first_words(separator)({})
      assert.are.equals("", actual)
    end)
  end)
end)
