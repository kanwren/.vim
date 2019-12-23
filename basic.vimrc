set encoding=utf-8
scriptencoding utf-8
set ffs=unix
filetype plugin indent on
if has('syntax') && (!exists('syntax_on') || !syntax_on)
    syntax on
endif

" Uncomment if backups are okay
" set swapfile directory=~/.vim/tmp//
" set backup writebackup
" if has("patch-8.1.0251")
"     set backupdir=~/.vim/backup//
" else
"     set backupdir=~/.vim/backup
" endif
" if has('persistent_undo')
"     set undofile undodir=~/.vim/undo//
"     if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
" endif
" for d in [&directory, &backupdir]
"     if !isdirectory(d) | call mkdir(d, 'p') | endif
" endfor

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

set history=1000 undolevels=1000
set hidden autoread noconfirm
set noerrorbells visualbell t_vb=
set mouse-=a
set scrolloff=0
set lazyredraw
set number relativenumber
set splitbelow splitright
set cmdheight=1 showcmd
set laststatus=2 showmode
set statusline=[%n]\ %f%<\ %m%y%h%w%r\ \ %(0x%B\ %b%)%=%p%%\ \ %(%l/%L%)%(\ \|\ %c%V%)%(\ %)
set wildmenu wildmode=longest:list,full
set list listchars=tab:>-,eol:¬,extends:>,precedes:<

set virtualedit=all
set nojoinspaces
set backspace=indent,eol,start
set whichwrap+=h,l,[,]
set nrformats=bin,hex
set cpoptions+=y
set autoindent
set expandtab tabstop=4 softtabstop=4 smarttab shiftwidth=4 noshiftround
set cinoptions+=:0L0g0j1J1
set nowrap textwidth=80 formatoptions=croqjln
set magic
set noignorecase smartcase
set showmatch
set incsearch
if &t_Co > 2 || has("gui_running") | set hlsearch | endif
" set foldenable foldmethod=manual foldcolumn=1 foldlevelstart=99

let $LANG='en'
set nospell spelllang=en_us

set timeout timeoutlen=3000 ttimeout ttimeoutlen=0

" Commands
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1 | nohlsearch

" Autocommands
if has('autocmd')
    augroup general_group
        autocmd!
        autocmd FileType help wincmd L
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    augroup END
    augroup highlight_group
        autocmd!
        autocmd ColorScheme *
                    \   highlight ExtraWhitespace ctermbg=4
                    \ | highlight LineNr ctermbg=NONE ctermfg=6
                    \ | highlight CursorLineNr ctermbg=0 ctermfg=7
    augroup END
end

" Basic mappings
" Warning: all of these mappings override default behavior in some way
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap Q @q
xnoremap <silent> Q :normal @q<CR>
xnoremap <silent> . :normal .<CR>
noremap Y y$
nnoremap & :&&<CR>
xnoremap gx <Esc>`.``gvP``P
nnoremap gs :s//\r/g<Left><Left><Left><Left><Left>
xnoremap gs :s/\%V
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
cnoremap <C-r><C-l> <C-r>=substitute(getline('.'), '^\s*', '', '')<CR>
cnoremap ``g `git ls-files `<Left>

" Leader mappings
map <Space> <nop>
map <S-Space> <Space>
let mapleader=" "

nnoremap <Leader><Tab> :%s/\s\+$//e \| call histdel("/", -1) \| nohlsearch \| retab<CR>
vnoremap <silent> <Leader>vs :sort /\ze\%V/<CR>gvyugvpgv:s/\s\+$//e \| nohlsearch<CR>``
nnoremap <Leader>t :new<CR>:setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile<CR>
vnoremap <Leader>e <Esc>:execute 'normal gv' . (abs(getpos("'>")[2] + getpos("'>")[3] - getpos("'<")[2] - getpos("'<")[3]) + 1) . 'I '<CR>

" Temporary file navigation setup
nnoremap <Leader>f :find **/

" Plugins
runtime macros/matchit.vim
silent! if !empty(glob('~/.vim/autoload/plug.vim')) && !empty(glob('~/.vim/plugged')) && plug#begin(glob('~/.vim/plugged'))
    " Plug 'tpope/vim-surround'
    call plug#end()
endif

" Reasonable colorscheme
silent! colorscheme elflord

" Local vimrc
if !empty(glob('~/local.vimrc')) && filereadable(glob('~/local.vimrc'))
    execute 'source ' . glob('~/local.vimrc')
end

" Quick vim-plug setup
function! InstallVimPlug() abort
    if executable('curl')
        call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    elseif executable('wget')
        call system('mkdir -p ~/.vim/autoload && wget -O ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    else
        echoerr 'curl or wget are required to install vim-plug'
    endif
    call mkdir(expand('~/.vim/plugged'), 'p')
endfunction
