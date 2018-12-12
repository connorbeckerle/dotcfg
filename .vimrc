" NOTES
" using https://realpython.com/vim-and-python-a-match-made-in-heaven/
" also https://statico.github.io/vim3.html
" also http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"
" plugins to try installing/using
"   powerline
"   vim-fugitive
"   ag/silver searcher..?
"   nerdtree
"   syntastic (?) / flake8 (?)
"   vim-expand-region (+ and _ as hotkeys)
"   switch capslock, lctrl - http://wiki.c2.com/?RemapCapsLock
"   splitjoin https://github.com/AndrewRadev/splitjoin.vim
"
" features I want:
"   semicolon to switch or open buffer for file
"       search from current directory? or no?
"   switch and manage buffers nicely
"   see syntax errors highlighted
"   auto imports
"   go to super() classdef




" ### VUNDLE ###
set nocompatible  " required for vundle
filetype off " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" PLUGINS GO HERE
" NOTE: !!!! don't forget to run :PluginInstall after adding new one
Plugin 'tmhedberg/SimpylFold'
Plugin 'Konfekt/FastFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-repeat'
"Plugin 'vim-python/python-syntax' " not sure what this does beyond normally..

" color themes
Plugin 'tomasr/molokai' " bad
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'altercation/vim-colors-solarized' " kinda lame
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/seoul256.vim'
Plugin 'Lokaltog/vim-distinguished'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
syntax on 
" ### END VUNDLE ###


" ### PLUGIN SETTINGS ###
" map leader to comma. important to have at top
let mapleader=","

" nice other format stuff
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
set autoindent

" highlight extra whitespace - disabling for now. should be caught by linter
"highlight BadWhitespace ctermbg=red guibg=red
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

colorscheme PaperColor

" youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" unmap this for certain files
autocmd FileType help   noremap <buffer> <C-]> <C-]>
" ycm virtualenv python support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
let g:ycm_filetype_blacklist = {
            \ 'txt': 1,
            \ 'help': 1}

" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"" do syntax check with leader-c
"nnoremap <leader>cc :SyntasticCheck<CR>
"nnoremap <leader>cr :SyntasticReset<CR>
"let b:syntastic_mode='passive'
"let g:python_highlight_all=1
"let g:python_space_error_highlight=0
"let python_highlight_space_error=0 " for plugin I guess

" commentary
nmap <C-_> gcc
vmap <C-_> gc

" fzf stuff
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>s :Lines<CR>
nnoremap <leader>a :Ag<CR>

" gitgutter
set updatetime=100 " update faster


" ### CONNOR MISC SETTINGS ###
inoremap jk <esc>
set background=dark
set encoding=utf-8
set hidden " closing buffers often hides them instead of closing them
" Y yanks to end of line
" Map Ctrl-Backspace to delete the previous word in insert mode.
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
" show colnum in status
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set pastetoggle=<F3> " f3 to toggle paste mode
set number relativenumber " good line numbers
" edit vimrc with ev, reload with source
nnoremap <leader>ev :e ~/.vimrc<CR>
" refresh vimrc
nnoremap <leader>lv :source ~/.vimrc<CR>
" Bind nohl - removes highlight of your last search
noremap <leader>d :nohl<CR>
vnoremap <leader>d :nohl<CR>
" ipdb shortcut
nnoremap <leader>p Oimport ipdb; ipdb.set_trace()<Esc>
" open terminal
nnoremap <leader>t :terminal<CR>
" Y yanks to end of line like it should
noremap Y y$
" Useful settings
set history=700
set undolevels=700
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround " round indent to tabwidth
set expandtab
set fileformat=unix
set hlsearch " Make search case insensitive
set incsearch
set ignorecase
set smartcase
set showmatch " matching brackets flash
" very magic mode for searching. most things need to be escaped. questionable
nnoremap / /\v
set backspace=2 " better backspacing - go over lines etc
" better tab completion
set wildmode=longest,list,full
set wildmenu
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing - not sure if useful
" Enable folding with spacebar
noremap <space> za
set foldmethod=indent
set foldlevel=99
set scrolloff=3
" this is good.
nnoremap ; :
set laststatus=2

" experimental stuff here!


" needs ssh testing
set ttyfast


" write to read-only file with :w!!
cmap w!! w !sudo tee > /dev/null %

" vim controls cursor/copy without line nums
" DOESN'T WORK :(
"se mouse+=v




" ### PRESET DEFAULTS. sketchy ###

" keep windows sized reasonably and split naturally
set winheight=35
set winminheight=5
set splitbelow
set splitright

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" map sort function to a key
" EDIT: remove this
"vnoremap <Leader>s :sort<CR>

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Exclude VC directories
set wildignore+=*/.hg/*,*/.svn/*

