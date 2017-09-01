set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" Enable syntax
syntax on

" Enable filetype plugins
filetype indent plugin on

" Always display statusline
set laststatus=2

" Custom statusline
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]%#StatusLineNC#\ %#ErrorMsg#\ %{fugitive#statusline()}\ %#StatusLine#%=\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

set number		" show line number
set cindent		" do C program indenting
set smartindent		" do smart indenting
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching
set ignorecase		" ignore case in search patterns
set smartcase		" no ignore case when pattern has uppercase
set showmatch		" briefly jump to matching bracket if insert one
set showmode		" message on status line to show current mode
set showcmd		" display incomplete commands
"set autochdir		" change directory to the file in the current window
set autoread		" autom. read file when changed outside of Vim
set noerrorbells	" ring the bell for error messages
set novisualbell	" use visual bell instead of beeping
set nostartofline	" commands move cursor to first blank in line
set shortmess=a		" no 'Hit ENTER to continue'
set clipboard=unnamed	" yank to clipboard
set encoding=utf8	" set default encoding to utf8
set pastetoggle=<F10>	" key code that causes 'paste' to toggle
set nopaste		" paste is disabled by default
set mps+=<:>		" Make % work with <>
set background=dark	" set background
set t_Co=256		" use 256 colors
set magic		" for regex turn magic on
set lazyredraw		" don't redraw while executing macros
set hlsearch		" highlight search pattern matches
set modeline		" Allow to define options inside file
set colorcolumn=80	" Show vertical line at column 80
set mouse=v		" Enable mouse only in visual mode

" Set extra options when running in GUI mode
if has("gui_running")
    "set guioptions-=m
    "set guioptions-=T
    set guioptions-=e
    set guioptions-=L
    set guifont=GohuFont\ Regular,Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14,Terminus\ 9
endif

" Define colorscheme
let g:solarized_termtrans = 1
colorscheme solarized

" Show/hide taglist
" map <F6> :TagbarToggle<CR>

" Update taglist
" map <F7> :TlistUpdate<CR>

" Show/Hide line numbers
map <F8> :set invnumber<CR>

" Show/hide nerd tree
map <F9> :NERDTreeToggle<CR>

" Run CtrlP
" map <F10> :CtrlP<CR>

" Configure taglist
"let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_WinWidth = 60
"let Tlist_Close_On_Select = 1

" Configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Make CtrlP start searching on project's root dir
let g:ctrlp_working_path_mode = 'ra'

" Add specific params for specific filetypes
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.php,*.inc,*.c call Load_FreeBSD_Style()
au BufNewFile,BufRead dpinger.c set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" List trailing chars
set list
set listchars=tab:▸\ ,trail:·,precedes:…,extends:…,nbsp:‗

" inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Insert current filename on cursor position
inoremap \fn <C-R>=expand("%:t")<CR>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

function! Load_FreeBSD_Style()
	if filereadable(expand("~/work/freebsd/head/tools/tools/editing/freebsd.vim"))
		source ~/work/freebsd/head/tools/tools/editing/freebsd.vim
		call FreeBSD_Style()
	endif
endfun

let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:DisableAutoPHPFolding = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
