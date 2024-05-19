
""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""
set nocp
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""
" Plugin Formats
""""""""""""""""""""""""""

let g:auto_origami_foldcolumn=2
let g:auto_origami_foldcolumn=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_extensions#tabline#show_buffers = 1
let g:airline_theme = 'bubblegum'
let g:indentguides_spacechar = '|'
let g:indentguides_tabchar = '|'
let g:indentguides_firstlevel = get(g:, 'indentguides_firstlevel', 1)
set statusline+=%#warningmsg#
set statusline+=%*
let g:rainbow_active = 1

""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""
syntax on

"Indention
set ai "Auto indent
set si "Smart indent
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set smarttab

"Search
set hlsearch
set ignorecase
set incsearch
set smartcase

"Performance
set complete-=i
set lazyredraw

"Text Rendering
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set nowrap "wrap if want text wrapping

"UI
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set number
set noerrorbells
set mouse=a
set title
set cursorline
set list " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping

"Code Folding
set foldmethod=syntax
set foldlevel=99
set foldnestmax=3
set nofoldenable


"Misc
filetype plugin on
filetype indent on
set autoread
set backspace=indent,eol,start
set formatoptions+=j
set confirm
set hidden
set history=1000
set nomodeline
set noswapfile
set nrformats-=octal
set wildignore+=.pyc,.swp

""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""
set termguicolors
colorscheme catppuccin_macchiato

