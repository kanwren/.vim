if !has('conceal') || exists('g:loaded_indent_guide')
    finish
endif
let g:loaded_indent_guide = 1

if !exists('g:indent_guide_char')
    let g:indent_guide_char = '|'
endif

if !exists('g:indent_guide_enabled')
    let g:indent_guide_enabled = 0
endif

function! s:ShowIndentGuides()
    setlocal concealcursor=inc conceallevel=0
    let indent = &l:shiftwidth != 0 ? &l:shiftwidth : &l:tabstop
    let max = exists('g:indent_guide_depth') ? g:indent_guide_depth : &l:textwidth
    for i in range(indent, max, indent)
        " Highlight any spaces directly after a multiple of the indent level
        let pat = '^\s\+\zs\%' . (i + 1) . 'v '
        call matchadd('Conceal', pat, 0, -1, { 'conceal': g:indent_guide_char })
    endfor
endfunction

augroup indent_guide_group
    autocmd BufWinEnter * if exists('g:indent_guide_enabled') && g:indent_guide_enabled | call <SID>ShowIndentGuides() | endif
    autocmd WinEnter * if exists('g:indent_guide_enabled') && g:indent_guide_enabled | call <SID>ShowIndentGuides() | endif
    if has('##WinNew')
        autocmd WinNew * if exists('g:indent_guide_enabled') && g:indent_guide_enabled | call <SID>ShowIndentGuides() | endif
    endif
augroup END
