---@diagnostic disable: duplicate-doc-field
---@meta

---@alias Hue number Float [0,360]
---@alias Saturation number Float [0,100]
---@alias Lightness number Float [0,100]
---@alias Alpha number Float [0,100]

---Hexadecimal color representation.
---
---@alias HEX string

---RGBA color representation.
---@class RGBA
---@field red number Float [0,255]
---@field green number Float [0,255]
---@field blue number Float [0,255]
---@field alpha Alpha Float [0,100]

---HSLA color representation.
---@class HSLA
---@field hue Hue
---@field saturation Saturation Float [0,100]
---@field lightness Lightness Float [0,100]
---@field alpha Alpha Float [0,100]