-- Documentation for installing language servers located at:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.diagnostic.config({
  virtual_text = true,
})

-- Bash
vim.lsp.enable("bashls")

-- C/C++
vim.lsp.enable("clangd")

-- TeX
vim.lsp.enable("digestif")

-- Elm
vim.lsp.enable("elmls")

-- Erlang
vim.lsp.enable("elp")

-- ECMAScript (Javascript)
vim.lsp.enable("eslint")

-- Golang
vim.lsp.enable("gopls")

-- Haskell
vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
})
vim.lsp.enable("hls")

-- HTML
vim.lsp.enable("html")

-- Lua
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable("lua_ls")

-- Racket
vim.lsp.enable('racket_langserver')

-- Ruby
vim.lsp.enable("rubocop")
vim.lsp.enable("ruby_lsp")
vim.lsp.enable("sorbet")
vim.lsp.enable("typeprof")

-- Rust
vim.lsp.enable("rust_analyzer")

-- Tag generation
vim.lsp.enable("ttags")
