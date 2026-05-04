require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- ==========================================
-- VSCode / Trae IDE Keybindings
-- ==========================================

-- Save file without formatting (Ctrl+S / Cmd+S)
map({ "n", "i", "v" }, "<C-s>", "<cmd> noautocmd w <cr>", { desc = "Save file (no format)" })
map({ "n", "i", "v" }, "<D-s>", "<cmd> noautocmd w <cr>", { desc = "Save file (no format)" })

-- Save file with formatting (Ctrl+Shift+S / Cmd+Shift+S)
map({ "n", "i", "v" }, "<C-S-S>", "<cmd> w <cr>", { desc = "Save file (with format)" })
map({ "n", "i", "v" }, "<D-S-s>", "<cmd> w <cr>", { desc = "Save file (with format)" })

-- Close file (Ctrl+W / Cmd+W)
map("n", "<C-w>", "<cmd> bd <cr>", { desc = "Close buffer" })
map("n", "<D-w>", "<cmd> bd <cr>", { desc = "Close buffer" })

-- Close Window Split (without closing the buffer)
map("n", "<C-M-w>", "<cmd> close <cr>", { desc = "Close window split" })
map("n", "<D-M-w>", "<cmd> close <cr>", { desc = "Close window split" })
map("n", "∑", "<cmd> close <cr>", { desc = "Close window split (Mac Alt+W)" })

-- Explorer / File Tree (Ctrl+B / Cmd+B)
map("n", "<C-b>", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle Explorer" })
map("n", "<D-b>", "<cmd> NvimTreeToggle <cr>", { desc = "Toggle Explorer" })

-- Find files (Ctrl+P / Cmd+P)
map("n", "<C-p>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Find files (including hidden, excluding node_modules/.git/.claude)" })

map("n", "<D-p>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Find files (including hidden, excluding node_modules/.git/.claude)" })

-- Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
map("n", "<C-S-P>", "<cmd> Telescope commands <cr>", { desc = "Command Palette" })
map("n", "<D-S-p>", "<cmd> Telescope commands <cr>", { desc = "Command Palette" })

-- Search in Files (Ctrl+Shift+F / Cmd+Shift+F)
map("n", "<C-S-F>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" } -- Removed --no-ignore so it respects .gitignore again
    end,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Search in files (including hidden, excluding node_modules/.git/.claude)" })

map("n", "<D-S-f>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" } -- Removed --no-ignore so it respects .gitignore again
    end,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Search in files (including hidden, excluding node_modules/.git/.claude)" })

-- Find in current file (Ctrl+F / Cmd+F)
map("n", "<C-f>", "<cmd> Telescope current_buffer_fuzzy_find <cr>", { desc = "Find in file" })
map("n", "<D-f>", "<cmd> Telescope current_buffer_fuzzy_find <cr>", { desc = "Find in file" })

-- Undo (Ctrl+Z / Cmd+Z)
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("n", "<D-z>", "u", { desc = "Undo" })
map("i", "<D-z>", "<C-o>u", { desc = "Undo" })

-- Redo (Ctrl+Y / Cmd+Shift+Z)
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("n", "<D-S-z>", "<C-r>", { desc = "Redo" })

-- Toggle Comment (Ctrl+/ / Cmd+/)
map("n", "<C-/>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle Comment", remap = true })
map("n", "<D-/>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<D-/>", "gc", { desc = "Toggle Comment", remap = true })

-- Toggle Terminal (ctrl+n / cmd+n)
map({ "n", "t" }, "<C-n>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle Terminal" })

map({ "n", "t" }, "<D-n>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle Terminal" })

-- ==========================================
-- EverVim IDE Advanced Features
-- ==========================================

-- Diagnostics Panel (Trouble)
map("n", "<leader>xx", "<cmd> Trouble diagnostics toggle <cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xw", "<cmd> Trouble diagnostics toggle filter.buf=0 <cr>", { desc = "Buffer Diagnostics (Trouble)" })

-- Todo Search
map("n", "<leader>ft", "<cmd> TodoTelescope <cr>", { desc = "Find TODOs" })

-- Find Git Conflicts
map("n", "<leader>fc", "<cmd> Telescope live_grep default_text=<<<<<<<\\ HEAD <cr>", { desc = "Find Git Conflicts" })

-- Git Conflict Resolution (VSCode style)
map("n", "<leader>co", "<cmd> GitConflictChooseOurs <cr>", { desc = "Choose Ours (Current/Green)" })
map("n", "<leader>ct", "<cmd> GitConflictChooseTheirs <cr>", { desc = "Choose Theirs (Incoming/Blue)" })
map("n", "<leader>cb", "<cmd> GitConflictChooseBoth <cr>", { desc = "Choose Both" })
map("n", "<leader>c0", "<cmd> GitConflictChooseNone <cr>", { desc = "Choose None" })
map("n", "]c", "<cmd> GitConflictNextConflict <cr>", { desc = "Next Conflict" })
map("n", "[c", "<cmd> GitConflictPrevConflict <cr>", { desc = "Previous Conflict" })

-- Lazygit (Git UI)
map("n", "<leader>gg", "<cmd> LazyGit <cr>", { desc = "LazyGit" })

-- ==========================================
-- Fast Navigation & Window Management
-- ==========================================

-- Fast vertical scroll (30 lines)
map({ "n", "v" }, "<C-j>", "30j", { desc = "Move down 30 lines" })
map({ "n", "v" }, "<D-j>", "30j", { desc = "Move down 30 lines" })
map({ "n", "v" }, "<C-k>", "30k", { desc = "Move up 30 lines" })
map({ "n", "v" }, "<D-k>", "30k", { desc = "Move up 30 lines" })

-- Window Splitting
map("n", "<C-S-l>", "<cmd> vsplit <cr> <C-w>l", { desc = "Split right" })
map("n", "<D-S-l>", "<cmd> vsplit <cr> <C-w>l", { desc = "Split right" })

map("n", "<C-S-h>", "<cmd> leftabove vsplit <cr> <C-w>h", { desc = "Split left" })
map("n", "<D-S-h>", "<cmd> leftabove vsplit <cr> <C-w>h", { desc = "Split left" })

map("n", "<C-S-j>", "<cmd> split <cr> <C-w>j", { desc = "Split down" })
map("n", "<D-S-j>", "<cmd> split <cr> <C-w>j", { desc = "Split down" })

map("n", "<C-S-k>", "<cmd> leftabove split <cr> <C-w>k", { desc = "Split up" })
map("n", "<D-S-k>", "<cmd> leftabove split <cr> <C-w>k", { desc = "Split up" })

-- Tab Navigation (Shift + Option + H/L)
map("n", "<A-S-l>", function() require("nvchad.tabufline").next() end, { desc = "Next Tab" })
map("n", "<A-S-h>", function() require("nvchad.tabufline").prev() end, { desc = "Prev Tab" })
map("n", "Ò", function() require("nvchad.tabufline").next() end, { desc = "Next Tab (Mac)" })
map("n", "Ó", function() require("nvchad.tabufline").prev() end, { desc = "Prev Tab (Mac)" })
