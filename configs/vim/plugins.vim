
if has('nvim')
  let data_dir = stdpath('data') . '/site'
elseif has("win16") || has("win32")
  set shell=pwsh
  let data_dir = "$home/vimfiles/autoload/plug.vim"
elseif has("unix")
  let data_dir = "~/.vim/autoload/plug.vim"
endif

" automated vim-plug download
if empty(glob(data_dir))
  " `.` for string concatenation
  silent execute '!curl --create-dirs -fLo ' . data_dir . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'junegunn/vim-plug'

" Colorschemes, find more in https://vimcolorschemes.com/
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
let g:everforest_better_performance = 1
" Plug 'sainnhe/gruvbox-material'
" Plug 'sainnhe/sonokai'
" Plugin 'lifepillar/vim-gruvbox8'
" junegunn/seoul256.vim

Plug 'wincent/terminus'  " change cursor shape in modes

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
let g:ft_man_open_mode = 'vert'

" some defaults
Plug 'tpope/vim-sensible'
runtime! 'plugin/sensible.vim'  " run this plugin earlier to override settings
" Plug 'tpope/vim-surround'

" Plugin 'zivyangll/git-blame.vim'

Plug 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

Plug 'scrooloose/nerdcommenter'
map - <plug>NERDCommenterToggle
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" lsp
Plug 'dense-analysis/ale'
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc
function! SmartInsertCompletion() abort
  " Use the default CTRL-N in completion menus
  if pumvisible()
    return "\<C-n>"
  endif
  " Exit and re-enter insert mode, and use insert completion
  return "\<C-c>a\<C-n>"
endfunction
inoremap <silent> <TAB> <C-R>=SmartInsertCompletion()<CR>
" inoremap <silent> <TAB> <C-\><C-O>:ALEComplete<CR>
let g:ale_fixers = {
\ 'python': ['black', 'isort'],
\ 'sh': ['shfmt'],
\ 'cpp': ['clang-format'],
\ 'perl': ['perltidy'],
\}
" nmap <leader>f <Plug>(ale_fix)
nmap <F8> <Plug>(ale_fix)
let g:ale_perl_perltidy_options = ' -ce -nsfs -isbc -olc '

" debugger
Plug 'puremourning/vimspector'
" let g:vimspector_enable_mappings = 'HUMAN'
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver


set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <silent> ; :Files<CR>
nnoremap <silent> ' :Rg<CR>

" syntax highlighting for many languages
Plug 'sheerun/vim-polyglot'

Plug 'yggdroot/indentline'
let g:indentLine_setConceal = 0

Plug 'vim-airline/vim-airline'
" let g:airline_theme = 'everforest'
let g:airline#extensions#tabline#enabled = 1
" TODO: figure out how to show buffer number in tabline
" go to https://github.com/vim-airline/vim-airline#smarter-tab-line for all formatters
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Plug 'itchyny/lightline.vim'
" set laststatus=2

Plug 'mhinz/vim-startify'

" autocomplete
" Plug 'ackyshake/VimCompletesMe'
" so that Vim's popup menu doesn't select the first completion item, but rather just inserts the longest common text of all matches
" set completeopt=longest,menuone
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Plug 'sirver/ultisnips'
" let g:UltiSnipsExpandTrigger="<c-s>"
" solving key conflict with VimCompletesMe, see https://github.com/ackyshake/VimCompletesMe/issues/33

" python
Plug 'tmhedberg/simpylfold'
let g:SimpylFold_docstring_preview = 1
" Plug 'nvie/vim-flake8'
Plug 'vim-scripts/indentpython.vim'
" Plug 'davidhalter/jedi-vim'
" powerful but little too much. useful when full-IDE experience needed. see https://github.com/davidhalter/jedi-vim
" let g:jedi#auto_initialization = 0
" let g:jedi#use_splits_not_buffers = "left"

" C/C++
" syntax highlighting
" Plug 'bfrg/vim-cpp-modern'
" Plug 'rhysd/vim-clang-format'
" let g:clang_format#code_style = "google"

" ruby on rails
" Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-cucumber'
" Plug 'tpope/vim-rake'
" Plug 'tpope/vim-bundler'

" javascript and ember.js
" Plug 'pangloss/vim-javascript'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'elzr/vim-json'
" let g:vim_json_conceal=0

" tmux
" Plug 'tmux-plugins/vim-tmux'

" markdown
" Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
" Uncomment to override defaults:
" let g:instant_markdown_slow = 1
" let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
" let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
" let g:instant_markdown_autoscroll = 0
" let g:instant_markdown_port = 8888
" let g:instant_markdown_python = 1

" Latex
" Plug 'lervag/vimtex'


" Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'andymass/vim-matchup'

call plug#end()

