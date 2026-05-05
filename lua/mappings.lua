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

-- Find files (Ctrl+P / Cmd+P) — min 2 chars, matches only filename not directories
local function find_files_min2()
  local conf = require("telescope.config").values
  local make_entry = require("telescope.make_entry")

  local sorter = conf.file_sorter({})
  local orig_score = sorter.scoring_function
  sorter.scoring_function = function(self, prompt, line, entry)
    if #prompt < 2 then return -1 end
    return orig_score(self, prompt, line, entry)
  end

  local gen = make_entry.gen_from_file({})
  require("telescope.builtin").find_files({
    file_ignore_patterns = { "node_modules/", "%.git/", "%.claude/", "dist/", "build/", "%.lock$" },
    sorter = sorter,
    entry_maker = function(filepath)
      local entry = gen(filepath)
      if entry then
        -- Match only against the filename (e.g. "main.ts"), not the directory path
        entry.ordinal = vim.fn.fnamemodify(filepath, ":t")
      end
      return entry
    end,
  })
end

map("n", "<C-p>", find_files_min2, { desc = "Find files" })
map("n", "<D-p>", find_files_min2, { desc = "Find files" })

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

-- Git blame detail: muestra info del commit en split inferior (q para cerrar)
map("n", "gt", function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local root = vim.fn.system("git -C " .. vim.fn.shellescape(vim.fn.fnamemodify(file, ":h")) .. " rev-parse --show-toplevel"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("No es un repositorio git", vim.log.levels.WARN)
    return
  end

  local blame = vim.fn.system(string.format(
    "git -C %s blame -L %d,%d --porcelain %s 2>/dev/null",
    vim.fn.shellescape(root), line, line, vim.fn.shellescape(file)
  ))
  local hash = blame:match("^(%x+)")
  if not hash or hash:match("^0+$") then
    vim.notify("Línea sin commit (cambio no guardado)", vim.log.levels.WARN)
    return
  end

  local info = vim.fn.systemlist(string.format(
    "git -C %s show --no-patch --format='%%n  Commit   %%h  (%%H)%%n  Autor    %%an <%%ae>%%n  Fecha    %%ad%%n  Mensaje  %%s%%n%%n%%b' --date=format:'%%Y-%%m-%%d  %%H:%%M:%%S' %s",
    vim.fn.shellescape(root), hash
  ))
  local stats = vim.fn.systemlist(string.format(
    "git -C %s show --stat --format='' %s | tail -n +2",
    vim.fn.shellescape(root), hash
  ))

  local content = {}
  vim.list_extend(content, info)
  if #stats > 0 then
    table.insert(content, "")
    table.insert(content, "  Archivos cambiados:")
    for _, l in ipairs(stats) do
      table.insert(content, "  " .. l)
    end
  end
  table.insert(content, "")

  -- Reutilizar buffer existente si ya está abierto
  local existing_buf = nil
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(b):match("__GitBlame__") then
      existing_buf = b
      break
    end
  end

  local buf = existing_buf or vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "__GitBlame__")
  vim.bo[buf].buftype    = "nofile"
  vim.bo[buf].bufhidden  = "wipe"
  vim.bo[buf].swapfile   = false
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  vim.bo[buf].modifiable = false

  -- Abrir en split inferior si no está visible
  local win = nil
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(w) == buf then win = w; break end
  end
  if not win then
    vim.cmd("botright 12split")
    vim.api.nvim_win_set_buf(0, buf)
  else
    vim.api.nvim_set_current_win(win)
  end

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })

  -- Syntax highlighting
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("syntax clear")
    vim.cmd([[syn match GBLabel    /^\s\+\(Commit\|Autor\|Fecha\|Mensaje\)/]])
    vim.cmd([[syn match GBHash     /\s\+\([a-f0-9]\{7,8\}\)\s/]])
    vim.cmd([[syn match GBHashFull /([a-f0-9]\{40\})/]])
    vim.cmd([[syn match GBEmail    /<[^>]\+>/]])
    vim.cmd([[syn match GBDate     /\d\{4\}-\d\{2\}-\d\{2\}\s\+\d\{2\}:\d\{2\}:\d\{2\}/]])
    vim.cmd([[syn match GBSection  /^\s*Archivos cambiados:/]])
    vim.cmd([[syn match GBPlus     /+\+$/]])
    vim.cmd([[syn match GBMinus    /-\+$/]])
    vim.cmd([[syn match GBPipe     /|/]])
    vim.cmd([[syn match GBFile     /^\s\+[^ |]\+\ze\s*|/]])
  end)

  vim.api.nvim_set_hl(0, "GBLabel",    { fg = "#7aa2f7", bold = true })
  vim.api.nvim_set_hl(0, "GBHash",     { fg = "#e0af68", bold = true })
  vim.api.nvim_set_hl(0, "GBHashFull", { fg = "#c0caf5" })
  vim.api.nvim_set_hl(0, "GBEmail",    { fg = "#ff9e64", italic = true })
  vim.api.nvim_set_hl(0, "GBDate",     { fg = "#bb9af7" })
  vim.api.nvim_set_hl(0, "GBSection",  { fg = "#7dcfff", bold = true })
  vim.api.nvim_set_hl(0, "GBPlus",     { fg = "#9ece6a", bold = true })
  vim.api.nvim_set_hl(0, "GBMinus",    { fg = "#f7768e", bold = true })
  vim.api.nvim_set_hl(0, "GBPipe",     { fg = "#3b4261" })
  vim.api.nvim_set_hl(0, "GBFile",     { fg = "#c0caf5" })
end, { desc = "Git blame detail (split)" })

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
