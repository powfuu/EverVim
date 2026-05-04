require "nvchad.options"

local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true -- Relative line numbers

-- Highlight the current line across the whole screen
o.cursorline = true
o.cursorlineopt = "both" -- 'both' means line number and the whole line background
