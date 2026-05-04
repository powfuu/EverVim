require "nvchad.options"

local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true -- Relative line numbers

-- Enable System Clipboard across all operations implicitly
o.clipboard = "unnamedplus"

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

-- ==========================================
-- Cursor & Viewport (VSCode Style)
-- ==========================================
o.scrolloff = 15        -- editor.cursorSurroundingLines: 15 (Keep 15 lines of context around the cursor)

-- editor.cursorStyle: "line" & editor.cursorBlinking: "blink"
-- n-v-c-sm:block (Normal/Visual: Block)
-- i-ci-ve:ver25 (Insert: Vertical bar 25% width, with blinking)
-- r-cr-o:hor20 (Replace: Underline)
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
