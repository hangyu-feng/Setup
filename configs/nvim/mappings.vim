
let mapleader = " "

" ===================== Plugin Related ===================
map <C-n> :NERDTreeToggle<CR>  " nerd tree
map - <plug>NERDCommenterToggle  " nerd commenter

nnoremap <silent> ; :FZF<CR>  " fzf
nnoremap <silent> ' :Rg<CR>  " rg

" ===================== Indent ============================
" shift using Tab and Shift-Tab
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
