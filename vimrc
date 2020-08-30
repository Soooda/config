"  __  __        __     _____ __  __ ____   ____
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Setup"
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set encoding=utf-8
"Enable cursor"
set mouse=a

set clipboard=unnamed

"Prevent incorrect background rendering"
let &t_ut=''

"Display"
set number
set relativenumber
set ruler
set cursorline
syntax enable
syntax on

"Editor"
"Tab"
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5

"Prevent auto line split"
set wrap
set tw=0

set indentexpr=
"Better backspace"
set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99

"Change Cursor based on different mode"
" For Iterm 2 and linux
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" For Mac Terminal
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Window"
set splitright
set splitbelow

"Status/Command Bar"
set laststatus=2
set autochdir
set showcmd


"Command Autocomplete"
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

"Search"
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap = Nzz

"Restore Cursor Position"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Keys Mapping"
"Set <LEADER> as <SPACE>
let mapleader=" "

map ; :
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

"Split Screen"
map su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sd :set splitbelow<CR>:split<CR>
map sl :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sr :set splitright<CR>:vsplit<CR>

"Place the two screens up and down"
noremap sh <C-w>t<C-w>K
"Place the two screens side by side"
noremap sv <C-w>t<C-w>H

"Install Plugins with Vim-Plug"
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'

call plug#end()

"Dress up"
colorscheme snazzy
let g:SnazzyTransparent = 1
set background=dark
let g:airline_theme='cool'

