set nocompatible              " be iMproved, required
filetype on                   " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tomasr/molokai'
Plugin 'myusuf3/numbers.vim'
Plugin 'powerline/powerline.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'ervandew/supertab'
Plugin 'wesQ3/vim-windowswap'
Plugin 'airblade/vim-gitgutter'
" Plugin 'tpope/vim-fugitive.git'
Plugin 'easymotion/vim-easymotion.git'
Plugin 'danro/rename.vim'
Plugin 'junegunn/fzf.git'
Plugin 'sheerun/vim-polyglot.git'
Plugin 'elzr/vim-json'
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" -----------------------------------------------------------------------------------------
"								 SUPERTAB
" Tab will trigger the file completion autocomplete method by default
let g:SuperTabDefaultCompletionType = "context"

" -----------------------------------------------------------------------------------------
"								 EASYMOTION
" EasyMotion
let g:EasyMotion_leader_key = '<Space>'
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" Bidirectional & within line 't' motion
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

map <Space><Right> <Plug>(easymotion-lineforward)
map <Space><Left> <Plug>(easymotion-linebackward)
nmap <Space>a <Plug>(easymotion-s)
nmap <Space>s <Plug>(easymotion-s2)

" -----------------------------------------------------------------------------------------
"								 JSON
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=4
  autocmd FileType json set softtabstop=4 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" -----------------------------------------------------------------------------------------
"								 FORMATTING
au BufRead,BufNewFile {Gemfile,Rakefile,Berksfile,Thorfile,config.ru}    set ft=ruby

" -----------------------------------------------------------------------------------------
"								 CUSTOM DEFAULTS

"Color
set t_Co=256 "enable 256 colors
syntax on "enable syntax coloring
silent! colorscheme molokai

" Backspace (allow you to backspace normally cause vim tries to help by preventing you)
set backspace=indent,eol,start

" Leader
:let mapleader = ";"

" Update frequency for things like vim-go's go_auto_type_info
set updatetime=1000

" Put swp files in tmp dir
set swapfile
set dir=/tmp

" Show line numbers
set number

" Enable bling/vim-airline.git plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1              " enable fancy symbols

" Always show statusline
set laststatus=2

" Command Mode AutoComplete ex: Hit <shfit>:, start typing, hit tab
set wildmenu
set wildmode=list:longest,full

"                               -- TABS vs SPACES --
" When I hit tab, enter spaces instead
set expandtab

" Number of spaces to expand an actual tab to
set tabstop=4
set softtabstop=4

" Number of spaces to shift when doing a shift > or shift <
set shiftwidth=4

set nowrap

" Tabs Whitespace End of Line
set list lcs=tab:»·,eol:¬,trail:·
"set list lcs=tab:▸\ ,eol:¬

" Enable paste
set pastetoggle=<F2>

" Auto source vimrc on save
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

"SHORTCUTS
nnoremap <C-t> :tabnew %<CR>
nnoremap <Leader>tt :tabnew %<CR>
nnoremap <Leader>] :tabnext<CR>
nnoremap <Leader>[ :tabprevious<CR>
nnoremap <Leader>tq :tabclose<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>hs :split<CR>
nnoremap <Leader>vs :vsplit<CR>
nnoremap <Leader>d :bdelete<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>r :!%:p<CR>

" write the file when you accidentally opened it without the right (root) privileges
cmap w!! w !sudo tee % > /dev/null

"Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=10         "whatever you want

"Search is case insensitive
set ic

"ENABLE RESIZE WITH MOUSE
"Send more characters for redraws
if !has('nvim')
    set ttyfast
endif

" Enable mouse use in all modes
set mouse=a

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
if !has('nvim')
    set ttymouse=xterm2
endif

"Windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" -----------------------------------------------------------------------------------------
"								 NERDTREE
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1                     " display dotfiles
let NERDTreeQuitOnOpen = 1                     " close nerdtree after opening a file
let g:nerdtree_tabs_autoclose = 1              " prevent nerdtree from closing
let g:nerdtree_tabs_open_on_gui_startup = 1    " open nerdtree on startup

" -----------------------------------------------------------------------------------------
"								 FZF
nnoremap <Leader>f :FZF<CR>
