require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Force custom HTML tags (e.g. <mm-combobox>) to be highlighted as HTML tags
autocmd({ "FileType" }, {
  pattern = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "jsp" },
  callback = function()
    vim.cmd([[syntax match htmlTagName /\<[a-zA-Z0-9]\+-[a-zA-Z0-9\-]\+\>/]])
    -- Also explicitly map it to the Treesitter tag highlight just in case
    vim.api.nvim_set_hl(0, "@tag.html", { link = "htmlTagName", default = true })
    vim.api.nvim_set_hl(0, "@tag", { link = "htmlTagName", default = true })
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

-- Pre-load terminal in the background for instant open (No delay on first toggle)
-- We delay the execution to prevent it from blocking the main thread during startup
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
        vim.defer_fn(function()
          local job_id = vim.b[buf].terminal_job_id
          if job_id then
            vim.api.nvim_chan_send(job_id, "clear\n")
          end
        end, 200)
      end)

      -- Register it for NvChad term toggle
      local terms_list = vim.g.nvchad_terms or {}
      terms_list[tostring(buf)] = {
        id = "floatTerm",
        buf = buf,
        pos = "float",
      }
      vim.g.nvchad_terms = terms_list
    end, 100) -- Delay by 100ms so the UI can finish rendering and scrolling is smooth immediately
  end,
})
