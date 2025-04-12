" basics/syntax highlighting
syntax on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" other nice things
set number
set smarttab
set autoindent
set nobackup
set noswapfile
set shiftwidth=4
set tabstop=4
set completeopt-=preview
set shortmess+=c
set laststatus=2
set nocompatible
set background=dark

" Plugin installation
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
" fzf native plugin
Plug 'junegunn/fzf'
" fzf.vim
Plug 'junegunn/fzf.vim'

call plug#end()

" Plugin configuration
" auto-pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsShortcutFastWrap = '<M-e>'
let g:AutoPairsShortcutToggle = '<M-a>'

"NERDTree configuration
nnoremap \ :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Theme and lightline
let g:lightline = {
            \ 'colorscheme' : 'gruvbox',
            \ }
colorscheme gruvbox
