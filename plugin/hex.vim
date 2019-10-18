if exists('g:loaded_hex')
    finish
endif
let g:loaded_hex = 1

function! ToggleHex() abort
    " save values for modified and read-only, clear read-only flag for now
    let l:modified = &mod
    let l:oldreadonly = &readonly
    let &readonly = 0
    let l:oldmodifiable = &modifiable
    let &modifiable = 1
    if !exists("b:edit_hex") || !b:edit_hex
        " save old options
        let b:old_ft = &ft
        let b:old_bin = &bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        silent :edit " this will reload the file without trickeries
        " (DOS line endings will be shown entirely)
        let &ft = "xxd"
        let b:edit_hex = 1
        %!xxd
    else
        " restore old options
        let &ft = b:old_ft
        if !b:old_bin
            setlocal nobinary
        endif
        let b:edit_hex = 0
        %!xxd -r
    endif
    " restore old values for modified and read only state
    let &mod = l:modified
    let &readonly = l:oldreadonly
    let &modifiable = l:oldmodifiable
endfunction

command! -bar Hexmode call ToggleHex()

