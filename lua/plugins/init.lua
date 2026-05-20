return {
  -- Force which-key to load eagerly so leader always shows the popup,
  -- even before any lazy-load trigger key is pressed.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.delay = 300
      opts.spec = opts.spec or {}
      table.insert(opts.spec, { "<C-w>", hidden = true })
      return opts
    end,
  },

  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "angular-language-server",
        "json-lsp",
        "yaml-language-server",
        "ruby-lsp",
        "prettier",
        "rubocop",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "scss",
        "javascript", "typescript", "tsx",
        "json", "yaml", "ruby", "angular"
      },
      highlight = {
        enable = true,
        -- Disable treesitter on files larger than 250 KB — the parser blocks the main thread
        disable = function(_, buf)
          local max_bytes = 250 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > max_bytes
        end,
      },
      indent = {
        enable = true,
        -- Same threshold for indentation
        disable = function(_, buf)
          local max_bytes = 250 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > max_bytes
        end,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<Up>"]   = cmp.mapping.select_prev_item()
      opts.mapping["<Down>"] = cmp.mapping.select_next_item()

      -- Debounce: wait 60ms after last keystroke before querying sources (reduces LSP hammering)
      opts.performance = {
        debounce        = 60,
        throttle        = 30,
        fetching_timeout = 500,  -- drop slow sources after 500ms instead of waiting forever
        max_view_entries = 20,   -- cap the popup to 20 items (rendering more is wasted work)
      }

      opts.experimental = {
        ghost_text = { hl_group = "CmpGhostText" },
      }
    end,
  },

  -- ==========================================
  -- EverVim IDE Essential Plugins
  -- ==========================================

  -- nvim-notify: floating notification backend (used by noice)
  {
    "rcarriga/nvim-notify",
    lazy = false,
    priority = 1000,
    opts = {
      stages = "fade",
      timeout = 2000,
      max_width = 60,
      render = "minimal",
      top_down = true,
      background_colour = "#000000",
    },
  },

  -- noice.nvim: intercepts ALL vim messages/errors at the core level
  -- Eliminates "Press ENTER to continue" for every error (E21, LSP, runtime, etc.)
  -- cmdline is DISABLED here — fine-cmdline handles : and ; instead
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      -- Disable noice cmdline — fine-cmdline already handles this
      cmdline = { enabled = false },
      -- Disable noice command history popup (we use fine-cmdline)
      messages = { enabled = true },
      popupmenu = { enabled = false },
      notify = { enabled = true },
      lsp = {
        -- Show LSP progress in bottom-right corner
        progress = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover    = { enabled = false }, -- keep default LSP hover
        signature = { enabled = false },
      },
      routes = {
        -- Route ALL errors → notify (top-right float, 2s, no cmdline prompt)
        {
          filter = { error = true },
          opts   = { skip = false },
          view   = "notify",
        },
        -- Route warnings → notify
        {
          filter = { warning = true },
          view   = "notify",
        },
        -- Silence common noisy write/search messages
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d+ lines yanked" },
              { find = "%d+ fewer lines" },
              { find = "%d+ more lines" },
              { find = "^/" },
            },
          },
          opts = { skip = true },
        },
      },
      views = {
        notify = {
          replace = true,
          merge   = false,
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      -- Wire nvim-notify as the backend so notifications appear top-right
      vim.notify = require("notify")
    end,
  },

  -- Override NvimTree: relative numbers, hide dotfiles, open in last used window
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        relativenumber = true,
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    },
  },

  -- Telescope fzf native sorter (C extension — much faster fuzzy matching)
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = false,
  },

  -- Telescope: Customize default search behavior
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "-i",
        "-F",
      }
      -- Use fzf native sorter for fast fuzzy matching
      opts.extensions = opts.extensions or {}
      opts.extensions.fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "ignore_case",
      }
      return opts
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },

  -- Neoscroll: Buttery smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = "quadratic", -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      })
    end,
  },

  -- Smear Cursor: Smooth cursor animations (like VSCode's smooth caret)
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },

  -- Fine Cmdline: Beautiful centered command line without the lag of Noice
  {
    "VonHeikemen/fine-cmdline.nvim",
    keys = {
      { ":", "<cmd>FineCmdline<CR>", mode = "n", desc = "CMD enter command mode (Centered)" },
      { ";", "<cmd>FineCmdline<CR>", mode = "n", desc = "CMD enter command mode (Centered)" },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enable_keymaps = true,
        smart_history = true,
        prompt = ": ",
      },
      popup = {
        position = {
          row = "30%",
          col = "50%",
        },
        size = {
          width = "60%",
        },
        border = {
          style = "rounded",
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
    },
  },

  -- Trouble: A pretty diagnostics, references, telescope results, quickfix and location list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  -- Todo Comments: Highlight and search for TODO, FIXME, etc.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {},
  },

  -- Nvim-surround: Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Nvim-ts-autotag: Auto close and auto rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "htmlangular", "javascriptreact", "typescriptreact", "svelte", "vue", "xml", "jsp" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        aliases = {
          ["jsp"] = "html",
        }
      })
    end,
  },

  -- Lazygit: The best Git UI
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Gitsigns: Show git blame inline like VSCode GitLens
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        virt_text     = true,
        virt_text_pos = "eol",
        delay         = 140,
        ignore_whitespace = false,
      }
      opts.current_line_blame_formatter = "        <author>, <author_time:%R> • <summary>"
      -- Only attach gitsigns to files under 500 KB
      opts.max_file_length = 10000  -- lines; skip very long files entirely
      opts._threaded_diff  = true   -- use background thread for diff computation (nvim 0.10+)
      return opts
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
      -- Blame inline: gris apagado + itálica para no confundirse con el código
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", {
        fg = "#3d4251",
        italic = true,
      })
    end,
  },

  -- Git Conflict: Beautiful VSCode-like conflict resolution with background colors
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" }, -- Changed from VeryLazy to load reliably on session restore
    config = function()
      -- Define the highlight groups manually before plugin loads them
      vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#2b5643", default = false })
      vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#2b5643", default = false })
      vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#1f3b5c", default = false })
      vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#1f3b5c", default = false })
      vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#512c40", default = false })
      vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#512c40", default = false })

      require("git-conflict").setup({
        default_mappings = false, -- We will set our own in mappings.lua
        disable_diagnostics = false, -- Changed to false to prevent deprecated vim.diagnostic.disable() error in Neovim 0.10+
        highlights = {
          -- VSCode exact colors
          current = "GitConflictCurrent",     -- HEAD (Current changes)
          incoming = "GitConflictIncoming",   -- Develop (Incoming changes)
          ancestor = "GitConflictAncestor",
        }
      })
    end,
  },

  -- Scrollbar: shows change markers (red/green) on the right edge of diff buffers
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        show_in_active_only = false,
        set_highlights = true,
        handle = { highlight = "CursorLine" },
        marks = {
          GitAdd    = { text = "▏", highlight = "GitSignsAdd" },
          GitChange = { text = "▏", highlight = "GitSignsChange" },
          GitDelete = { text = "▏", highlight = "GitSignsDelete" },
        },
        handlers = {
          cursor     = false,
          diagnostic = false,
          gitsigns   = false,
          search     = false,
          handle     = true,
        },
        excluded_filetypes = {
          "NvimTree", "lazy", "mason", "TelescopePrompt",
          "DiffviewFiles", "DiffviewFileHistory",
        },
      })
    end,
  },

  -- Diffview: GitLens-like file history with beautiful side-by-side diffs
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1a3d2b", fg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3d1a1a", fg = "#6b3333" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1a2d3d", fg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffText",   { bg = "#0d4a6b", fg = "NONE", bold = true })

      -- Track which buffers are diffview diff buffers (for the scrollbar handler)
      local diffview_bufs = {}

      -- Register custom scrollbar handler: reads DiffAdd/DiffDelete extmarks per buffer
      vim.defer_fn(function()
        local ok, handlers = pcall(require, "scrollbar.handlers")
        if not ok then return end
        handlers.register("diffview_diff", function(bufnr)
          if not diffview_bufs[bufnr] then return {} end
          if not vim.api.nvim_buf_is_valid(bufnr) then return {} end
          local marks, seen = {}, {}
          for _, ns_id in pairs(vim.api.nvim_get_namespaces()) do
            local ok2, extmarks = pcall(
              vim.api.nvim_buf_get_extmarks, bufnr, ns_id, 0, -1, { details = true }
            )
            if ok2 then
              for _, mark in ipairs(extmarks) do
                local lnum = mark[2] + 1
                local d    = mark[4]
                if d and d.hl_group and not seen[lnum] then
                  local hl = d.hl_group
                  if hl:find("[Aa]dd") then
                    table.insert(marks, { line = lnum, type = "GitAdd" })
                    seen[lnum] = true
                  elseif hl:find("[Dd]elete") then
                    table.insert(marks, { line = lnum, type = "GitDelete" })
                    seen[lnum] = true
                  end
                end
              end
            end
          end
          return marks
        end)
      end, 200)

      require("diffview").setup({
        enhanced_diff_hl = true,
        diff_binaries    = false,
        view = {
          file_history = {
            layout      = "diff2_horizontal",
            winbar_info = true,
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = { diff_merges = "first-parent" },
              multi_file  = { diff_merges = "first-parent" },
            },
          },
          win_config = { position = "bottom", height = 18 },
        },
        hooks = {
          view_opened = function(_)
            -- Move cursor to first entry (top of commit list) every time the panel opens
            vim.defer_fn(function()
              for _, winid in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(winid)
                local ft  = vim.bo[buf].filetype
                if ft == "DiffviewFileHistoryPanel" then
                  vim.api.nvim_win_call(winid, function()
                    vim.cmd("normal! gg")
                    pcall(require("diffview.actions").select_entry)
                  end)
                  break
                end
              end
            end, 80)
          end,
          diff_buf_read = function(bufnr)
            diffview_bufs[bufnr] = true

            vim.opt_local.wrap        = false
            vim.opt_local.list        = false
            vim.opt_local.colorcolumn = ""

            -- foldmethod=diff is a WINDOW option that Neovim sets after this hook.
            -- We override it per-window with a delay so it fires after diffview finishes.
            local function unfold_windows()
              if not vim.api.nvim_buf_is_valid(bufnr) then return end
              for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
                vim.api.nvim_win_call(winid, function()
                  vim.cmd("setlocal foldmethod=manual foldlevel=99")
                  pcall(vim.cmd, "normal! zR")
                end)
              end
            end

            vim.defer_fn(unfold_windows, 80)
            vim.defer_fn(unfold_windows, 250) -- second pass: covers slow renders

            -- Refresh scrollbar markers after highlights are applied
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                pcall(require("scrollbar").render)
              end
            end, 350)
          end,
          view_closed = function(_)
            diffview_bufs = {}
          end,
        },
        keymaps = {
          file_history_panel = {
            { "n", "q",     "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
            { "n", "<ESC>", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
            -- j/k: debounced preview — waits 180ms after the last keypress before loading
            -- the diff buffer, so rapid navigation never triggers a parallel load.
            { "n", "j", function()
              vim.cmd("normal! j")
              if _G._dv_preview_timer then _G._dv_preview_timer:stop() end
              _G._dv_preview_timer = vim.defer_fn(function()
                pcall(require("diffview.actions").select_entry)
              end, 180)
            end, { desc = "Next commit (preview)" } },
            { "n", "k", function()
              vim.cmd("normal! k")
              if _G._dv_preview_timer then _G._dv_preview_timer:stop() end
              _G._dv_preview_timer = vim.defer_fn(function()
                pcall(require("diffview.actions").select_entry)
              end, 180)
            end, { desc = "Prev commit (preview)" } },
          },
          view = {
            { "n", "q",     "<cmd>DiffviewClose<CR>",    { desc = "Close Diffview" } },
            { "n", "<ESC>", "<cmd>DiffviewClose<CR>",    { desc = "Close Diffview" } },
            { "n", "<C-j>", "<cmd>DiffviewFocusFiles<CR>", { desc = "Focus commit history panel" } },
          },
        },
      })
    end,
  },

  -- Auto Session: Automatically save and restore sessions (open tabs, splits, etc)
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "~/Documents" },
        auto_session_enable_last_session = false,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        -- Ensure NvChad's NvimTree and other panels are handled properly
        pre_save_cmds = {
          function()
            -- Cerrar nvim-tree si está abierto para no romper la sesión
            pcall(vim.cmd, "NvimTreeClose")
            -- Eliminar buffers sin nombre (vacíos) antes de guardar la sesión
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf)
                and vim.bo[buf].buflisted
                and vim.api.nvim_buf_get_name(buf) == ""
                and not vim.bo[buf].modified
              then
                pcall(vim.api.nvim_buf_delete, buf, { force = false })
              end
            end
          end
        },
        post_restore_cmds = {
          function()
            -- En NvChad, nvim-tree se carga "lazy". 
            -- No podemos llamar a NvimTreeOpen directamente si el plugin no se ha cargado.
            -- Es mejor simplemente no intentar abrirlo para evitar errores.
          end
        }
      })
    end,
  },
}
