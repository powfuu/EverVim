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
