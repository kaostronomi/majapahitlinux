filetype plugin indent on
syntax on
set nocompatible
set hidden
set number
set background=dark
set cursorline
set history=1000
set undolevels=1000
set title
set showmode
set showcmd
set mouse=a
set relativenumber
set path+=**
set wildmenu
set ttimeoutlen=50
set textwidth=0
set colorcolumn=
set backspace=indent,eol,start
set autoread
set ignorecase
set laststatus=2
set statusline=%f
set statusline+=%y
set noerrorbells
set nowrap
set expandtab
set smarttab
set autoindent
set smartindent
set sw=4 sts=4 ts=4 "shiftwidth softtabstop tabstop
set t_Co=256
hi  clear ModeMsg " disable color statusline on insert mode and visual mode

let mapleader=","

" move the window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" navigation (insert mode)
inoremap <A-h> <Esc>i
inoremap <A-j> <Esc>ja
inoremap <A-k> <Esc>ka
inoremap <A-l> <Esc>la

" move the window (insert mode)
inoremap <C-h> <Esc><C-w>ha
inoremap <C-j> <Esc><C-w>ja
inoremap <C-k> <Esc><C-w>ka
inoremap <C-l> <Esc><C-w>la

" quick restart vimrc
nnoremap <silent> <leader>r :source $MYVIMRC<CR>

" open vimrc
nnoremap <silent> <leader>ev :e ~/.vimrc<CR>

" backup 
set noswapfile
set backup
set backupdir=~/.vim/backup,~/.backup,~/backup,/var/backup,/backup
set backupskip=/backup/*,/private/backup/*
set directory=~/.vim/backup,~/.backup,~/backup,/var/backup,/backup
set writebackup

" split window
" horizontal split
nnoremap <silent> <leader>- :sp <CR>
" vertical split
nnoremap <silent> <leader>\ :vsp <CR><C-w>l<CR>

" turn on persistent undo
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif
