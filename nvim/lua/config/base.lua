-- Ported from vim config

--
-- Basic Settings
--

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Map leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Compatible options
local cpoptions = "aABceFsmq"
--                 ||||||||+-- Leave the cursor between joined lines
--                 |||||||+-- Pause when a new match is created
--                 ||||||+-- Set options upon entering a buffer
--                 |||||+-- :write updates the current filename
--                 ||||+-- Automatically add <CR> to registers
--                 |||+-- Search continues at the end of the current match
--                 ||+-- Backslashes have no special meaning for :map
--                 |+-- :write sets alternative filename
--                 +-- :read sets alternative filename
vim.api.nvim_set_option_value('cpoptions', cpoptions, {})

vim.opt.mouse = ""

-- Lots of history, this is usually enough to undo 100% of a session
vim.opt.history = 1000

-- Allow backspace over everything while in insert mode
vim.opt.backspace = "2"

-- Automatically chdir
vim.opt.autochdir = true

-- Set up backup/working dirs
local basepath = vim.fn.stdpath("data") .. "/.vim"
if not (vim.uv or vim.loop).fs_stat(basepath .. "/backup") then
  vim.fn.system({ "mkdir", "-p", basepath .. "/backup" })
end
if not (vim.uv or vim.loop).fs_stat(basepath .. "/tmp") then
  vim.fn.system({ "mkdir", "-p", basepath .. "/tmp" })
end
vim.opt.backup = true
vim.opt.swapfile = true
vim.opt.backupdir = basepath .. "/backup"
vim.opt.directory = basepath .. "/tmp"

-- System Clipboard
vim.opt.clipboard:append({ "unnamed" })

-- Be Quiet
vim.opt.errorbells = false

-- Turn auto-indentation on, but be smart
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

--
-- UI
--

-- Use 24 bit colors
vim.opt.termguicolors = true

-- Incremental search, highlight matches
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Show the status line
vim.opt.laststatus = 2

-- Always show the ruler
vim.opt.ruler = true

-- Show matching brackets, blink them for 0.2 seconds
vim.opt.showmatch = false
vim.opt.matchtime = 0

-- Don't jump to the first non-whitespace on a line
vim.opt.startofline = false

-- Report when anything is changed via commands
vim.opt.report = 0

-- Short status messages
vim.opt.shortmess = "aOstT"

-- Always show the command being typed
vim.opt.showcmd = true

-- Scroll when 5 characters from the edge
vim.opt.scrolloff = 5

-- Set the title
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"

--
-- Text Formatting/Layout
--

-- Use UTF-8 by default
vim.opt.encoding = "utf-8"

-- Use US English spelling
vim.opt.spelllang = "en_us"

-- Do not wrap lines
vim.opt.wrap = false

-- Be contextually case-sensitive
vim.opt.smartcase = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Make sure trailing characters are visible
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
}

-- Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel=1
