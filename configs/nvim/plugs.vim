
" Automated Vim-Plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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

" ======================== Language Plugins ========================

" python
Plug 'vim-scripts/indentpython.vim'
if has('python3')
  Plug 'sirver/ultisnips'
endif



call plug#end()
