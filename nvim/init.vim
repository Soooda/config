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


" Screensaver
Plug 'itchyny/screensaver.vim'
map <silent><F12> :ScreenSaver<CR>


" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
    \   'coc-json',
    \   'coc-marketplace',
    \   'coc-vimlsp',
    \   'coc-pairs',
    \   'coc-lists',
    \   'coc-cmake',
    \   'coc-html',
    \   'coc-css',
    \   'coc-eslint',
    \   'coc-syntax',
    \   'coc-python',
    \   'coc-java']


"Toggle Comment or not <LEADER> + c
Plug 'preservim/nerdcommenter'
let g:NERDCreateDefaultMappings = 0


" Upderline the same words
Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0


"Git change history lint
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0


"Support which key of vim
Plug 'liuchengxu/vim-which-key'


"Vim Startup Menu"
Plug 'mhinz/vim-startify'


"NerdTree"
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
" F1 Toggle
map <silent> <F1> :NERDTreeTabsToggle<CR>
imap <silbent> <F1> <ESC>:NERDTreeTabsToggle<CR>


"JSON with Comments
Plug 'kevinoid/vim-jsonc'


"Hex Color Preview"
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase'  }
let g:Hexokinase_highlighters = ['virtual']


"Rainbow Brackets"
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1


"Icons - request Nerdfonts"
Plug 'ryanoasis/vim-devicons'


"Themes"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='fruit_punch'
let g:airline#extensions#tabline#enabled = 1
set statusline^=%{coc#status()}


"Plug 'itchyny/lightline.vim'
"Plug 'liuchengxu/eleline.vim'


"Plug 'arzg/vim-colors-xcode'
Plug 'connorholyday/vim-snazzy'
"Transparent background"
let g:SnazzyTransparent = 1

call plug#end()

"Themes"
set termguicolors
colorscheme snazzy
"colorscheme xcodedark


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
"----------------------------------------------------Settings----------------------------------------------------"
set nocompatible
set encoding=utf-8
"Enable mouse
set mouse=a
"Use System's Clipboard
set clipboard=unnamed


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

"Redraw"
set lazyredraw

"Transparent Background"
"hi Normal guibg=None ctermbg=None

"----------------------------------------------------COC----------------------------------------------------"
set hidden
set updatetime=100
set shortmess+=c


" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

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

function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.one ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

"Improve brackets formating
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
