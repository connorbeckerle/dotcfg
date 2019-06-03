" NOTES
" using https://realpython.com/vim-and-python-a-match-made-in-heaven/
" also https://statico.github.io/vim3.html
" also http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"
" plugins to try installing/using
"   -- high priority -- 
"   make <leader>/ do ag search on current file
"   vim-fugitive (look here for docs https://github.com/tpope/vim-fugitive)
"       keep getting better at it 
"   side search plugin or ctrlsf plugin for better codebase searching
"   try ctrlsf instead of side search? 
"       https://github.com/dyng/ctrlsf.vim
"       might work better with ripgrep
"       has edit-in-search-window
"   try ripgrep instead of ag? 
"       faster
"   black (formatting - https://github.com/ambv/black)
"       try the different python3 config dir
"       try installing with just python3
"   alefix
"       get more tools (like black)
"       make autofix on save
"
"   -- low priority -- 
"   janko vim-test - run tests from in vim
"   splitjoin https://github.com/AndrewRadev/splitjoin.vim
"   nerdtree
"   Plugin 'tmhedberg/SimpylFold'
"   Plugin 'Konfekt/FastFold'
"   vim-notes - https://github.com/xolox/vim-notes
"   vim-misc, vim-session (by xolox)
"   NOTE TAKING:
"       https://news.ycombinator.com/item?id=20049075 (notational velocity)
    "       https://github.com/alok/notational-fzf-vim
"
" features I want:
"   semicolon to switch or open buffer for file
"       search from current directory? or no?
"   switch and manage buffers nicely
"       done ish
"   syntax/style/other error highlighting
"       syntastic
"       ALE - better than syntastic I think. is async
"   show function signature when invoking
"   auto imports with something
"   ycm gotodefinition work with super() classdef
"   ycm gotodefinition work with decorators :(
"   see current class/function def (e.g. go to def of current scope) (or show
"       at bottom)
"   somewhat of a bash thing, but fzf for git branches




" ### VUNDLE ###
set nocompatible  " required for vundle (not compatible with.. vi?)
filetype off " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" PLUGINS GO HERE. NOTE: !!!! don't forget to run :PluginInstall after adding new one
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'w0rp/ale'
" Plugin 'nvie/vim-flake8'  " superseded by ale
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
"Plugin 'vim-python/python-syntax' " not sure what this does beyond normally..
Plugin 'hdima/python-syntax'
" Plugin 'ambv/black'  " need to fix python3 support
Plugin 'ZoomWin'  " this one is not performant lol
" Plugin 'dkarter/bullets.vim'  " TODO - make this work
Plugin 'ddrscott/vim-side-search'

" color themes
Plugin 'tomasr/molokai' " bad - not sure why not working
Plugin 'NLKNguyen/papercolor-theme'
" Plugin 'chriskempson/base16-vim'
" Plugin 'altercation/vim-colors-solarized' " kinda lame
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/seoul256.vim'
" Plugin 'Lokaltog/vim-distinguished'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
syntax on 
" ### END VUNDLE ###


" map leader to comma. important to have at top
let mapleader=","


" ### PLUGIN SETTINGS ###

" ALE
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \   'python': ['flake8']
            \   }
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" maybe do later: isort
            " \       'remove_trailing_lines',
            " \       'trim_whitespace',
let g:ale_fixers = {
            \   'python': [
            \       'black',
            \       ]
            \   }
let g:ale_python_black_options = '-l 100 -S'
command! AF ALEFix

" highlight extra whitespace - disabling for now. should be caught by linter
"highlight BadWhitespace ctermbg=red guibg=red
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" papercolor
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1}},}
  " \   'theme': {
  " \     'default.dark': {
  " \       'transparent_background': 1}}}
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

" commentary - remap ctrl-/ to comment
nmap <C-_> gcc
vmap <C-_> gc

" fzf stuff
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>s :Lines<CR>
nnoremap <leader>a :Ag<CR>

" gitgutter
set updatetime=100 " update faster

" lightline
let g:lightline = {
            \ 'colorscheme': 'default' 
            \}
let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'readonly', 'relativepath', 'modified' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ] ] }
let g:lightline.inactive = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'readonly', 'relativepath', 'modified' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ] ] }
" prevents showing eg '--insert--' in statusbar
set noshowmode

" sidesearch
" note - docs are only here -_- https://github.com/ddrscott/vim-side-search
cabbrev ss SideSearch
" --heading and --stats are required!
let g:side_search_prg = 'ag '
  \. " --ignore='*.js.map'"
  \. " --heading --stats -B 1 -A 4"
" Can use `vnew` or `new`
let g:side_search_splitter = 'vnew'
" I like 40% splits, change it if you don't
let g:side_search_split_pct = 0.4


" ### CONNOR MISC SETTINGS ###

" Diff buffer with saved version: DiffSaved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" this makes command mode (:) case-insensitive. extremely useful
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" nice settings and mappings
inoremap jk <esc>
inoremap Jk <esc>
inoremap JK <esc>
set background=dark
set encoding=utf-8
set hidden " closing buffers now usually hides them instead of closing them. important!
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
nnoremap <leader>pdb Oimport ipdb; ipdb.set_trace()<Esc>
nnoremap <leader>pyt Oimport pytest; pytest.set_trace()<Esc>
" open terminal
nnoremap <leader>t :terminal<CR>
" Y yanks to end of line like it should
noremap Y y$
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
set matchtime=1 " for only 0.1s
set backspace=2 " better backspacing - go over lines etc
" better tab completion
set wildmode=longest,list,full
set wildmenu
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing - not sure if useful
" keep windows sized reasonably and split naturally
set winheight=35
set winminheight=5
set winminwidth=12
set splitbelow
set splitright
" Enable folding with spacebar
noremap <space> za
set foldmethod=indent
set foldlevel=99
set scrolloff=3
" this is good.
nnoremap ; :
nnoremap ;; ;
" makes statusbar permanent even for 1 window
set laststatus=2
" delete current buffer and previous buffer to that window
command! BC b#<bar>bd# 
" ,c copies text to clipboard
vnoremap <leader>c :w !xclip -i -sel c<CR><CR>
" changes to current buffer's dir. -bar says you can concatenate commands with a |
command! -bar CurrDir cd %:p:h 
" assumes fast connection to make more responsive
set ttyfast
" ,en/,ep go to next/prev errors
nnoremap <leader>en :lnext<CR>
nnoremap <leader>ep :lprev<CR>
set autoindent
autocmd FileType html,css,javascript,json,text setlocal tabstop=2 softtabstop=2 shiftwidth=2
" bullet toggle in txt file
autocmd FileType text setlocal commentstring=-%s
" makes re-indenting a lot better
nnoremap < <<
nnoremap > >>
" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
" TODO - resizing is good for laptop. probably make it smarter
noremap <c-h> <c-w>h
" noremap <c-h> <c-w>h | :vertical resize 111<CR>
noremap <c-l> <c-w>l
" noremap <c-l> <c-w>l | :vertical resize 110<CR>


" experimental stuff here!




" write to read-only file with :w!!
" this is kind of deprecated by vim-eunuch
cmap w!! w !sudo tee > /dev/null %


" ### PRESET DEFAULTS. sketchy ###

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Exclude VC directories
set wildignore+=*/.hg/*,*/.svn/*


" REMOTE SETTINGS that I copy to remote servers
" usryzd settings. you can remove these or tell me if they ignore you
" inoremap jk <esc>
" inoremap Jk <esc>
" inoremap JK <esc>
" set background=dark
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set shiftround " round indent to tabwidth
" set expandtab
" set fileformat=unix
" set hlsearch " Make search case insensitive
" set incsearch
" set ignorecase
" set smartcase
" set showmatch " matching brackets flash
" set matchtime=1 " for only 0.1s
" " Bind nohl - removes highlight of your last search
" noremap ,d :nohl<CR>
" vnoremap ,d :nohl<CR>
