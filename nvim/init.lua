require("config.base")
require("config.lazy")

require("catppuccin").setup({
  transparent_background = true,
})

require("plenary")
require("nvim-tree").setup()
require("lualine").setup({
  options = {
    theme = "catppuccin"
  }
})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

vim.cmd.colorscheme("catppuccin-mocha")

require("config.lsp")
