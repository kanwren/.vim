setlocal tabstop=2 softtabstop=2 shiftwidth=2

nnoremap <buffer> <Leader>NU vip<Esc>{:let @h=@/<CR>/owner<CR>f""jyi"j0f""kyi":NPG <C-r>j <C-r>k<CR>jdjkk=j:let @/=@h<CR>{jw:noh<CR>
inoremap <buffer> <F3> <C-r>=system("head --bytes 10 /dev/urandom \| sha256sum -b \| cut -d' ' -f 1")[:-2]<CR>
