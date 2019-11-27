if exists('g:loaded_align')
    finish
endif
let g:loaded_align = 1

function! Align(l1, l2, re) abort
endfunction

command! -range -nargs=1 Align call Align(<line1>, <line2>, <f-args>)

