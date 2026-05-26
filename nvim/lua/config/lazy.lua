local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "isovector/cornelis",
    ft = { "agda" },
    build = "stack build",
    dependencies = {
      "kana/vim-textobj-user",
      "neovimhaskell/nvim-hs.vim",
    },
    init = function()
      vim.g.mapleader = '\\'
      vim.g.maplocalleader = '\\'

      vim.keymap.set("n", "<leader>l", "<Cmd>CornelisLoad<CR><Cmd>CornelisQuestionToMeta<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>r", "<Cmd>CornelisRefine<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>d", "<Cmd>CornelisMakeCase<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>,", "<Cmd>CornelisTypeContext<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>.", "<Cmd>CornelisTypeContextInfer<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>n", "<Cmd>CornelisSolve<CR>", { buffer = 0 })
      vim.keymap.set("n", "<leader>a", "<Cmd>CornelisAuto<CR>", { buffer = 0 })
      vim.keymap.set("n", "gd",        "<Cmd>CornelisGoToDefinition<CR>", { buffer = 0 })
      vim.keymap.set("n", "[/",        "<Cmd>CornelisPrevGoal<CR>", { buffer = 0 })
      vim.keymap.set("n", "]/",        "<Cmd>CornelisNextGoal<CR>", { buffer = 0 })
      vim.keymap.set("n", "<C-A>",     "<Cmd>CornelisInc<CR>", { buffer = 0 })
      vim.keymap.set("n", "<C-X>",     "<Cmd>CornelisDec<CR>", { buffer = 0 })
      vim.keymap.set("n", "<C-space>", "<Cmd>CornelisGive<CR>", { buffer = 0 })

      vim.g.cornelis_split_location = "bottom"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true, },
        indent = { enable = true, },
      })
    end,
  },

  { "neovim/nvim-lspconfig" },

  { "nvim-tree/nvim-tree.lua" },
  { "nvim-lualine/lualine.nvim" },

  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'enter' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        menu = {
          auto_show = false,
        },
        documentation = { auto_show = true },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = {
        sorts = {
          'exact',
          'score',
          'sort_text',
        },
        implementation = "prefer_rust_with_warning",
      }
    },
    opts_extend = { "sources.default" }
  }
}

require("lazy").setup(plugins)
