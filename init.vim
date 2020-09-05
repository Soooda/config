" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @Soooda

"Install Vim-Plug and all plugins"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"----------------------------------------------------Plugins----------------------------------------------------"
call plug#begin()


"Which key"
Plug 'liuchengxu/vim-which-key'


"Coc"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
    \   'coc-json',
    \   'coc-vimlsp',
    \   'coc-marketplace',
    \   'coc-python']


"Hex Color Preview"
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['virtual']


"Auto-Pairs"
Plug 'jiangmiao/auto-pairs'



"Rainbow Brackets"
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1


"Icons - request Nerdfonts"
Plug 'ryanoasis/vim-devicons'


"Themes"
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/eleline.vim'
let g:airline_powerline_fonts = 1
set statusline^=%{coc#status()}

Plug 'arzg/vim-colors-xcode'
Plug 'connorholyday/vim-snazzy'
"Transparent background"
let g:SnazzyTransparent = 1


call plug#end()

"Themes"
set termguicolors
colorscheme snazzy

"----------------------------------------------------Mappings----------------------------------------------------"
" Set <SPACE> to <LEADER>
let mapleader=" "
"Set semicolon to be colon
map ; :
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap - Nzz

"Press ` to change case (instead of ~)"
noremap ` ~


"----------------------------------------------------Settings----------------------------------------------------"
set nocompatible
set encoding=utf-8
"Enable mouse
set mouse=a

"Remember cursor location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on


set number
set relativenumber
set cursorline
set visualbell
set scrolloff=4
set list
set listchars=nbsp:⎵,trail:·
set updatetime=100

"Status/Command Bar"
set laststatus=2
set noshowmode
set autochdir
set showcmd
set wildmenu
set wildmode=longest,full

set autoindent
set smartindent
set indentexpr=

"Disable the limit to the pasted text length
set tw=0

"Softwrap"
set wrap

"Tabs"
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

"Better Backspace"
set backspace=indent,eol,start

"Search"
set hlsearch
set incsearch
set ignorecase
set smartcase
exec "nohlsearch"

"Window Split"
set splitright
set splitbelow

"Backup"
set backup
set backupdir=$HOME/.config/nvim/files/backup/
set backupext=-vimbackup
set backupskip=
set directory=$HOME/.config/nvim/files/swap//
set updatecount=100
set undofile
set undodir=$HOME/.config/nvim/files/undo/
set viminfo='100,n$HOME/.config/nvim/files/info/viminfo

"Coc
set hidden
set updatetime=100
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.one ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@



