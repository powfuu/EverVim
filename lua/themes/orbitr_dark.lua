-- Orbitr Dark: One Dark syntax colours on Orbitr's pure-black background (NvChad / base46).
-- Pick it with <leader>th, or set `theme = "orbitr_dark"` in lua/chadrc.lua.

local M = {}

M.base_30 = {
  white = "#abb2bf",
  darker_black = "#050505", -- side panels (tree, telescope)
  black = "#000000", -- editor background, same as Orbitr
  black2 = "#0d0d0d",
  one_bg = "#141414",
  one_bg2 = "#1f1f1f",
  one_bg3 = "#262626",
  grey = "#333333",
  grey_fg = "#4b5263",
  grey_fg2 = "#5c6370",
  light_grey = "#7f848e",
  red = "#e06c75",
  baby_pink = "#de8c92",
  pink = "#ff75a0",
  line = "#1c1c1c", -- split lines
  green = "#98c379",
  vibrant_green = "#7eca9c",
  nord_blue = "#81a1c1",
  blue = "#61afef",
  yellow = "#e5c07b",
  sun = "#ebcb8b",
  purple = "#c678dd",
  dark_purple = "#b26fd1",
  teal = "#519aba",
  orange = "#d19a66",
  cyan = "#56b6c2",
  statusline_bg = "#080808",
  lightbg = "#1f1f1f",
  pmenu_bg = "#61afef",
  folder_bg = "#61afef",
}

M.base_16 = {
  base00 = "#000000", -- background
  base01 = "#141414",
  base02 = "#1f1f1f", -- selection
  base03 = "#5c6370", -- comments
  base04 = "#7f848e",
  base05 = "#abb2bf", -- text
  base06 = "#b6bdca",
  base07 = "#c8ccd4",
  base08 = "#e06c75", -- variables, tags
  base09 = "#d19a66", -- numbers, constants
  base0A = "#e5c07b", -- classes, types
  base0B = "#98c379", -- strings
  base0C = "#56b6c2", -- escapes, regex
  base0D = "#61afef", -- functions
  base0E = "#c678dd", -- keywords
  base0F = "#be5046",
}

M.polish_hl = {
  defaults = {
    Comment = { italic = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "orbitr_dark")

return M
