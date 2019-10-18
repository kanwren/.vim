" Easy-to-use temporary session management

if exists('g:loaded_sesh')
    finish
endif
let g:loaded_sesh = 1

if !exists('g:sesh_dir') || !g:sesh_dir
    let g:sesh_dir = '~/.vim/sessions/'
endif

function! s:GetSessions(arglead, cmdline, cursorpos) abort
    let paths = split(globpath(g:sesh_dir, '*.vim'), "\n")
    let names = map(paths, 'fnamemodify(v:val, ":t:r")')
    if empty(a:arglead)
        return names
    else
        return filter(names, {idx, val -> len(val) >= len(a:arglead) && val[:len(a:arglead) - 1] ==# a:arglead})
    endif
endfunction

" Saving a session
function! MkSession(bang, ...) abort
    if a:0 > 0
        execute "mksession" . a:bang . " " . g:sesh_dir . '/' . a:1 . ".vim"
        echo "Saved session to " . g:sesh_dir . '/' . a:1 . ".vim"
    else
        execute "mksession! " . g:sesh_dir . "/temp.vim"
        echo "Saved session to " . g:sesh_dir . "/temp.vim"
    endif
endfunction

command! -bang -nargs=? -complete=customlist,<SID>GetSessions Save :call MkSession("<bang>", <f-args>)

" Restoring a session
function! SourceSession(...) abort
    execute "source " . g:sesh_dir . "/" . (a:0 > 0 ? a:1 : 'temp') . ".vim"
endfunction

command! -nargs=? -complete=customlist,<SID>GetSessions Restore :call SourceSession(<f-args>)

" Mappings

" Providing a count uses temp-<count>.vim, otherwise it just uses temp.vim
nnoremap <expr> \s ':<C-u>Save! ' . (v:count > 0 ? 'temp-' . v:count : 'temp') . '<CR>'
nnoremap <expr> \r ':<C-u>Restore ' . (v:count > 0 ? 'temp-' . v:count : 'temp') . '<CR>'

