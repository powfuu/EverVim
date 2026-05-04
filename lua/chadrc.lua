-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",

	hl_override = {
		TelescopeSelection = { bg = "#04395E", fg = "#FFFFFF", bold = true },
    TelescopeSelectionCaret = { bg = "#04395E", fg = "#569CD6" },
    CursorLine = { bg = "#2A2D2E" }, -- Very subtle dark grey for the current line
	},

  hl_add = {
    -- VSCode exact conflict colors
    GitConflictCurrent = { bg = "#2b5643" },   -- Green for HEAD (Current Changes)
    GitConflictCurrentLabel = { bg = "#2b5643" },
    GitConflictIncoming = { bg = "#1f3b5c" },  -- Blue for Develop (Incoming Changes)
    GitConflictIncomingLabel = { bg = "#1f3b5c" },
    GitConflictAncestor = { bg = "#512c40" },
    GitConflictAncestorLabel = { bg = "#512c40" },
  }
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                                      ",
    " ███████╗██╗   ██╗███████╗██████╗ ██╗   ██╗██╗███╗   ███╗",
    " ██╔════╝██║   ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
    " █████╗  ██║   ██║█████╗  ██████╔╝██║   ██║██║██╔████╔██║",
    " ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
    " ███████╗ ╚████╔╝ ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    " ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "                                      ",
    "         ⚡ The Perfect VIM IDE ⚡       ",
    "                                      ",
  },
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  EverVim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

M.ui = {
  statusline = {
    theme = "vscode", -- Make statusline look like vscode
  },
  tabufline = {
    lazyload = false,
  },
}

M.term = {
  float = {
    relative = "editor",
    row = 0.1,
    col = 0.05,
    width = 0.9,
    height = 0.8,
    border = "single",
  },
}

return M
