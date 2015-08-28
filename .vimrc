set nocompatible

" Common
set autoread
set showcmd
set number
set lazyredraw
set backspace=indent,eol,start
" allow Tab and Shift+Tab to tab  selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv 

set nobackup
set writebackup
set noswapfile

" suggestion for normal mode commands
set wildmode=list:longest
" keep the cursor visible within 3 lines when scrolling
set scrolloff=3
" Line Width 80 characters
set textwidth=80
set colorcolumn=80
highlight ColorColumn ctermbg=lightgray guibg=lightgray

" Encoding
set encoding=utf-8
set fileencoding=utf-8

set fileformat=unix
set fileformats=unix,dos

" Syntax Highlighting
set t_Co=256
syntax on
filetype on
filetype plugin on
filetype indent on

autocmd BufNewFile,BufRead *.md setlocal ft=markdown
autocmd BufNewFile,BufRead *.less setlocal ft=less

" Navigation
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

" Search
set incsearch
set hlsearch

" Indentation
set expandtab
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4


" initiate Vundle
let &runtimepath.=',$HOME/.vim/bundle/Vundle.vim'
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" PLUGINS - START
" > General
Plugin 'vim-scripts/L9'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'itchyny/lightline.vim'      
Plugin 'Lokaltog/vim-easymotion'

" > Development
Plugin 'tpope/vim-surround'
Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'

Plugin 'Valloric/YouCompleteMe'
" YCM (YouCompleteMe) Configuration
"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview
Plugin 'marijnh/tern_for_vim'

Plugin 'tpope/vim-fugitive'

" PLUGINS - END
call vundle#end()

" Mapping and Startup

" start NERDTree on start-up and focus active window
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" delimitMate Configuration
imap <C-c> <CR><ESC>O

" map FuzzyFinder
noremap <leader>b :FufBuffer<cr>
noremap <leader>f :FufFile<cr>

" Emmet mapping - use zencoding with <C-E>
let g:user_emmet_leader_key = '<c-e>'

" Color Scheme
set background=dark
colorscheme wombat256 
