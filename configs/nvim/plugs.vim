
" Automated Vim-Plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim -x http://proxy-chain.intel.com:911 --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/vim-plug'

Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'

Plug 'tpope/vim-fugitive'

" Plug 'scrooloose/nerdtree'
"  Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

Plug 'scrooloose/nerdcommenter'

" linters
"  Plug 'dense-analysis/ale'
" Plug 'vim-syntastic/syntastic'

" LSP
"  Plug 'neoclide/coc.nvim', {'branch': 'release'}
" use <tab> for trigger completion and navigate to the next complete item
"  function! CheckBackspace() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"  endfunction
"  inoremap <silent><expr> <Tab>
"        \ coc#pum#visible() ? coc#pum#next(1) :
"        \ CheckBackspace() ? "\<Tab>" :
"        \ coc#refresh()
"  inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" You have to remap <cr> to make it confirms completion.
"  inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'mhinz/vim-startify'

Plug 'ackyshake/VimCompletesMe'

"  Plug 'lervag/vimtex'

"  Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'andymass/vim-matchup'

" ======================== Language Plugins ========================

" python
"  Plug 'nvie/vim-flake8'
"  Plug 'vim-scripts/indentpython.vim'
"  if has('python3')
"    Plug 'sirver/ultisnips'
"    let g:UltiSnipsExpandTrigger="<c-s>"
"  endif

" markdown
Plug 'gabrielelana/vim-markdown'

call plug#end()
