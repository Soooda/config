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

" Terminal
Plug 'skywind3000/vim-terminal-help'
" F3 toggle terminal
" Alt + q to exit Terminal insert mode
" Use drop + file to open the file in vim
let g:terminal_key='<F3>'
let g:terminal_close=1
let g:terminal_height=15
let g:terminal_pos='rightbelow'

" Vista
Plug 'liuchengxu/vista.vim'
map <silent><F2> :Vista coc<CR>
imap <silent><F2> <ESC>:Vista coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
"let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" function! NearestMethodOrFunction() abort
" 	return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" Accelerate the moving speed
Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_table = [2, 4, 7, 15]


" Screensaver
Plug 'itchyny/screensaver.vim'
map <silent><F12> :ScreenSaver<CR>


" Auto-pairs
Plug 'jiangmiao/auto-pairs'


" Upderline the same words
Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0


"Git change history lint
Plug 'airblade/vim-gitgutter'
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'


"Support which key of vim"
Plug 'liuchengxu/vim-which-key'


"Vim Startup Menu"
Plug 'mhinz/vim-startify'


"NerdTree"
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
" F1 Toggle
map <silent> <F1> :NERDTreeTabsToggle<CR>
imap <silbent> <F1> <ESC>:NERDTreeTabsToggle<CR>


"JSON with Comments"
Plug 'kevinoid/vim-jsonc'


"Hex Color Preview"
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase'  }
let g:Hexokinase_highlighters = ['virtual']


"Rainbow Brackets"
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1


"Icons - request Nerdfonts"
Plug 'ryanoasis/vim-devicons'


"Status Line"
"Plug 'itchyny/lightline.vim'
"Plug 'liuchengxu/eleline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='fruit_punch'
let g:airline#extensions#tabline#enabled = 1
set statusline^=%{coc#status()}


"Color Theme"
"Plug 'arzg/vim-colors-xcode'
Plug 'connorholyday/vim-snazzy'
"Transparent background
let g:SnazzyTransparent = 1

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

let g:coc_global_extensions = [
    \   'coc-json',
    \   'coc-marketplace',
    \   'coc-vimlsp',
    \   'coc-lists',
    \   'coc-cmake',
    \   'coc-html',
    \   'coc-css',
    \   'coc-eslint',
    \   'coc-syntax',
    \   'coc-python',
    \   'coc-java']

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
"----------------------------------------------------COC----------------------------------------------------"
call plug#end()
"----------------------------------------------------Settings----------------------------------------------------"
"Themes
set termguicolors
colorscheme snazzy
"colorscheme xcodedark

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
set listchars=tab:\|\ ,nbsp:⎵,trail:·

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

"Window Split"
set splitright
set splitbelow

"Redraw"
set lazyredraw

"Fold"
set foldlevel=99
set foldenable
set foldmethod=indent
function! Toggle_fold()
    if &foldlevel == 0
        set foldlevel=99
        echo 'unfold'
    else
        set foldlevel=0
        echo 'fold'
    endif
endfunction
"----------------------------------------------------Mappings----------------------------------------------------"
" Set <SPACE> to <LEADER>
let mapleader=" "

"Set semicolon to be colon
map ; :

" Sift + s Save current file 
"      + q Quit
"      + r Reload init.vim file 
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

" <LEADER> + Enter: Close Highlight Search
" - Go to previous match and set the line center
" + Go to next match and set the line center
map <LEADER><CR> :nohlsearch<CR>
noremap - nzz
noremap = Nzz

" Press ` to change cases (instead of ~)
noremap ` ~

" h - screen left
" j - screen down
" k - screen up
" l - screen right
" 1~9 tab 1~9
" 0 - close other tabs
noremap <silent><LEADER>h <C-w>h
noremap <silent><LEADER>j <C-w>j
noremap <silent><LEADER>k <C-w>k
noremap <silent><LEADER>l <C-w>l
noremap <silent><LEADER><LEADER>h <C-w>H
noremap <silent><LEADER><LEADER>j <C-w>J
noremap <silent><LEADER>1 1gt
noremap <silent><LEADER>2 2gt
noremap <silent><LEADER>3 3gt
noremap <silent><LEADER>4 4gt
noremap <silent><LEADER>5 5gt
noremap <silent><LEADER>6 6gt
noremap <silent><LEADER>7 7gt
noremap <silent><LEADER>8 8gt
noremap <silent><LEADER>9 9gt
noremap <silent><LEADER>0 :tabo<CR>

" Split Screen
" s + 
"     h Split left 
"     l Split right
"     j Split down 
"     k Split up
"     t Split a new tab
map s <nop>
noremap <silent>sh :set nosplitright<CR>:vnew<CR>
noremap <silent>sl :set splitright<CR>:vnew<CR>
"noremap <silent>sj :set splitbelow<CR>:new<CR>
"noremap <silent>sk :set nosplitbelow<CR>:new<CR>
noremap <silent>st :tabnew<CR>

" Faster Navigation
" Shift + j Go down 20 lines 
" Shift + k Go up 20 lines 
" Shift + h Go to the front of the line
" Shift + l Go to the end of the line
noremap J 20j
noremap K 20k
noremap H 0
noremap L $


" Toggle fold
map <LEADER>z :call Toggle_fold()<CR>


"Run Code
function! RunCode()
    exec "w"
    if &filetype == 'c'
        exec '%g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'c++'
        exec '%g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'java'
        exec '!javac %'
        exec 'time java %<'
    elseif &filetype == 'python'
        exec '!time python3 %'
    elseif &filetype == 'go'
        exec '!time go run %'
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunction
map <silent><F5> :call RunCode()<CR>
"----------------------------------------------------End----------------------------------------------------"
exec "nohlsearch"

"Transparent Background
"hi Normal guibg=None ctermbg=None
