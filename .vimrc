" Filetype
filetype plugin on
filetype indent on

" auto reload
set autoread

" Tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Scrolloff
set so=7

" Wild menu
set wildmenu
set wildignore=node_modules/*

" Ruler - current position
set ruler

" Buffer Hidden when abandoned
set hid

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

" Macros
set lazyredraw

" Matching Bracks
set showmatch
set mat=2

" No Sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Left Margin
set foldcolumn=1

" Syntax Highlighting
syntax enable

" Color Palette
set t_Co=256
colorscheme desert
set background=dark

" Font
set gfn=Hack\ 14,Bitstream\ Vera\ Sans\ Mono\ 11

" Encoding
set encoding=utf8
set ffs=unix,dos,mac

" Backup and undo
set nobackup
set nowb
set noswapfile

" Linebreak
set lbr
set tw=500

" Indentation
set ai
set si
set wrap

" History
set history=500

" Key Mapings
set backspace=eol,start,indent

" Spell Checking
map <leader>ss :setlocal spell!<cr>

" NERDTree
map <C-\> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" FZF
map <C-P> :Files<CR>

" so ~/.vim/plugins.vim

" Plugins
call plug#begin('~/.vim/plugings')
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
call plug#end()
