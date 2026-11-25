require("nvchad.configs.lspconfig").defaults()

-- server → the program it needs. Only servers whose program is installed are started;
-- otherwise every file of that type shows "language server … not installed / missing from
-- PATH". Install one (npm, Mason…) and it's picked up the next time Neovim starts.
local servers = {
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
  ts_ls = "typescript-language-server",
  angularls = "ngserver",
  jsonls = "vscode-json-language-server",
  yamlls = "yaml-language-server",
  ruby_lsp = "ruby-lsp",
}
local installed = {}
for name, program in pairs(servers) do
  if vim.fn.executable(program) == 1 then
    table.insert(installed, name)
  end
end
vim.lsp.enable(installed)

-- Cap LSP response sizes and disable expensive features on large files
vim.lsp.config("*", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false }, -- let the OS watch files, not LSP
    },
  },
})

-- Disable semantic token highlighting for files over 250 KB (expensive re-render on every change)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local buf  = ev.buf
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > 250 * 1024 then
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end
  end,
})
