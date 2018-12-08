" NOTES
" using https://realpython.com/vim-and-python-a-match-made-in-heaven/
" things to keep in mind/use/try out:
"   nerdtree
"   syntastic (?) / flake8 (?)
"   vim-expand-region (+ and _ as hotkeys)
"   
" things to try installing
"   powerline
"   vim-fugitive
"   fzf plugin (fzf now installed, also learn it)
"
" misc
"   dotfiles on my git
"       see https://stackoverflow.com/a/4220493/5537652



" ### VUNDLE ###
set nocompatible  " required
"
" Enable syntax highlighting
" You need to reload this file for the change to apply

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
"Plugin 'jnurmine/Zenburn' " color scheme - kinda lame
"Plugin 'altercation/vim-colors-solarized' " color scheme - kinda lame
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
syntax on 
" ### END VUNDLE ###


" PYTHON STUFF - https://realpython.com/vim-and-python-a-match-made-in-heaven

" nice python format stuff
"au BufNewFile,BufRead *.py
"    \ set autoindent
set autoindent

" nice other format stuff
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Enable folding with spacebar
set foldmethod=indent
set foldlevel=99
noremap <space> za

" highlight extra whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" utf8
set encoding=utf-8

" youcompleteme settings
let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1 " don't like this
"let g:syntastic_auto_loc_list = 1 " like default better
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" do syntax check with leader-c
nnoremap <leader>cc :SyntasticCheck<CR>
nnoremap <leader>cr :SyntasticReset<CR>

let python_highlight_all=1
syntax on

" call togglebg#map("<F5>") " for solarized plugin


" ### CONNOR SETTINGS ###

" mapleader to comma:
let mapleader=","

" Makes comments, text look way better
set background=dark

" Map Ctrl-Backspace to delete the previous word in insert mode.
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" f3 to toggle paste mode
set pastetoggle=<F3>

" <leader>f is escape
noremap <leader>f <esc>
inoremap ,f <esc>

" edit vimrc with ev, reload with source
nnoremap <leader>ev :vsp ~/.vimrc<CR>
" refresh vimrc
nnoremap <leader>lv :source ~/.vimrc<CR>

" good line numbers
:set number relativenumber

" Avoid escape
inoremap jk <esc>

" Bind nohl - removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <Leader>d :nohl<CR>
vnoremap <Leader>d :nohl<CR>

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set fileformat=unix

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" very magic mode
" connor note - no idea what this is but I think it's useful?
nnoremap / /\v

" ipdb shortcut
inoremap <leader>pdb import ipdb; ipdb.set_trace()

" write to read-only file with :w!!
cmap w!! w !sudo tee > /dev/null %

" vim controls cursor/copy without line nums
" DOESN'T WORK :(
"se mouse+=v

" better backspacing
set backspace=2

" better tab completion
set wildmode=longest,list,full
set wildmenu




" ### PRESET DEFAULTS ###

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" keep windows sized reasonably and split naturally
set winheight=35
set winminheight=5
set splitbelow
set splitright

" Rebind <Leader> key - DISABLED
"let mapleader = "\<Space>"

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Showing line numbers and length
set number  " show line numbers
"set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" better command line moving
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-d> <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g> <C-c>

"" Buffer movement
"nmap <C-e> :e#<CR>

" Fast save
nnoremap <Leader>w :w<CR>

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Use <leader>l to toggle display of whitespace - disabled
"nmap <leader>l :set list!<CR>
" automatically change window's cwd to file's dir
set autochdir

" Exclude VC directories
set wildignore+=*/.hg/*,*/.svn/*

