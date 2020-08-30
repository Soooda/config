"  __  __        __     _____ __  __ ____   ____
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/

"Install Vim-Plug and all plugins"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
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

"Prevent incorrect background rendering"
let &t_ut=''


"Display"
set number
set relativenumber
set ruler
set cursorline
syntax enable
syntax on
"set hidden
set ttimeoutlen=0
set notimeout

"Editor"
"Tab"
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set list
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
"Scroll offset: how many lines unomitted above the cursor line"
set scrolloff=5

"Soft wrap"
set wrap
set tw=0

set indentexpr=
"Better backspace"
set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc

"Change the cursor based on modes"
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)


"Window"
set splitright
set splitbelow

"Status/Command Bar"
set noshowmode
set autochdir
set showcmd
set laststatus=2 "Always dispaly status bar


"Command Autocomplete"
set hidden
set wildmenu
set wildmode=longest,list,full
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set visualbell
set colorcolumn=100
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Use tab for trigger completion with characters ahead and navigate.
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

" Use `<LEADER>-` and `<LEADER>=` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostics-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostics-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>h to show documentation in preview window.
nnoremap <silent> <LEADER>h :call <SID>show_documentation()<CR>

"coc code action"
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
xmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

"Search"
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap - Nzz


"Restore cursor position"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"Keys Mapping"
"Set <LEADER> as <SPACE>"
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

"Press ` to change case (instead of ~)"
noremap ` ~

"coc.nvim"
let g:coc_global_extensions = [
  \  'coc-json',
  \  'coc-marketplace',
  \  'coc-vimlsp',
  \  'coc-eslint',
  \  'coc-tsserver',
  \  'coc-python',
  \  'coc-html',
  \  'coc-clangd'
  \]

"Install Plugins with Vim-Plug"
call plug#begin('~/.config/nvim/plugged')

"Visual Plugins"

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'connorholyday/vim-snazzy'

"Rainbow Brackets"
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

"Current Word"
Plug 'dominikduda/vim_current_word'
let g:vim_current_word#highlight_current_word = 0

"Gitgutter - displays git diff in line number panel"
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0 "Disable all key mappings

"Colours Preview"
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'
let g:Hexokinase_highlighters = ['virtual']
let g:Illuminate_delay = 150
hi illuminatedWord cterm=undercurl gui=undercurl
set termguicolors

"Highlight TODO"
Plug 'sakshamgupta05/vim-todo-highlight'
let g:todo_highlight_config = {
            \   'TODO': {
            \     'gui_fg_color': '#0f0fff',
            \     'gui_bg_color': '#affd3a',
            \   },
            \   'FIXME': {
            \     'gui_fg_color': '#000000',
            \     'gui_bg_color': '#af2d3a',
            \   }
            \}

"Icons - request Nerdfonts"
Plug 'ryanoasis/vim-devicons'

"Autosave for MARKDOWN"
Plug 'vim-scripts/vim-auto-save'
let g:auto_save_silent = 1 
autocmd FileType markdown let g:auto_save = 1

"Which key"
Plug 'liuchengxu/vim-which-key'

"Autoformat"
"Plug 'Chiel92/vim-autoformat'

"Auto Complete"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"Visual"

"colorscheme xcodedark
let g:SnazzyTransparent = 1
set background=dark
colorscheme snazzy
let g:lightline = {
\ 'colorscheme': 'snazzy',
\ }
