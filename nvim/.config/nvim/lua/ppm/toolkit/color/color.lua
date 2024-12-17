---@class Color
---@field hex6 string
---@field hue Hue
---@field saturation Saturation
---@field lightness Lightness
---@field red number
---@field green number
---@field blue number
---@field alpha Alpha
local Color = {}
local mt = {
  _tag = "color",
  __index = Color,
}
-- local Color = class(nil, function(this, value)
--   if value then
--     this:of(value)
--   end
-- end, {
--   _tag = "color",
--   h = 0,
--   s = 0,
--   l = 0,
--   r = 0,
--   g = 0,
--   b = 0,
--   a = 1,
-- });

Color.of = function(value)
  assert(value)

  local instance = {
    hex6 = nil,
    hue = 0,
    saturation = 0,
    lightness = 0,
    red = 0,
    green = 0,
    blue = 0,
    alpha = 100,
  }

  return setmetatable(instance, mt)
end

Color.is_color = function(object)
  return getmetatable(object) == mt
end

function Color.get_patterns(notation) end

---@param with_alpha boolean
---@return HEX
function Color:hex(with_alpha) end

---@return Hue, Saturation, Lightness, Alpha
function Color:hsla() return self.hue, self.saturation, self.lightness, self.alpha or 100 end

return Color
