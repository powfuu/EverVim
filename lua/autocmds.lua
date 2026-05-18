require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Remove stray [No Name] buffers after session restore or after plugins open extra bufs
autocmd({ "SessionLoadPost", "UIEnter" }, {
  callback = function()
    vim.defer_fn(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].buflisted
          and vim.api.nvim_buf_get_name(buf) == ""
          and not vim.bo[buf].modified
          and vim.fn.bufwinid(buf) ~= -1  -- only if actually visible
        then
          pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end
      end
    end, 100)
  end,
})

-- Use the Angular treesitter parser for HTML files (supports @if, @for, Ionic tags, etc.)
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.html",
  callback = function()
    vim.treesitter.language.register("angular", "html")
  end,
})

-- Force custom HTML tags (e.g. <ion-card>, <mm-combobox>) to be highlighted as HTML tags
autocmd({ "FileType" }, {
  pattern = { "html", "htmlangular", "javascriptreact", "typescriptreact", "vue", "svelte", "jsp" },
  callback = function()
    vim.cmd([[syntax match htmlTagName /\<[a-zA-Z0-9]\+-[a-zA-Z0-9\-]\+\>/]])
    vim.api.nvim_set_hl(0, "@tag.html", { link = "htmlTagName", default = true })
    vim.api.nvim_set_hl(0, "@tag", { link = "htmlTagName", default = true })
    vim.api.nvim_set_hl(0, "@tag.angular", { link = "htmlTagName", default = true })
  end,
})

-- Force JSP files to use HTML Treesitter parser for better highlighting
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.jsp",
  callback = function()
    vim.treesitter.language.register("html", "jsp")
  end,
})

-- Persist Git Conflict Highlights across theme reloads and sessions
autocmd({ "ColorScheme", "UIEnter", "SessionLoadPost" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#2b5643", default = false })
    vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#2b5643", default = false })
    vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#1f3b5c", default = false })
    vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#1f3b5c", default = false })
    vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#512c40", default = false })
    vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#512c40", default = false })
  end,
})

-- When the last real buffer is closed, show the dashboard instead of [No Name]
autocmd("BufDelete", {
  callback = function(ev)
    vim.schedule(function()
      local real_bufs = vim.tbl_filter(function(b)
        return vim.api.nvim_buf_is_valid(b)
          and vim.bo[b].buflisted
          and vim.api.nvim_buf_get_name(b) ~= ""
          and b ~= ev.buf
      end, vim.api.nvim_list_bufs())

      if #real_bufs == 0 then
        -- Open dashboard in current window first (replaces the buffer in the window)
        -- so Neovim never tries to close the last window
        require("nvchad.nvdash").open()

        -- Then wipe leftover blank [No Name] buffers that are no longer visible
        vim.defer_fn(function()
          for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(b)
              and vim.bo[b].buflisted
              and vim.api.nvim_buf_get_name(b) == ""
              and not vim.bo[b].modified
              and vim.fn.bufwinid(b) == -1
            then
              pcall(vim.api.nvim_buf_delete, b, { force = true })
            end
          end
        end, 50)
      end
    end)
  end,
})

-- Pre-load terminal in the background for instant open (No delay on first toggle)
-- Delayed to 2s so startup rendering and LSP attach finish first
autocmd("UIEnter", {
  callback = function()
    vim.defer_fn(function()
      -- Create a hidden buffer
      local buf = vim.api.nvim_create_buf(false, true)
      
      -- Set it as a terminal buffer
      vim.bo[buf].buflisted = false
      vim.bo[buf].ft = "NvTerm_float"
      
      -- Open terminal in the background
      vim.api.nvim_buf_call(buf, function()
        vim.fn.termopen(vim.o.shell)
        -- Send a 'clear' command once the shell is ready so the first view is completely clean
        -- Increased delay to 600ms to ensure ZSH and NVM finish loading before clearing
        vim.defer_fn(function()
          local job_id = vim.b[buf].terminal_job_id
          if job_id then
            vim.api.nvim_chan_send(job_id, "clear\n")
          end
        end, 400)
      end)

      -- Register it for NvChad term toggle
      local terms_list = vim.g.nvchad_terms or {}
      terms_list[tostring(buf)] = {
        id = "floatTerm",
        buf = buf,
        pos = "float",
      }
      vim.g.nvchad_terms = terms_list
    end, 2000) -- Delay 2s: let startup, LSP attach, and session restore finish before forking a shell
  end,
})
