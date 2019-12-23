" Basic settings
scriptencoding utf-8
set ffs=unix

" These are pretty likely to break on minimal vim installations
set encoding=utf-8
filetype plugin indent on
if has('syntax') && (!exists('syntax_on') || !syntax_on)
    syntax on
endif

" Backups
" set swapfile directory=~/.vim/tmp//
" set backup writebackup backupcopy=auto
" if has("patch-8.1.0251")
"     set backupdir=~/.vim/backup//
" else
"     set backupdir=~/.vim/backup
" endif
" if has('persistent_undo')
"     set undofile undodir=~/.vim/undo//
"     if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
" endif
" for d in [&directory, &backupdir, &undodir]
"     if !isdirectory(d) | call mkdir(d, 'p') | endif
" endfor

" Buffers
set hidden
set autoread

" Disable annoying flashing/beeping
set noerrorbells
set visualbell t_vb=

" Navigation
set mouse=a
set scrolloff=0

" Display
set lazyredraw
set shortmess+=I
set splitbelow splitright
set number relativenumber
set list listchars=tab:>-,extends:>,precedes:<
set nocursorline nocursorcolumn
set laststatus=2
set statusline=[%n]\ %f%<\ %m%y%h%w%r\ \ %(0x%B\ %b%)%=%p%%\ \ %(%l/%L%)%(\ \|\ %c%V%)%(\ %)
set showmode
set cmdheight=1
set showcmd
set wildmenu
set wildmode=longest:list,full

" Editing
set nojoinspaces
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set nrformats=bin,hex

" Attempt to set up a clipboard
if has('clipboard')
    set clipboard=unnamed
    if has('unnamedplus')
        set clipboard+=unnamedplus
    endif
endif

" Indentation settings
set autoindent
set tabstop=4
set expandtab softtabstop=4
set shiftwidth=4
set smarttab
set noshiftround
set cinoptions+=:0L0g0j1J1

" Text formatting
set nowrap
set textwidth=80
set formatoptions=croqjln

" Searching and case sensitivity
set magic
set noignorecase smartcase
set showmatch
set incsearch
set hlsearch

" Timeouts
set timeout timeoutlen=3000
set ttimeout ttimeoutlen=0

" Decent default colorscheme
colorscheme elflord

