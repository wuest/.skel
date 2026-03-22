-- Map leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.base")
require("config.lazy")

require("catppuccin").setup({
  transparent_background = true,
})

vim.cmd.colorscheme("catppuccin-mocha")

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

require("nvim-tree").setup()

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
  }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

require("plugins.lsp")
require("config.keymap")
