" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jlanzarotta/bufexplorer'
Plug 'tomasr/molokai'
Plug 'neovim/nvim-lspconfig'

call plug#end()

" Enable modern Vim features not compatible with Vi spec.
set nocompatible

" Change leader key to ,
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Default indent settings unless overriden by filetypes
set shiftwidth=4
set expandtab
" Enable filetype plugins
filetype plugin indent on
" Enable syntax highlighting
syntax on
" Color scheme
color molokai

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Search
set ignorecase
set hlsearch
set incsearch
set magic

" Persistent undo
set undodir=~/.config/nvim/temp/undodir
set undofile

" Return to last edit position when opening files (THIS IS AMAZING)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" cd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" Move between lines when going right and left
set whichwrap+=<,>,h,l,[,]
" Don't let the cursor to get too close to the top/bottom
set scrolloff=10

" Misc
set mouse+=a  " mouse support
set number    " line number


" No annoying sound on errors
set noerrorbells
set novisualbell

""""""""""""
" Plugins
""""""""""""

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
" Remove buffer name on the right
let g:airline#extensions#tabline#show_splits = 0
" Remove 'tab 3/5' on the right
let g:airline#extensions#tabline#show_tab_count = 0
" Remove 'tabs'/'buffers' on the left
let g:airline#extensions#tabline#show_tab_type = 0
" Remove buffer # next to tab name
let g:airline#extensions#tabline#show_tab_nr = 0
" Remove X close button on the right
let g:airline#extensions#tabline#show_close_button = 0
" Make tabs only show the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" NERDTree
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=1
map <leader>nn :NERDTreeToggle<cr>

" ctrlp
let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 0
if executable('rg')
  let g:ctrlp_user_command = 'rg --hidden --iglob="!.git/" --files %s'
endif

" BufExplorer
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

""""""""""""
" Languages
""""""""""""
" go uses tabs not spaces
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
