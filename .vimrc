" Notes {
"   This setup assumes the existence of $HOME/.vim/{backup,tmp}
"
"   Once a fold is open, the assumption is that it is desired to remain open
"   and only by manually closing the fold will the fold be re-closed.
" }

" Basic Settings {
    " Explicitly disable compatible mode (override -C)
    set nocompatible

    " Hold on to plenty of history
    set history=1000

    " Most terminals will be dark.  This can be overriden in .gvimrc
    set background=dark

    " Allow backspacing over everything in insert mode
    set backspace=2

    " Set up cpoptions
    set cpoptions=aABceFsmq
    "             ||||||||+-- Leave the cursor between joined lines
    "             |||||||+-- Pause when new match is created
    "             ||||||+-- Set options upon entering a buffer
    "             |||||+-- :write updates the current file name
    "             ||||+-- Automatically add <CR> to registers
    "             |||+-- Search continues at the end of the current match
    "             ||+-- Backslashes have no special meaning for :map
    "             |+-- :write sets alternative file name
    "             +-- :read sets alternative file name

    " Turn off modeline support by default
    set nomodeline
" }

" Vundle {
    " Depend on Vundle {
    if isdirectory($HOME . '/.vim/bundle') == 1
        " Turn off filetype to let Vundle do its magic
        filetype off

        set rtp+=~/.vim/bundle/vundle
        call vundle#rc()

        " Let Vundle manage itself
        Bundle 'gmarik/vundle'

        " Colorschemes collections (Molokai/irblack)
        Bundle 'flazz/vim-colorschemes'
        Bundle 'wesgibbs/vim-irblack'

        " Vim functionality plugins
		Bundle 'scrooloose/syntastic'
		Bundle 'ctrlpvim/ctrlp.vim'
		Bundle 'tomtom/tlib_vim'
		Bundle 'MarcWeber/vim-addon-mw-utils'
		Bundle 'garbas/vim-snipmate'
		Bundle 'scrooloose/nerdtree'
		Bundle 'scrooloose/nerdcommenter'

        " Add Erlang/Elixir Language support
        Bundle 'vim-erlang/vim-erlang-runtime.git'
        Bundle 'vim-erlang/vim-erlang-compiler.git'
        Bundle 'vim-erlang/vim-erlang-omnicomplete.git'
        Bundle 'vim-erlang/vim-erlang-tags.git'
        Bundle 'elixir-lang/vim-elixir'

        " Racket support
        Bundle 'wlangstroth/vim-racket'

        " Haskell support
        Bundle 'neovimhaskell/haskell-vim'

        " Elm support
        Bundle 'ElmCast/elm-vim'

        let $PYTHONPATH='/usr/lib/python3.7/site-packages'
        " Airline provides a nice status line
        Bundle 'bling/vim-airline'
        let g:airline_powerline_fonts=1
    endif " }
" }

" Behavior {
    " Load filetype indentation and plugins
    filetype plugin indent on

    " Always chdir to the current file's location
    set autochdir

    " Always create backup files
    set backup

    " Backup and swap files will live in $HOME/.vim{backup,tmp}
    set backupdir=~/.vim/backup
    set directory=~/.vim/tmp

    " Alias the * register to the system's clipboard
    set clipboard=unnamedplus

    " Support all three formats (<CR>, <CR><LF>, and <LF><CR>) in that order
    set fileformats=unix,dos,mac

    " Be quiet
    set noerrorbells

    " Turn auto-indentation on, but be smart about it
    set autoindent
    set smartindent
" }

" UI {
    " Set colorscheme to ir_black (installed by vundle)
    colorscheme ir_black

    " Incremental search, highlight matches
    set hlsearch
    set incsearch

    " Show the Status Line (Airline)
    set laststatus=2

    " Always show the ruler
    set ruler

    " Avoid redrawing when possible
    set lazyredraw

    " Show matching brackets, blink them for 0.2 seconds
    set noshowmatch
    set matchtime=0

    " Don't jump to the first non-whitespace on a line
    set nostartofline

    " Report when anything is changed via :commands
    set report=0

    " Short status messages
    set shortmess=aOstT

    " Always show the command being typed
    set showcmd

    " Scroll when 5 characters from the edge
    set scrolloff=5

    " Set auto-complete to offer the longest possible match
    set completeopt=longest,menuone

    " Highlight column 80 to warn about long lines
    set colorcolumn=80
" }

" Text Formatting/Layout {
    " Use UTF-8
    set encoding=utf-8

    " Automatically start comments, gq formats comments
    set formatoptions=q

    " Don't wrap lines
    set nowrap

    " Contextually be case-sensitive
    set smartcase

    " By default, real tabs should be 8 characters wide
    set tabstop=8
" }

" Folding {
    " Turn folding on by default
    set foldenable

    " Folding should be done by syntax generally
    set foldmethod=syntax

    " By default, let's fold everything but the top level
    set foldlevel=1

    " By default, everything can open a fold except vertical movement
    set foldopen=block,hor,insert,jump,mark,percent,search,tag,undo,quickfix
" }

" Filetype settings {
    au BufNewFile,BufRead *.hsc    set filetype=haskell
    au BufNewFile,BufRead *.rbi    set filetype=ruby

    " Make editing this file nice
    autocmd Filetype vim set foldmarker={,} foldlevel=0 foldmethod=marker expandtab shiftwidth=4 tabstop=4

    autocmd Filetype ruby          set shiftwidth=2 tabstop=2 expandtab
    autocmd Filetype ruby          map <Leader>T :call system("tmux splitw -v 'rake test;read';tmux last-pane")<cr>
    autocmd Filetype javascript    set shiftwidth=2 tabstop=2 expandtab
    autocmd Filetype erlang        set shiftwidth=4 tabstop=4 expandtab
    autocmd Filetype python        set shiftwidth=4 tabstop=4 expandtab
    autocmd Filetype c,cpp         set shiftwidth=4 tabstop=4 foldlevel=0
    autocmd Filetype html,xml      set shiftwidth=1 tabstop=1 expandtab
    autocmd Filetype eruby         set shiftwidth=1 tabstop=1 expandtab
    autocmd Filetype tex,plaintex  set shiftwidth=2 tabstop=2 expandtab wrap lbr
    autocmd Filetype yaml          set shiftwidth=2 tabstop=2 expandtab
    autocmd Filetype haskell,cabal set shiftwidth=4 tabstop=4 shiftwidth=4 expandtab shiftround
" }

" Nerdtree {
    map <Leader>f :NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen=1
" }

" Overrides {
    " These get put at the end of vimrc to guarantee it always takes effect
    " Make sure syntax highlighting is always enabled
    syntax on

    "  Set the column count warning to something easier on the eyes
    hi ColorColumn ctermbg=DarkBlue

    " Optionally load local configuration
    if filereadable(expand("~/.vimrc-local"))
        source ~/.vimrc-local
    endif
" }

function! Co()
    let mtime = strftime("%Y%m%d%H%M.%S", getftime(expand("%")))
    exe "!touch -t " . mtime . " %"
    checktime

    write
endfunction
command! Co call Co()
