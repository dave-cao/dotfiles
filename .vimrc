" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif



" My Vim Configurations
"
" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

" Enable autocompletion: 
	set wildmode=longest:list,full

" Disables automatic commenting on newline: 
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable a map leader = allows for extra key combinations
let mapleader = " "

" Fast Saving
nmap <leader>w :w!<cr>
nmap <leader>q :wq<cr>
nmap q :q<cr>

" Ignore case when searching
set ignorecase

" When searching, try to be smart about cases
set smartcase

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Set cursor to a smaller cursor when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable 256 colors palette in Gnome Terminal
" if $COLORTERM == 'gnome-terminal'
" 	set t_Co=256
" endif
" 
" try
" 	colorscheme desert
" catch
" endtry
" 
" set background=dark
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc, anyway...
" set nobackup
" set nowb
" set noswapfile
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab, and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Make tabs better
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
	
"""""""""""""""""""""""""""""""""""""""""""""""""""'
" Yanked from ThePrimeagen
""""""""""""""""""""""""""""""""""""""""""""""""""""

set nohlsearch " search doesn't highlight 
set scrolloff=8 " set scroll when your 8 away 

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif 
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox' " Set better colours
Plug 'tmsvg/pear-tree' " auto close brackets
Plug 'preservim/nerdtree' " file tree for vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " auto-completes like intellisense

" Yanked from Nick Janetakis
" I wanted markdown
Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
call plug#end()

" Gruv Box setting
colorscheme gruvbox
highlight Normal guibg=NONE

" Set keybindings for nerd tree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

" Conquerer of completion auto complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" Skeleton dot files

autocmd BufNewFile *.html 0r ~/Documents/System/dotfiles/skeletons/page.html " htmlboiler
autocmd BufNewFile *.md 0r ~/Documents/System/dotfiles/skeletons/read_me.md " readme boilerplate
autocmd BufNewFile *.css 0r ~/Documents/System/dotfiles/skeletons/my_styles.css " styles boilderplate

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable Copy pasting into global clipboard
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>



















