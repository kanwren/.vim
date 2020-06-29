" Settings {{{
" Basic
    set encoding=utf-8
    scriptencoding utf-8
    set ffs=unix
    " Enable filetype detection
    filetype plugin indent on
    " Prevent highlighting from changing when re-sourcing vimrc
    if has('syntax') && (!exists('syntax_on') || !syntax_on)
        syntax on
    endif

" Backups
    set swapfile directory=~/.vim/tmp//
    set backup writebackup backupcopy=auto
    " This patch fixes a bug to make Vim respect // for backupdir
    if has("patch-8.1.0251")
        set backupdir=~/.vim/backup//
    else
        set backupdir=~/.vim/backup/
    endif
    if has('persistent_undo')
        set undofile undodir=~/.vim/undo//
        if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
    endif
    for d in [&directory, &backupdir]
        if !isdirectory(d) | call mkdir(d, 'p') | endif
    endfor

" Diff algorithm
    if has("patch-8.1.0360")
        set diffopt+=internal,algorithm:patience
    endif

" Buffers
    set hidden                           " allow working with buffers
    set autoread
    set noconfirm                        " fail, don't ask to save
    set modeline modelines=1             " use one line to tell vim how to read the buffer

" History
    set history=1000
    set undolevels=1000

" Disable annoying flashing/beeping
    set noerrorbells
    set visualbell t_vb=

" Navigation
    set mouse-=a
    set scrolloff=0
    set tags=tags;/

" Display
    set lazyredraw                       " don't redraw until after command/macro
    set shortmess+=I                     " disable Vim intro screen
    set shortmess+=c                     " don't give ins-completion-menu messages
    set splitbelow splitright            " sensible split defaults
    set number relativenumber            " use Vim properly
    set list listchars=tab:>-,eol:¬,extends:>,precedes:<
    set nocursorline nocursorcolumn
    " statusline
    set laststatus=2
    set statusline=[%n]\ %f%<\ %m%y%h%w%r\ \ %(0x%B\ %b%)%=%p%%\ \ %(%l/%L%)%(\ \|\ %c%V%)%(\ %)
    set showmode
    " command bar
    set cmdheight=1
    set showcmd
    " completion menu
    set wildmenu
    set wildmode=longest:list,full
    " sign column
    set signcolumn=yes

" Editing
    if has('clipboard')
        set clipboard=unnamed
        if has('unnamedplus')
            set clipboard+=unnamedplus
        endif
    endif
    set virtualedit=all                  " allow editing past the ends of lines
    set nojoinspaces                     " never two spaces after sentence
    set backspace=indent,eol,start       " let backspace delete linebreak
    set whichwrap+=<,>,h,l,[,]           " direction key wrapping
    set nrformats=bin,hex                " don't increment octal numbers
    set cpoptions+=y                     " let yank be repeated with . (primarily for repeating appending)

" Indentation
    set autoindent
    set tabstop=4                        " treat tabs as 4 spaces wide
    set expandtab softtabstop=4          " expand tabs to 4 spaces
    set shiftwidth=4                     " use 4 spaces when using > or <
    set smarttab
    set noshiftround
    set cinoptions+=:0L0g0j1J1#0         " indent distance for case, jumps, scope declarations, and pragmas

" Formatting
    set nowrap
    set textwidth=80
    set colorcolumn=+1
    set formatoptions=croqjln

" Searching
    set magic
    set noignorecase smartcase
    set showmatch
    set incsearch
    if &t_Co > 2 || has("gui_running")
        set hlsearch
    endif

" Folds
    set foldenable
    set foldmethod=manual
    set foldcolumn=1
    set foldlevelstart=99

" Spelling and thesaurus
    let $LANG='en'
    set nospell spelllang=en_us
    set thesaurus=~/.vim/thesaurus/mthesaur.txt

" Timeouts
    "set ttyfast
    " Time out on mappings after 3 seconds
    set timeout timeoutlen=3000
    " Time out immediately on key codes
    set ttimeout ttimeoutlen=0
    " Diagnostic messages
    set updatetime=300
" }}}

" Autocommands/highlighting {{{
    if has('autocmd')
        augroup general_group
            autocmd!
            " Open help window on right by default
            autocmd FileType help wincmd L
            " Return to last edit position when opening files
            autocmd BufReadPost *
                        \   if line("'\"") > 1 && line("'\"") <= line("$")
                        \ |     execute "normal! g`\""
                        \ | endif
            " Highlight trailing whitespace (except when typing at end of line)
            autocmd BufRead     * match ExtraWhitespace /\s\+$/
            autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
            autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
            autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        augroup END
        " Highlighting
        augroup highlight_group
            autocmd!
            " Highlight trailing whitespace
            autocmd ColorScheme * highlight ExtraWhitespace ctermbg=DarkBlue
            " Left column
            autocmd ColorScheme *
                        \   highlight FoldColumn ctermbg=NONE
                        \ | highlight Folded ctermbg=NONE ctermfg=DarkCyan
                        \ | highlight LineNr ctermbg=NONE ctermfg=DarkCyan
                        \ | highlight CursorLineNr ctermbg=NONE ctermfg=LightGray
            " Highlight text width boundary boundary
            autocmd ColorScheme * highlight ColorColumn ctermbg=DarkGray
            " Highlight TODO and spelling mistakes in intentionally red
            autocmd ColorScheme * highlight Todo ctermbg=DarkRed ctermfg=LightGray
            autocmd ColorScheme * highlight SpellBad cterm=underline ctermfg=red
            " Highlight listchars and non-printable characters
            autocmd ColorScheme * highlight SpecialKey ctermfg=DarkBlue
            autocmd ColorScheme * highlight NonText ctermfg=DarkBlue
            " Highlight completion menu
            autocmd ColorScheme * highlight Pmenu ctermbg=Black ctermfg=DarkGray
            autocmd ColorScheme * highlight PmenuSel ctermfg=White
        augroup END
    endif
" }}}

" Functions/commands {{{
    " Make unlisted scratch buffer
    command! Scratch new | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    " Force sudo write trick
    command! WS :execute ':silent w !sudo tee % > /dev/null' | :edit!
    " Show calendar and date/time
    command! Cal :!clear && cal -y; date -R

    function! s:GetTemplates(arglead, cmdline, cursorpos) abort
        let paths = split(glob('~/.vim/templates/*.txt'), "\n")
        let names = map(paths, 'fnamemodify(v:val, ":t:r")')
        if empty(a:arglead)
            return names
        else
            return filter(names, {idx, val -> len(val) >= len(a:arglead) && val[:len(a:arglead) - 1] ==# a:arglead})
        endif
    endfunction
    command! -bang -nargs=1 -complete=customlist,<SID>GetTemplates ReadTemplate execute 'read ~/.vim/templates/' . <q-args> . '.txt'

    " Fetch mthesaurus.txt from gutenberg with curl
    function! GetThesaurus() abort
        let url = 'http://www.gutenberg.org/files/3202/files/mthesaur.txt'
        let path = '~/.vim/thesaurus/mthesaur.txt'
        call system('curl --create-dirs ' . url . ' -o ' . path)
    endfunction
" }}}

" Mappings {{{

" Leader configuration
    map <Space> <nop>
    map <S-Space> <Space>
    let mapleader=" "

" Essential
    " Work by visual line without a count, but normal when used with one
    noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
    " Makes temporary macros faster
    nnoremap Q @q
    " Repeat macros/commands across visual selections
    xnoremap <silent> Q :normal @q<CR>
    xnoremap <silent> . :normal .<CR>
    " Redraw page and clear highlights
    noremap <silent> <C-l> :nohlsearch<CR><C-l>

" Editing
    " Split current line by provided regex (\zs or \ze to preserve separators)
    nnoremap gs :s//\r/g<Left><Left><Left><Left><Left>
    " Start a visual substitute
    xnoremap gs :s/\%V
    " Sort visual selection
    vnoremap <silent> <Leader>s :sort /\ze\%V/<CR>gvyugvpgv:s/\s\+$//e \| nohlsearch<CR>``
    " Open an unlisted scratch buffer
    nnoremap <Leader>s :Scratch<CR>
    " Run makeprg and automatically return
    nnoremap m<CR> :make<CR><CR>

" Managing Whitespace
    " Delete trailing whitespace and retab
    nnoremap <silent> <Leader><Tab> :let wv=winsaveview()<CR>:keeppatterns %s/\s\+\ze\r\=$//e \| nohlsearch \| retab<CR>:call winrestview(wv) \| unlet wv<CR>
    " Add blank line below/above line/selection, keep cursor in same position (can take count)
    nnoremap <silent> <Leader>n :<C-u>call append(line("."), repeat([''], v:count1)) \| call append(line(".") - 1, repeat([''], v:count1))<CR>
    " Expand line by padding visual block selection with spaces
    function! s:Expand() abort
        let l = getpos("'<")
        let r = getpos("'>")
        execute 'normal gv' . (abs(r[2] + r[3] - l[2] - l[3]) + 1) . 'I '
    endfunction
    vnoremap <Leader>e <Esc>:call <SID>Expand()<CR>

" Registers
    " Copy contents of register to another (provides ' as an alias for ")
    function! s:RegMove() abort
        let r1 = substitute(nr2char(getchar()), "'", "\"", "")
        let r2 = substitute(nr2char(getchar()), "'", "\"", "")
        execute 'let @' . r2 . '=@' . r1
        echo "Copied @" . r1 . " to @" . r2
    endfunction
    nnoremap <silent> <Leader>r :call <SID>RegMove()<CR>

" Matching navigation commands, like in unimpaired
    for [l, c] in [["b", "b"], ["t", "t"], ["q", "c"], ["l", "l"]]
        let u = toupper(l)
        execute "nnoremap ]" . l . " :" . c . "next<CR>"
        execute "nnoremap [" . l . " :" . c . "previous<CR>"
        execute "nnoremap ]" . u . " :" . c . "last<CR>"
        execute "nnoremap [" . u . " :" . c . "first<CR>"
    endfor

" Quick settings changes
    " Filetype ftplugin editing
    nnoremap <Leader>vf :edit ~/.vim/ftplugin/<C-r>=&filetype<CR>.vim<CR>
    " Change indent level on the fly
    function s:ChangeIndent() abort
        let i=input('ts=sts=sw=')
        if i
            execute 'setlocal tabstop=' . i . ' softtabstop=' . i . ' shiftwidth=' . i
        endif
        redraw
        echo 'ts=' . &tabstop . ', sts=' . &softtabstop . ', sw='  . &shiftwidth . ', et='  . &expandtab
    endfunction
    nnoremap <Leader>i :call <SID>ChangeIndent()<CR>

" fzf mappings (<Leader>f)
    " Search all git ls-files files
    nnoremap <Leader><Leader> :GFiles<CR>
    " Search all files
    nnoremap <Leader>ff :Files<CR>
"}}}

" Abbreviations {{{
" Common sequences
    iabbrev xaz <C-r>='abcdefghijklmnopqrstuvwxyz'<CR>
    iabbrev xAZ <C-r>='ABCDEFGHIJKLMNOPQRSTUVWXYZ'<CR>
    iabbrev x09 <C-r>='0123456789'<CR>

" Date/time abbreviations
    if exists('*strftime')
        " 2018-09-15
        iabbrev <expr> xymd strftime("%Y-%m-%d")
        " Sat 15 Sep 2018
        iabbrev <expr> xdate strftime("%a %d %b %Y")
        " 23:31
        iabbrev <expr> xtime strftime("%H:%M")
        " 2018-09-15T23:31:54
        iabbrev <expr> xiso strftime("%Y-%m-%dT%H:%M:%S")
    endif
" }}}

" Plugins {{{
    " It's in the runtime *shrug*
    runtime macros/matchit.vim

    function! InstallVimPlug() abort
        if empty(glob('~/.vim/autoload/plug.vim'))
            let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            if executable('curl')
                call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs ' . url)
            elseif executable('wget')
                call system('mkdir -p ~/.vim/autoload && wget -O ~/.vim/autoload/plug.vim ' . url)
            else
                echoerr 'curl or wget are required to install vim-plug'
            endif
            echo 'vim-plug installation complete'
        else
            echo 'vim-plug is already installed'
        endif
        if empty(glob('~/.vim/plugged'))
            let make_plugged = input('~/.vim/plugged plugin directory not found. create? (y/n) ', '')
            if make_plugged =~? '^y'
                call mkdir(expand('~/.vim/plugged'), 'p')
            endif
        endif
    endfunction

    let g:lsp_diagnostics_enabled = 1
    let g:lsp_signs_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_error = { 'text': '✗' }
    let g:lsp_signs_warning = { 'text': '!' }
    let g:lsp_signs_hint = { 'test': '?' }

    let g:lc3_detect_asm = 1

    silent! if !empty(glob('~/.vim/autoload/plug.vim'))
                \ && !empty(glob('~/.vim/plugged'))
                \ && plug#begin('~/.vim/plugged')
        " Functionality
        Plug 'tpope/vim-fugitive'                " Git integration

        " Utility
        Plug 'tpope/vim-surround'                " Mappings for inserting/changing/deleting surrounding characters/elements
        Plug 'mg979/vim-visual-multi'            " Multiple cursors (I will happily defend this philosophy)
        Plug 'airblade/vim-rooter'               " cd to project root
        Plug 'tpope/vim-eunuch'                  " File operations
        Plug 'tpope/vim-commentary'              " Easy commenting
        Plug 'tpope/vim-abolish'                 " Smart substitution, spelling correction, etc.
        Plug 'tommcdo/vim-exchange'              " Operators for exchanging text
        Plug 'jiangmiao/auto-pairs', { 'for': [ 'rust', 'java', 'c', 'cpp', 'javascript', 'typescript' ] }

        " Fuzzy finding
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
        Plug 'junegunn/fzf.vim'

        " Interface/colorschemes
        Plug 'rakr/vim-one'

        " LSP
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'mattn/vim-lsp-settings'
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'

        " Language-specific plugins
        Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
        Plug 'rust-lang/rust.vim', { 'for': 'rust' }
        Plug 'LnL7/vim-nix', { 'for': 'nix' }
        " Typescript/Javascript
        Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
        Plug 'jason0x43/vim-js-indent', { 'for': [ 'javascript', 'typescript' ] }
        " Markdowns, etc.
        Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
        " Misc
        Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
        Plug 'nprindle/lc3.vim'

        " Collection of language packs
        " This should be loaded after language-specific plugins
        Plug 'sheerun/vim-polyglot'
        call plug#end()
    endif
" }}}

" Plugin settings {{{
" Netrw
    let g:netrw_banner=0
    let g:netrw_liststyle=3

" vim-visual-multi
    let g:VM_leader = '\'
    nmap <C-j> <Plug>(VM-Add-Cursor-Down)
    nmap <C-k> <Plug>(VM-Add-Cursor-Up)

" Rooter
    " Don't trigger automatically
    let g:rooter_manual_only = 1

" vim-lsp
    " if executable('haskell-ide-engine-wrapper')
    "     " pip install python-language-server
    "     augroup hie_group
    "         autocmd!
    "         autocmd User lsp_setup call lsp#register_server({
    "             \ 'name': 'haskell-ide-engine',
    "             \ 'cmd': {server_info->['haskell-ide-engine-wrapper', '--lsp']},
    "             \ 'whitelist': ['haskell', 'hs', 'lhs'],
    "             \ })
    "         augroup END
    " endif

    if executable('rnix-lsp')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'rnix-lsp',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'rnix-lsp']},
            \ 'whitelist': ['nix'],
            \ })
    endif

    nnoremap <Leader>lh  :LspHover<CR>
    nnoremap <Leader>lgd :LspDefinition<CR>
    nnoremap <Leader>lpd :LspPeekDefinition<CR>
    nnoremap <Leader>lgt :LspTypeDefinition<CR>
    nnoremap <Leader>lpt :LspPeekTypeDefinition<CR>
    nnoremap <Leader>lr  :LspReferences<CR>
    noremap  <Leader>la  :LspCodeAction<CR>

" haskell-vim
    let g:haskell_enable_quantification = 1   " `forall`
    let g:haskell_enable_recursivedo = 1      " `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " `proc`
    let g:haskell_enable_pattern_synonyms = 1 " `pattern`
    let g:haskell_enable_typeroles = 1        " type roles
    let g:haskell_enable_static_pointers = 1  " `static`
    let g:haskell_backpack = 1                " backpack keywords

    let g:haskell_indent_disable = 1

    " Highlighting options not specific to haskell-vim
    let g:hs_allow_hash_operator = 1
    let g:hs_highlight_boolean = 1
    let g:hs_highlight_debug = 1
    let g:hs_highlight_types = 1
    let g:hs_highlight_more_types = 1

" markdown-preview
    let vim_markdown_preview_pandoc = 1
    let vim_markdown_preview_use_xdg_open = 1
" }}}

" Colors {{{
    if colors#has256()
        let &t_ti.="\e[1 q"
        let &t_SI.="\e[5 q"
        let &t_EI.="\e[1 q"
        let &t_te.="\e[0 q"
    endif

    colorscheme one
    set background=dark
" }}}

" Local vimrc
    if !empty(glob('~/local.vimrc'))
        execute 'source ' . glob('~/local.vimrc')
    end

set secure

" vim:foldmethod=marker
