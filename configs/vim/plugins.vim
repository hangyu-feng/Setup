
" profile startup time: https://github.com/bchretien/vim-profiler


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" automated vim-plug download
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'junegunn/vim-plug'

" Colorschemes, find more in https://vimcolorschemes.com/
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
let g:everforest_better_performance = 1
Plug 'sainnhe/gruvbox-material'
let g:gruvbox_material_better_performance = 1

Plug 'wincent/terminus'  " change cursor shape in modes

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
let g:ft_man_open_mode = 'vert'

" Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'  " detect indentation

" Plugin 'zivyangll/git-blame.vim'


" Plug 'scrooloose/nerdcommenter'
" map - <plug>NERDCommenterToggle
" " Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" " Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1

"Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" debugger
"Plug 'puremourning/vimspector'
"" let g:vimspector_enable_mappings = 'HUMAN'
"nmap <F5> <Plug>VimspectorContinue
"nmap <F3> <Plug>VimspectorStop
"nmap <F9> <Plug>VimspectorToggleBreakpoint
"nmap <F10> <Plug>VimspectorStepOver

set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <silent> ; :Files<CR>
nnoremap <silent> ' :Rg<CR>

" syntax highlighting for many languages
" Plug 'sheerun/vim-polyglot'

" Plug 'yggdroot/indentline'
" let g:indentLine_setConceal = 0


" Plug 'itchyny/lightline.vim'
" set laststatus=2

Plug 'mhinz/vim-startify'


" python
"Plug 'tmhedberg/simpylfold'
" let g:SimpylFold_docstring_preview = 1
" Plug 'nvie/vim-flake8'
"Plug 'vim-scripts/indentpython.vim'

" Plug 'https://github.com/adelarsq/vim-matchit'
" Plug 'andymass/vim-matchup'


if has('nvim')
  Plug 'echasnovski/mini.files'
  map <C-n> :lua MiniFiles.open()<CR>
  Plug 'echasnovski/mini.icons'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'nvim-lualine/lualine.nvim'

  " ====== lsp-zero ======
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
  " ======================

else
  " some defaults
  Plug 'tpope/vim-sensible'
  runtime! 'plugin/sensible.vim'  " run this plugin earlier to override settings

  Plug 'scrooloose/nerdtree'
  let NERDTreeShowHidden=1
  map <C-n> :NERDTreeToggle<CR>

  Plug 'vim-airline/vim-airline'
  " let g:airline_theme = 'everforest'
  let g:airline#extensions#tabline#enabled = 1
  " TODO: figure out how to show buffer number in tabline
  " go to https://github.com/vim-airline/vim-airline#smarter-tab-line for all formatters
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#ale#enabled = 1

endif

call plug#end()
