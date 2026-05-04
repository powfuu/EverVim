require("nvchad.configs.lspconfig").defaults()

local servers = { 
  "html", 
  "cssls", 
  "ts_ls", 
  "angularls", 
  "jsonls", 
  "yamlls", 
  "ruby_lsp" 
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
