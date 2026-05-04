require "nvchad.options"

local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true -- Relative line numbers

-- Highlight the current line across the whole screen
o.cursorline = true
o.cursorlineopt = "both" -- 'both' means line number and the whole line background

-- ==========================================
-- Fluidity & Performance tweaks
-- ==========================================
o.updatetime = 50       -- Faster completion, faster Git signs, smoother UI updates (default is 250)
o.timeoutlen = 300      -- Faster mapping resolution
o.pumblend = 10         -- Slight transparency in popup menus (autocomplete) for a sleek modern feel
o.winblend = 10         -- Slight transparency in floating windows
o.smoothscroll = true   -- Enable Neovim 0.10 native smooth scrolling for half-pages
