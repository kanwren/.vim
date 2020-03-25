if exists('g:loaded_qfilter')
    finish
endif
let g:loaded_qfilter = 1

" Filter quickfix list to only entries matching/not matching pattern
function! s:FilterQuickfixList(bang, pattern) abort
    let cmp = a:bang ? '!~#' : '=~#'
    call setqflist(filter(getqflist(), "v:val['text'] " . cmp . " a:pattern"))
endfunction

command! -bang -nargs=1 -complete=file QFilter call s:FilterQuickfixList(<bang>0, <q-args>)

" Filter quickfix list to only entries with buffer names matching/not matching pattern
function! s:FilterQuickfixListBufferName(bang, pattern) abort
    let cmp = a:bang ? '!~#' : '=~#'
    call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . " a:pattern"))
endfunction

command! -bang -nargs=1 -complete=file QFilterBufName call s:FilterQuickfixListBufferName(<bang>0, <q-args>)
