require "nvchad.mappings"

local map = vim.keymap.set

-- Beautiful Centered Command Line (FineCmdline) is now mapped in plugins/init.lua for lazy loading

-- Removed the "jk" to "<ESC>" mapping because it causes lag when typing the letter 'j'

-- ==========================================
-- VSCode / Trae IDE Keybindings
-- ==========================================

-- System Clipboard Copy / Paste (Cmd+C / Cmd+V / Ctrl+C / Ctrl+V)
-- In Visual mode, copy the selection
map("v", "<D-c>", '"+y', { desc = "Copy selection to system clipboard" })
map("v", "<C-c>", '"+y', { desc = "Copy selection to system clipboard" })

-- In Normal mode, copy the current line (VSCode behavior)
map("n", "<D-c>", '"+yy', { desc = "Copy line to system clipboard" })
map("n", "<C-c>", '"+yy', { desc = "Copy line to system clipboard" })

-- Paste from system clipboard
map({ "n", "v" }, "<D-v>", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map({ "i", "c" }, "<D-v>", "<C-r>+", { desc = "Paste from system clipboard" })
map({ "i", "c" }, "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

-- Save file without formatting (Ctrl+S / Cmd+S)
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file (no format)" })
map({ "n", "i", "v" }, "<D-s>", "<cmd> w <cr>", { desc = "Save file (no format)" })

-- Save file with formatting (Ctrl+Shift+S / Cmd+Shift+S)
map({ "n", "i", "v" }, "<C-S-S>", function()
  require("conform").format({ lsp_fallback = true })
  vim.cmd("w")
end, { desc = "Save file (with format)" })
map({ "n", "i", "v" }, "<D-S-s>", function()
  require("conform").format({ lsp_fallback = true })
  vim.cmd("w")
end, { desc = "Save file (with format)" })

-- Close file (Ctrl+W / Cmd+W)
map("n", "<C-w>", "<cmd> bd <cr>", { desc = "Close buffer" })
map("n", "<D-w>", "<cmd> bd <cr>", { desc = "Close buffer" })

-- Close Window Split (without closing the buffer)
map("n", "<C-M-w>", "<cmd> close <cr>", { desc = "Close window split" })
map("n", "<D-M-w>", "<cmd> close <cr>", { desc = "Close window split" })
map("n", "∑", "<cmd> close <cr>", { desc = "Close window split (Mac Alt+W)" })

-- Quit All (Ctrl+Q / Cmd+Q)
map({ "n", "i", "v" }, "<C-q>", "<cmd> qa <cr>", { desc = "Quit All" })
map({ "n", "i", "v" }, "<D-q>", "<cmd> qa <cr>", { desc = "Quit All" })

-- Explorer / File Tree (Ctrl+B / Cmd+B)
map("n", "<C-m>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })
map("i", "<C-m>", "<ESC><cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })
map("v", "<C-m>", "<ESC><cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })

map("n", "<D-m>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })
map("i", "<D-m>", "<ESC><cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })
map("v", "<D-m>", "<ESC><cmd> NvimTreeToggle <CR>", { desc = "Toggle Explorer" })

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
      return { "--hidden" }
    end,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Search in files (Exact match, ignore case)" })

map("n", "<D-S-f>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" }
    end,
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/" }
  })
end, { desc = "Search in files (Exact match, ignore case)" })

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

-- GitLens: File commit history with side-by-side diff — toggle (Ctrl+,)
map("n", "<C-,>", function()
  local lib = require("diffview.lib")
  if lib.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    local file = vim.fn.expand("%:p")
    if file == "" then return end
    vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(file))
  end
end, { desc = "Toggle Git file history (GitLens)" })

-- ==========================================
-- Fast Navigation & Window Management
-- ==========================================

-- Fast vertical scroll (30 lines) with Buttery Smooth Animation
map({ "n", "v" }, "<C-j>", function() require("neoscroll").scroll(30, true, 250) end, { desc = "Smooth move down 30 lines" })
map({ "n", "v" }, "<D-j>", function() require("neoscroll").scroll(30, true, 250) end, { desc = "Smooth move down 30 lines" })
map({ "n", "v" }, "<C-k>", function() require("neoscroll").scroll(-30, true, 250) end, { desc = "Smooth move up 30 lines" })
map({ "n", "v" }, "<D-k>", function() require("neoscroll").scroll(-30, true, 250) end, { desc = "Smooth move up 30 lines" })

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
