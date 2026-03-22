-- No mouse interaction
vim.opt.mouse = ""

vim.g.have_nerd_font = true

-- Plenty of history
vim.opt.history = 1000

-- Automatically chdir
vim.opt.autochdir = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Share clipboard with the OS
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Highlight trailing spaces
vim.opt.list = true
vim.opt.listchars:append({trail = '·'})

-- Incremental search, highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showcmd = true
vim.o.inccommand = split

-- Scroll when 5 characters from the edge
vim.opt.scrolloff = 5

-- Set the title
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"

-- Short status messages
vim.opt.shortmess = "aOstT"

-- Use UTF-8 by default
vim.opt.encoding = "utf-8"

-- Use US English spelling
vim.opt.spelllang = "en_us"

-- Do not wrap lines
vim.opt.wrap = false

-- Folding
vim.wo.foldmethod = 'syntax'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel=1
