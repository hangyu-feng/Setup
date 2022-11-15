
" ============================= Plugin shortcuts ===============================


" copy file path relative to current working directory.
" see https://vim.fandom.com/wiki/Copy_filename_to_clipboard
map <leader>c :let @*=expand("%")<cr>
map <leader>p :let @*=expand("%:p")<cr>

" Latex autocompile
" augroup vimtex
"   autocmd FileType tex noremap <F5> :VimtexCompile<CR>
  " autocmd BufNewFile,BufRead *.tex :VimtexCompile
" augroup end

" shift using Tab and Shift-Tab (disabled)
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""
" => Terminal Mode
"""""""""""""""""""""""""""""""
" close terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
elseif has('terminal')
  tnoremap <ESC> <C-w>:q!<CR>
endif

if has('terminal')
  map <leader>t :term ++close<cr>  " open terminal
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>  " clear all highlights
map <silent> <leader>r :redraw!<cr>  " force redraw

nmap <home> ^
imap <home> <esc>^i

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" actions on buffers: next, delete
map <leader><Tab> :bn<cr>
map <leader>w :bn<bar>bd#<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python F5 Compiling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Abandoned since I use vimspector

" augroup python
"   autocmd FileType python noremap <F5> :term python3 % <CR>
"   " autocmd BufNewFile,BufRead *.tex :VimtexCompile
" augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

