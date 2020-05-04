if !exists("g:util#os_name")
    if has("win64") || has("win32") || has("win16")
        let g:util#os_name = "Windows"
    elseif executable('uname')
        let g:util#os_name = substitute(system('uname -o'), '\n', '', '')
    else
        let g:util#os_name = ''
    endif
endif

function! util#syngroup() abort
    let l = line(".")
    let c = col(".")
    let hi = synIDattr(synID(l, c, 1), "name")
    let trans = synIDattr(synID(l, c, 0), "name")
    let lo = synIDattr(synIDtrans(synID(l, c, 1)), "name")
    echo "hi<" . hi . '> trans<' . trans . "> lo<" . lo . ">"
endfunction

