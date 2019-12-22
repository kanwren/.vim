function! utils#in_git_repo() abort
    if executable('git')
        call system('git rev-parse --git-dir')
        return v:shell_error == 0
    else
        throw "'git' is not installed"
    endif
endfunction
