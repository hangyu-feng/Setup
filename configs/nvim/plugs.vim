
" Automated Vim-Plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/vim-plug'

Plug 'morhetz/gruvbox'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'scrooloose/nerdcommenter'

" linters
Plug 'dense-analysis/ale'
Plug 'vim-syntastic/syntastic'

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
