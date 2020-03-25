setlocal formatoptions=croqjlnt

nmap <buffer> <F21> <Plug>VimwikiNextLink

nnoremap <buffer> <Leader>ewh yyp:s/[^\|]/-/g \| nohlsearch<CR>

" Wiki date header with YMD date annotation and presentable date in italics
iabbrev <buffer> xheader %date <C-r>=strftime("%Y-%m-%d")<CR><CR>_<C-r>=strftime("%a %d %b %Y")<CR>_
" Diary header with navigation and date header
iabbrev <buffer> xdiary <C-r>=expand('%:t:r')<CR><Esc><C-x>+f]i\|< prev<Esc>odiary<Esc>+f]i\|index<Esc>o<C-r>=expand('%:p:t:r')<CR><Esc><C-a>+f]i\|next ><Esc>o<CR>%date <C-r>=strftime("%Y-%m-%d")<CR><CR><C-r>=strftime("%a %d %b %Y")<CR><Esc>yss_o<CR>

" Lecture header with navigation and date header
iabbrev <buffer> xlecture %date <C-r>=strftime("%Y-%m-%d")<CR><CR>_<C-r>=strftime("%a %d %b %Y")<CR>_<CR><CR><C-r>=expand('%:p:t:r')<CR><Esc><C-x>V<CR>0f]i\|< prev<Esc>oindex<Esc>V<CR>o<C-r>=expand('%:p:t:r')<CR><Esc><C-a>V<CR>0f]i\|next ><Esc>o<CR><C-r>=expand('%:p:r')<CR><Esc>F/r F_r bgUiwd0I= <Esc>A =<CR>== - ==<CR>----<CR><CR>

let b:surround_indent = 0
let b:surround_109 = "{{$ \r }}$"
let b:surround_99 = "{{{ \r }}}"

