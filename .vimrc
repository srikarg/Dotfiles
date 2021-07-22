inoremap jk <ESC>
let mapleader = ","
filetype on
filetype plugin on
syntax enable
set encoding=utf-8
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
if version >= 700
  set spl=en spell
  set nospell
endif
set number
nnoremap <leader>f 1z=
nnoremap <leader>s :set spell!
vnoremap . :norm.<CR>
