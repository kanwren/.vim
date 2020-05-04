" Base conversion utilities (prefixed with gb)
"
if exists('g:loaded_bases')
    finish
endif
let g:loaded_bases = 1

" Binary
nnoremap <silent> gbdb ciw<C-r>=printf('%b', <C-r>")<CR><Esc>
vnoremap <silent> gbdb c<C-r>=printf('%b', <C-r>")<CR><Esc>

nnoremap <silent> gbbd ciw<C-r>=0b<C-r>"<CR><Esc>
vnoremap <silent> gbbd c<C-r>=0b<C-r>"<CR><Esc>

" Hex
nnoremap <silent> gbdh ciw<C-r>=printf('%x', <C-r>")<CR><Esc>
vnoremap <silent> gbdh c<C-r>=printf('%x', <C-r>")<CR><Esc>

nnoremap <silent> gbhd ciw<C-r>=0x<C-r>"<CR><Esc>
vnoremap <silent> gbhd c<C-r>=0x<C-r>"<CR><Esc>

" Octal
nnoremap <silent> gbdo ciw<C-r>=printf('%o', <C-r>")<CR><Esc>
vnoremap <silent> gbdo c<C-r>=printf('%o', <C-r>")<CR><Esc>

nnoremap <silent> gbod ciw<C-r>=0<C-r>"<CR><Esc>
vnoremap <silent> gbod c<C-r>=0<C-r>"<CR><Esc>

