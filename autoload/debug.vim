function! debug#syngroup() abort
    let l = line(".")
    let c = col(".")
    let hi = synIDattr(synID(l, c, 1), "name")
    let trans = synIDattr(synID(l, c, 0), "name")
    let lo = synIDattr(synIDtrans(synID(l, c, 1)), "name")
    echo "hi<" . hi . '> trans<' . trans . "> lo<" . lo . ">"
endfunction
