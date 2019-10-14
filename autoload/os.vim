if !exists("g:os#name")
    if has("win64") || has("win32") || has("win16")
        let g:os#name = "Windows"
    elseif executable('uname')
        let g:os#name = substitute(system('uname -o'), '\n', '', '')
    else
        let g:os#name = ''
    endif
endif

