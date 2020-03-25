setlocal foldmethod=syntax
setlocal makeprg=javac\ %
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

function! Eatspace()
    let c = nr2char(getchar(0))
    return c =~ '\s' ? '' : c
endfunction

" Trigger these by pressing tab (auto-pairs messes with a normal space)
iabbrev sout System.out.println();<Left><Left><C-r>=Eatspace()<CR>
iabbrev serr System.err.println();<Left><Left><C-r>=Eatspace()<CR>
" Note: relies on auto-pairs
iabbrev psvm public static void main(String[] args) {<CR><C-r>=Eatspace()<CR>

