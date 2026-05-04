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
      -- NvChad already uses <CR> (Enter) to accept completions,
      -- so we just make sure Up/Down arrow keys work like VSCode
    end,
  },

  -- ==========================================
  -- EverVim IDE Essential Plugins
  -- ==========================================

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
