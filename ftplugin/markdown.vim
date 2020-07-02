setlocal formatoptions=croqjlnt
setlocal tabstop=2 softtabstop=2 shiftwidth=2
setlocal breakindent

" Compile to PDF
nnoremap <F2> :w \| !cd %:h && pandoc -s %:t --pdf-engine=pdflatex -o %:t:r.pdf<CR>
" View compiled PDF
nnoremap <F3> :!zathura %<.pdf &<CR><CR>

