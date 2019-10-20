if exists('g:loaded_nix_prefetch_git')
    finish
endif
let g:loaded_nix_prefetch_git = 1

if !exists('g:nix_prefetch_git_fields')
    " Other fields: url, date, fetchSubmodules
    let g:nix_prefetch_git_fields = ['rev', 'sha256']
endif

function! s:Nix_Prefetch_Git(owner, repo, ...) abort
    let command = 'nix-prefetch-git git@github.com:' . a:owner . '/' . a:repo
    if a:0 > 0
        let command .= ' --rev ' . a:1
    end
    let command .= ' --quiet 2>/dev/null | grep -E "' . join(g:nix_prefetch_git_fields, '|')
    let command .= '" | sed -E "s/\s*\"(.+)\": \"(.+)\",/\1 = \"\2\";/g"'
    if $USER ==# 'root'
        " If root, try to run command as login user instead
        let logname = substitute(system('logname'), '\n', '', 'ge')
        execute('read! ' . 'runuser -l ' . logname . " -c '" . command . "'")
    else
        execute('read! ' . command)
    endif
endfunction

command! -bar -nargs=+ NPG call <SID>Nix_Prefetch_Git(<f-args>)

