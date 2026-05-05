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
o.updatetime  = 200     -- 50ms is too aggressive (fires CursorHold/gitsigns 20x/sec); 200ms is the sweet spot
o.timeoutlen  = 300     -- Faster mapping resolution
o.pumblend    = 10      -- Slight transparency in popup menus
o.winblend    = 10      -- Slight transparency in floating windows
o.smoothscroll = true   -- Neovim 0.10 native smooth scrolling

-- Reduce re-renders: only redraw when needed, not during macro/script execution
o.lazyredraw  = false   -- keep false (true breaks some UIs), handled per-operation instead
o.redrawtime  = 1500    -- abort syntax highlight after 1.5s on huge files (default 2000)

-- Faster file I/O
o.swapfile    = false   -- no swap files (auto-session saves state anyway)
o.undofile    = true    -- persistent undo is fine, swap is the slow part

-- ==========================================
-- Cursor & Viewport (VSCode Style)
-- ==========================================
o.scrolloff    = 15     -- Keep 15 lines of context around the cursor
o.cmdheight    = 0      -- Hide the default command line (we use FineCmdline)
o.cursorlineopt = "both"   -- line number + full line bg (keep VSCode feel)

o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"
