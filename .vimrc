" NOTES
" using https://realpython.com/vim-and-python-a-match-made-in-heaven/
" also https://statico.github.io/vim3.html
" also http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"
" plugins to try installing/using
"   -- high priority -- 
"   vim-fugitive
"   syntax checker (ALE or validator)
"       with... flake8 and/or others...? prospector?
"   ag/silver searcher - make better - use with ripgrep?
"   black (formatting - https://github.com/ambv/black)
"
"   -- low priority -- 
"   powerline
"   splitjoin https://github.com/AndrewRadev/splitjoin.vim
"   nerdtree
"   Plugin 'tmhedberg/SimpylFold'
"   Plugin 'Konfekt/FastFold'
"   vim-notes - https://github.com/xolox/vim-notes
"   vim-misc, vim-session (by xolox)
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
Plugin 'nvie/vim-flake8'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
"Plugin 'vim-python/python-syntax' " not sure what this does beyond normally..
Plugin 'hdima/python-syntax'
" Plugin 'ambv/black'  " need to fix python3 support
Plugin 'ZoomWin'  " this one is not performant lol

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


" ### PLUGIN SETTINGS ###

let g:ale_linters_explicit = 1
let g:ale_linters = {
            \    'python': ['flake8']
            \}

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
" TEMPORARY: try to fix this vim terminal in tmux. actually this can just be
" deleted
" if &term =~ '256color'
"       " disable Background Color Erase (BCE) so that color schemes
"       "   " render properly when inside 256-color tmux and GNU screen.
"       "     " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"             set t_ut=
"             endif

" Diff buffer with saved version: DiffSaved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" this makes command mode (:) case-insensitive
" assumes set ignorecase smartcase
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END


" nice settings and mappings
inoremap jk <esc>
set background=dark
set encoding=utf-8
set hidden " closing buffers often hides them instead of closing them
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
" makes statusbar permanent even for 1 window
set laststatus=2
" bd (buffer kill normally) will now restore previous buffer to that window
" WORSE version cnoremap bd bp<bar>vsp<bar>bn<bar>bd
cnoremap bd b#<bar>bd# 
" ,c copies text to clipboard
vnoremap <leader>c :w !xclip -i -sel c<CR><CR>
" changes to current buffer's dir. -bar says you can concatenate commands with a |
command! -bar CurrDir cd %:p:h 
" assumes fast thing to make more responsive
set ttyfast
" ,en/,ep go to next/prev errors
nnoremap <leader>en :lnext<CR>
nnoremap <leader>ep :lprev<CR>

" experimental stuff here!




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
" TODO - resizing is good for laptop. probably make it smarter
noremap <c-h> <c-w>h
" noremap <c-h> <c-w>h | :vertical resize 100<CR>
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
" TODO - resizing is good for laptop. probably make it smarter
noremap <c-l> <c-w>l
" noremap <c-l> <c-w>l | :vertical resize 101<CR>

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

