```
███████╗██╗   ██╗███████╗██████╗ ██╗   ██╗██╗███╗   ███╗
██╔════╝██║   ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
█████╗  ██║   ██║█████╗  ██████╔╝██║   ██║██║██╔████╔██║
██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗ ╚████╔╝ ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

<div align="center">

**A modern, opinionated Neovim IDE — built by [Everit Jhon](https://github.com/everit-jhon)**

*Inspired by LazyVim & NvChad. Built to feel like VS Code. Works like Neovim should.*

![Neovim](https://img.shields.io/badge/Neovim-0.10+-57A143?style=flat-square&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?style=flat-square&logo=lua&logoColor=white)
![NvChad](https://img.shields.io/badge/NvChad-v2.5-FF6B6B?style=flat-square)
![License](https://img.shields.io/badge/License-Unlicense-green?style=flat-square)

</div>

---

## What is EverVim?

EverVim is a complete Neovim IDE configuration created by **Everit Jhon**. Like LazyVim and NvChad, it gives you a fully configured editor out of the box — no setup headaches, no plugin hunting.

It sits on top of **NvChad v2.5** (which provides the theme engine, UI components, and base setup) and extends it with a curated set of plugins oriented toward **web & fullstack development**: Angular, TypeScript, Ruby, HTML/CSS, and more.

> Think of it as: NvChad as the engine, EverVim as the IDE built on top of it.

---

## Features at a Glance

- **VS Code–style keybindings** — `Cmd/Ctrl+P`, `Cmd/Ctrl+S`, `Cmd/Ctrl+F`, `Cmd/Ctrl+Z`, etc.
- **Live inline git blame** — GitLens-style per line, always visible
- **VSCode conflict resolution** — green/blue/purple markers with `space+c+o/t/b`
- **LazyGit integration** — full git UI with `space+g+g`
- **Diffview** — side-by-side file history & diffs
- **Smooth everything** — animated cursor (smear), smooth scroll, floating notifications
- **90+ themes** — live preview picker with `space+t+h`
- **Dashboard on startup** — branded EVERVIM splash with quick actions
- **LSP + Autocompletion** — 7 language servers, Mason installer, conform.nvim formatting
- **Telescope fuzzy finder** — files, grep, commands, TODOs, conflicts
- **Session persistence** — auto-save & restore per project directory
- **Trouble diagnostics panel** — errors & warnings in a dedicated sidebar

---

## Dashboard

On startup, EverVim greets you with a branded dashboard:

```
███████╗██╗   ██╗███████╗██████╗ ██╗   ██╗██╗███╗   ███╗
██╔════╝██║   ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
█████╗  ██║   ██║█████╗  ██████╔╝██║   ██║██║██╔████╔██║
██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗ ╚████╔╝ ███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

           EVERVIM — The Perfect VIM IDE
```

Quick actions available from the dashboard:

| Key | Action |
|-----|--------|
| `gf` | Find file (Telescope) |
| `fo` | Recent files |
| `fw` | Search in project (grep) |
| `th` | Theme picker |
| `ch` | Keybindings cheatsheet |

---

## Installation

### Prerequisites

```bash
# macOS
brew install neovim git ripgrep fd node npm

# Ubuntu/Debian
sudo apt install neovim git ripgrep fd-find nodejs npm
```

Also recommended: a [Nerd Font](https://www.nerdfonts.com/) for icons (e.g. JetBrainsMono Nerd Font).

### Install

```bash
# Back up existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone EverVim
git clone https://github.com/everit-jhon/evervim ~/.config/nvim

# Launch — plugins install automatically
nvim
```

On first launch, Lazy.nvim will install all plugins. Then Mason will prompt you to install the LSP servers. Type `:MasonInstall` or use `:Mason` UI.

### First Run Checklist

```
✓ Plugins installed via lazy.nvim (automatic)
✓ :Mason → install language servers (see LSP section)
✓ :TSInstall all → install treesitter parsers (automatic)
✓ Select theme: <Space>th
```

---

## Plugin List

### Framework
| Plugin | Purpose |
|--------|---------|
| `NvChad/NvChad` v2.5 | Base framework — theme engine, UI, defaults |
| `folke/lazy.nvim` | Plugin manager |

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| `neovim/nvim-lspconfig` | LSP client configuration |
| `williamboman/mason.nvim` | LSP/DAP/formatter installer |
| `hrsh7th/nvim-cmp` | Autocompletion engine |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source |
| `hrsh7th/cmp-buffer` | Buffer word completion |
| `hrsh7th/cmp-nvim-lua` | Neovim Lua API completion |
| `FelipeLema/cmp-async-path` | Async path completion |
| `L3MON4D3/LuaSnip` | Snippet engine |
| `rafamadriz/friendly-snippets` | Snippet library |
| `stevearc/conform.nvim` | Code formatter (Prettier, Stylua, Rubocop) |

### Syntax & Editing
| Plugin | Purpose |
|--------|---------|
| `nvim-treesitter` | Syntax highlighting & code parsing |
| `nvim-ts-autotag` | Auto close/rename HTML tags |
| `windwp/nvim-autopairs` | Auto-close brackets & parens |
| `kylechui/nvim-surround` | Surround operations (`cs`, `ds`, `ys`) |
| `lukas-reineke/indent-blankline.nvim` | Visual indent guides |

### UI & Navigation
| Plugin | Purpose |
|--------|---------|
| `nvim-tree/nvim-tree.lua` | File explorer |
| `nvim-telescope/telescope.nvim` | Fuzzy finder |
| `telescope-fzf-native.nvim` | Native C speedup for Telescope |
| `folke/which-key.nvim` | Leader key popup hints |
| `nvim-tree/nvim-web-devicons` | File type icons |

### UI Enhancements
| Plugin | Purpose |
|--------|---------|
| `folke/noice.nvim` | Message & command UI overhaul |
| `rcarriga/nvim-notify` | Floating notifications |
| `VonHeikemen/fine-cmdline.nvim` | Centered, beautiful command line |
| `sphamba/smear-cursor.nvim` | Smooth cursor animations |
| `karb94/neoscroll.nvim` | Smooth scrolling |
| `petertriho/nvim-scrollbar` | Scrollbar with git change markers |

### Git
| Plugin | Purpose |
|--------|---------|
| `lewis6991/gitsigns.nvim` | Inline git blame & gutter signs |
| `akinsho/git-conflict.nvim` | VSCode-style conflict resolution |
| `kdheepak/lazygit.nvim` | LazyGit UI integration |
| `sindrets/diffview.nvim` | Side-by-side diffs & file history |

### Diagnostics & Tools
| Plugin | Purpose |
|--------|---------|
| `folke/trouble.nvim` | Diagnostics & references panel |
| `folke/todo-comments.nvim` | TODO/FIXME highlighting & search |
| `rmagatti/auto-session` | Auto save/restore sessions |

---

## Language Support

| Language | LSP Server | Formatter | Treesitter |
|----------|-----------|-----------|-----------|
| HTML | `html` | Prettier | ✓ |
| CSS / SCSS | `cssls` | Prettier | ✓ |
| JavaScript | `ts_ls` | Prettier | ✓ |
| TypeScript | `ts_ls` | Prettier | ✓ |
| JSX / TSX | `ts_ls` | Prettier | ✓ |
| Angular | `angularls` | Prettier | ✓ |
| JSON | `jsonls` | Prettier | ✓ |
| YAML | `yamlls` | Prettier | ✓ |
| Ruby | `ruby_lsp` | Rubocop | ✓ |
| Lua | — | Stylua | ✓ |
| JSP | — | — | HTML parser |

---

## Keybindings

> Leader key = `Space`

### Files & Search

| Action | Mac | Linux/Win |
|--------|-----|-----------|
| Find file | `Cmd+P` | `Ctrl+P` |
| Search in project | `Cmd+Shift+F` | `Ctrl+Shift+F` |
| Search in file | `Cmd+F` | `Ctrl+F` |
| Command palette | `Cmd+Shift+P` | `Ctrl+Shift+P` |
| Find TODOs / FIXMEs | `Space+F+T` | `Space+F+T` |
| Find merge conflicts | `Space+F+C` | `Space+F+C` |

### Editing

| Action | Mac | Linux/Win |
|--------|-----|-----------|
| Save (no format) | `Cmd+S` | `Ctrl+S` |
| Save + format | `Cmd+Shift+S` | `Ctrl+Shift+S` |
| Undo | `Cmd+Z` | `Ctrl+Z` |
| Redo | `Cmd+Shift+Z` | `Ctrl+Y` |
| Toggle comment | `Cmd+/` | `Ctrl+/` |
| Copy | `Cmd+C` | `Ctrl+C` |
| Paste | `Cmd+V` | `Ctrl+V` |

### Buffers, Tabs & Windows

| Action | Keybinding |
|--------|-----------|
| Close window/split | `Cmd+W` / `Ctrl+W` |
| Close buffer | `Space+W` |
| Previous tab | `Ctrl+H` |
| Next tab | `Ctrl+L` |
| Window left | `Shift+H` |
| Window right | `Shift+L` |
| Window down | `Shift+J` |
| Window up | `Shift+K` |
| Split left | `Ctrl+Shift+H` |
| Split right | `Ctrl+Shift+L` |
| Split down | `Ctrl+Shift+J` |
| Split up | `Ctrl+Shift+K` |
| Quit all | `Cmd+Q` / `Ctrl+Q` |

### Explorer & Terminal

| Action | Mac | Linux/Win |
|--------|-----|-----------|
| Toggle file explorer | `Cmd+M` | `Ctrl+M` |
| Toggle terminal | `Cmd+N` | `Ctrl+N` |
| Terminal → normal mode | `Esc` | `Esc` |

### Git

| Action | Keybinding |
|--------|-----------|
| LazyGit UI | `Space+G+G` |
| Git blame (commit detail) | `G+T` |
| File history / diffview | `Ctrl+,` |
| Conflict → ours | `Space+C+O` |
| Conflict → theirs | `Space+C+T` |
| Conflict → both | `Space+C+B` |
| Conflict → none | `Space+C+0` |
| Next conflict | `]C` |
| Previous conflict | `[C` |

### Diagnostics

| Action | Keybinding |
|--------|-----------|
| Diagnostics panel | `Space+X+X` |
| Buffer diagnostics | `Space+X+W` |

### Theme

| Action | Keybinding |
|--------|-----------|
| Theme picker (live preview) | `Space+T+H` |

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                  # Entry point — lazy bootstrap, theme load
├── EVERVIM_KEYS.md           # Full keybindings reference (Spanish)
│
└── lua/
    ├── options.lua           # Neovim options (tabs, lines, clipboard, etc.)
    ├── mappings.lua          # All keybindings (300+ lines)
    ├── autocmds.lua          # Autocommands & custom behaviors
    ├── chadrc.lua            # NvChad theme & UI config
    │
    ├── configs/
    │   ├── lazy.lua          # Lazy.nvim setup
    │   ├── lspconfig.lua     # LSP servers & capabilities
    │   └── conform.lua       # Formatter config per filetype
    │
    └── plugins/
        └── init.lua          # All plugin specs (44 plugins)
```

---

## Themes

EverVim ships with 90+ themes via NvChad's base46 engine.

Default theme: **yoru** (deep dark, low contrast)

Open the live picker with `Space+T+H` — changes apply instantly without restart.

Some favorites included:
`carbonfox` · `decay` · `midnight_breeze` · `onedark` · `pastelbeans` · `rxyhn` · `yoru`

---

## Credits

- **[NvChad](https://github.com/NvChad/NvChad)** — base framework, theme engine, UI system
- **[LazyVim](https://github.com/LazyVim/starter)** — structural inspiration for the starter layout
- **[folke](https://github.com/folke)** — lazy.nvim, which-key, noice, trouble, todo-comments
- All plugin authors listed above

---

<div align="center">

Made with care by **Everit Jhon**

*EverVim is free and unencumbered software released into the public domain.*

</div>
