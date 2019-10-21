setlocal makeprg=pdflatex\ -quiet\ -aux-directory=%:h\ -output-directory\ %:h\ %

set textwidth=80
" Automatically wrap at textwidth
setlocal formatoptions+=t

" View PDF
nnoremap <buffer> <F3> :! mupdf %<.pdf &<CR><CR>

" Use "m" to surround with \[\]
let b:surround_109 = "\\[ \r \\]"
let b:surround_84 = "\\text{\r}"

" These could also be abbreviations, but the space consumption doesn't quite
" work and the delay isn't that annoying
inoremap <buffer> ,it \textit{}<Left>
inoremap <buffer> ,bf \textbf{}<Left>
inoremap <buffer> ,tt \texttt{}<Left>
inoremap <buffer> ,ul \underline{}<Left>
inoremap <buffer> ,em \emph{}<Left>
inoremap <buffer> ,tu \textsuperscript{}<Left>
inoremap <buffer> ,td \textsubscript{}<Left>
inoremap <buffer> ,{ \left\{\right\}<Esc>F{a
inoremap <buffer> ,} \{\}<Esc>F{a
inoremap <buffer> ,< \langle\rangle<Esc>F\i
inoremap <buffer> ,( \left(\right)<Esc>F\i
inoremap <buffer> ,[ \left[\right]<Esc>F\i

inoremap <buffer> ,bmat \begin{bmatrix*}[r]\end{bmatrix*}<Esc>F\i

function! s:ElongateSurrounding(start, end, surrounds) abort
    let left = a:surrounds[0]
    let right = a:surrounds[1]
    execute a:start . ',' . a:end . 's/\ze' . right . '/\\right/g'
    execute a:start . ',' . a:end . 's/\ze' . left . '/\\left/g'
endfunction

command! -range -nargs=1 Elongate call <SID>ElongateSurrounding(<line1>, <line2>, <f-args>)

