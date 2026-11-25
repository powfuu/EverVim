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
-- Only start servers that are installed; otherwise every file of that type shows
-- "language server ... not installed / missing from PATH" (e.g. vscode-json-language-server).
-- Install one (npm, Mason…) and it's picked up on the next start.
local installed = vim.tbl_filter(function(name)
  local cfg = vim.lsp.config[name]
  local cmd = cfg and cfg.cmd
  return type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1
end, servers)
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
