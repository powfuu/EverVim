return {
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
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<Up>"] = cmp.mapping.select_prev_item()
      opts.mapping["<Down>"] = cmp.mapping.select_next_item()
      
      -- Add smooth ghost text
      opts.experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      }
    end,
  },

  -- ==========================================
  -- EverVim IDE Essential Plugins
  -- ==========================================

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
        "-i", -- Always ignore case (case-insensitive)
        "-F", -- Fixed strings (literal match, no regex)
      }
      return opts
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
    ft = { "html", "javascriptreact", "typescriptreact", "svelte", "vue", "xml", "jsp" },
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
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500, -- Delay in ms before showing the blame
        ignore_whitespace = false,
      }
      opts.current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>"
      return opts
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
