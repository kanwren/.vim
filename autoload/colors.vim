function! colors#colorlist() abort
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    return map(paths, 'fnamemodify(v:val, ":t:r")')
endfunction

let s:colors = colors#colorlist()
let s:cur_color = -1

function! colors#nextcolor() abort
    let s:cur_color += 1
    let s:cur_color = s:cur_color % len(s:colors)
    execute ':colorscheme ' . s:colors[s:cur_color]
    set background=dark
    redraw
    echo 'Switched to: ' . s:colors[s:cur_color] . ' (' . (s:cur_color + 1) . ')'
endfunction

