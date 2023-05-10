""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""
" remember history for up to 500 lines
set history=500

" filetype plugins
filetype plugin on
filetype indent on

" autoread when file is changed from outside
set autoread
au FocusGained,BufEnter * checktime

" Do extra key combos with map leader
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

":W sudo saves the file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"""""""""""""""""""""""""
" VIM UI
"""""""""""""""""""""""""
" Set 7 lines to cursor
set so=7

" Avoid garbled Chinese characters
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current pos
set ruler

" Height of command bar
set cmdheight=1

" Buffer hidden when abandoned
set hid

" Configure backspace correctly
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search rules
set ignorecase
set smartcase
set hlsearch
set incsearch

" Performance for macros
set lazyredraw

" For regular expressions
set magic

" Highlight matching brackets
set showmatch

" Blink time when matching brackets
set mat=2

" No annoying error sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Left magin
set foldcolumn=1

" Show line numbers
set number

""""""""""""""""""""""""""""""""""
" Colors and fonts
""""""""""""""""""""""""""""""""""

" Syntax highlighting
syntax enable

" Enable 256 palette in GNOME term
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding
set encoding=utf8

" Use Unix as std file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""
" Files, backups, and undo
"""""""""""""""""""""""""""""""""""""""
" If want to disable, do it but I will not for now
" set nobackup
" set nowb
" set noswapfile

"""""""""""""""""""""""""""""""""""""""
" Text, tabs, and indents
"""""""""""""""""""""""""""""""""""""""
" Space except tab
set expandtab

" Smarttab
set smarttab

" 1 tab = 4 spaces
set tabstop=4
set shiftwidth=4

" Linebreak on 500 chars
set lbr
set tw=500

" Indent/wrap lines
set ai
set si
set wrap

""""""""""""""""""""""""""""""""""""""""
" Visual mode
""""""""""""""""""""""""""""""""""""""""
" Press * or # searches for curr selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows, buffers
""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""
" Editing mappings
""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""
" Spell checking
"""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss:setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

""""""""""""""""""""""""""""""""""""
" Helper functions
""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
