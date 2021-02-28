
" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @Soooda

" ===
" === Basic
" ===
set termguicolors "Enable true colors support
set exrc
set secure
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set autoindent
set smartindent
set encoding=utf-8
set visualbell
set noshowmode
set hidden
set lazyredraw
set updatetime=100
" Omit the hit <Enter> message
set shortmess+=c

set notimeout
set ttimeoutlen=0

set viewoptions=cursor,folds,slash,unix

" Enable Cursor
set mouse=a

" Use the system clipboard
set clipboard=unnamedplus

" Prevent incorrect background rendering
let &t_ut=''

set number
"set relativenumber
set ruler
set cursorline
syntax on

" Tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

set list
set listchars=tab:\|\ ,nbsp:⎵,trail:·
set scrolloff=4

" Prevent auto line split
set wrap
set tw=0

set indentexpr=

" Better backspace
set backspace=indent,eol,start

" Fold
set foldmethod=indent
set foldlevel=99
set foldenable

" Paste Format Option
set formatoptions-=tc

" Complete Option
set completeopt=longest,noinsert,menuone,noselect,preview

" Window split
set splitright
set splitbelow

" Status/Command bar
set laststatus=2 "To always display statusline
set autochdir
set showcmd
" Command autocomplete
set wildmenu

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===
" === Keys Mapping
" ===
" Set <LEADER> as <SPACE>
let mapleader=" "

map ; :
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

" Redo
map U <C-r>

" Faster Navigation
noremap J 20j
noremap K 20k
noremap H 0
noremap L $

" Search
map <LEADER><CR> :nohlsearch<CR>
noremap - Nzz
noremap = nzz

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Press ` to change cases (instead of ~)
noremap ` ~

" Indentation
noremap < <<
noremap > >>

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

" Change the screen layout to horizontal
noremap <silent><LEADER><LEADER>h <C-w>H
" Change the screen layout to veritcal
noremap <silent><LEADER><LEADER>j <C-w>J

" Split Screen
" s + 
"       h Split horizontally
"       v Split vertically
"       t Create a new tab
map s <nop>
noremap <silent>sh :set splitright<CR>:vsplit<CR>
noremap <silent>sv :set splitbelow<CR>:split<CR>
noremap <silent>st :tabnew<CR>

" ===
" === Plugins
" ===
" Auto download Vim-Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Cursor highlight
Plug 'RRethy/vim-illuminate'

" Apperance
Plug 'dracula/vim', { 'as': 'dracula'  }

" Status Line
Plug 'ojroques/vim-scrollstatus'
Plug 'soooda/eleline.vim'

" Color Preview
Plug 'norcalli/nvim-colorizer.lua'

" Tabline
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Indent Guide
" Plug 'glepnir/indent-guides.nvim'
Plug 'Yggdroot/indentLine'

" Rainbow Brackets
Plug 'luochen1990/rainbow'

" Lazygit
Plug 'kdheepak/lazygit.nvim'

" Gitgutter
Plug 'airblade/vim-gitgutter'

" Taglist
Plug 'liuchengxu/vista.vim'

" Comment
Plug 'tomtom/tcomment_vim'

" Start Screen
Plug 'mhinz/vim-startify'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ===
" === Plugins Config
" ===
" Status Line
let g:airline_powerline_fonts = 0

" Cursor Highlight
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END

" Color Preview
lua require'colorizer'.setup()

" Rainbow Brackets
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Lazygit
nnoremap <silent><F3> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed

" Gitgutter
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap <LEADER>ph :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" Indentline
"let g:indentLine_setColors = 0
"let g:indentLine_color_term = 100
let g:indentLine_char = '┊'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Taglist
noremap <F2> :Vista!!<CR>
"noremap <C-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
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

" Scrollstatus
let g:scrollstatus_size = 15

" Comment
nmap <LEADER>c gcc
vmap <LEADER>c gc

" coc.nvim
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-yank',
    \ 'coc-vimlsp',
    \ 'coc-syntax',
    \ 'coc-diagnostic',
    \ 'coc-explorer',
    \ 'coc-lists',
    \ 'coc-gitignore',
    \ 'coc-java',
    \ 'coc-html',
    \ 'coc-pairs',
    \ 'coc-css']

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
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <LEADER>rn <Plug>(coc-rename)

" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Coc-yank
nnoremap <silent> <LEADER>y :<C-u>CocList -A --normal yank<CR>

" Coc-explorer
nmap <F1> :CocCommand explorer<CR>

" ===
" === Pre-launch Commands
" ===
" Color
color dracula

exec "nohlsearch"
