" File Behavior
set nobackup
set noswapfile

" Appearance
syntax on
set termguicolors
set background=dark
colorscheme menguless
set number
set ft=txtfmt
filetype on

" Indent/Formatting

"" Indentation
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smarttab
set ruler

"" Text
set textwidth=80
set linebreak
set showbreak=+++

"" Bracing/Surround
set showmatch

"" Bell (no beep)
set visualbell

" Searching
set hlsearch
set smartcase
set ignorecase	
set incsearch

" Typing Behavior
set backspace=indent,eol,start

" ====== Remaps ======

let mapleader = " "

" Window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer Navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>b1 :buffer 1<CR>
nnoremap <leader>b2 :buffer 2<CR>
nnoremap <leader>b3 :buffer 3<CR>
nnoremap <leader>b4 :buffer 4<CR>
nnoremap <leader>b5 :buffer 5<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" NERDTree
nnoremap <leader>pf :NERDTreeToggle<CR>
nnoremap <leader>pv :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>


" ====== Other shit beyond here, beware! ======

" Netrw changes (sauce: https://kitsugo.com/guide/netrw-improvements)

"" Make it a sidebar
let g:netrw_banner = 0 " Hide the Netrw banner on top
let g:netrw_altv = 1 " Split of the Netrw window to the left
let g:netrw_browse_split = 4 " Open files in previous window.
let g:netrw_liststyle = 4 " Set the styling of the file list to be one column with files inside
let g:netrw_winsize = 15

" Netrw Navigation
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END

function! NetrwMappings()
    nnoremap <buffer> a %
    nnoremap <buffer> d :Lexplore<CR>
    nnoremap <buffer> <C-j> <C-w>j
    nnoremap <buffer> <C-k> <C-w>k
    noremap <buffer> ll <Plug>NetrwLocalBrowseCheck
    noremap <buffer> hh <Plug>NetrwBrowseUpDir
endfunction

" Toggle netrw sidebar
nnoremap <leader>npf :Lexplore<CR>
