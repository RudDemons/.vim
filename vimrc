set nocompatible              " be iMproved, required
filetype off                  " required

" Para uso do YCM
set encoding=utf-8

" set the runtime path to include Vundle and initialize
if has('unix')
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
else    
    set rtp+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin('$HOME/.vim/bundle')
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
colorscheme solarized

let mapleader=","

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

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

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set expandtab           " Tabs s�o simplesmente uma quantidade de espa�os
set shiftwidth=4        " Quantidade de espa�os de >>, << e ==
set softtabstop=4       " Quantidade de espa�os de <TAB> e <BS>
set incsearch           " Mostra combina��es, enquanto escreve, iguais
set ruler               " Mostra localiza��o atual do ponteiro
set number              " Mostra o n�mero de linhas
set cursorline          " Destaca a linha atual
set showmatch           " Destaca correspondente parenteses, colchetes etc
nnoremap <leader><space> :nohls<CR>
                        " tira os destaques de pesquisa

set foldenable          " habilita folding de fun��es 
set foldlevelstart=10
                        " faz com que apenas folds muito nested sejam fechadas com
                        " um novo buffer

set foldnestmax=10      " profundidade m�xima de fold at� 10

nnoremap <space> za     
                        " espa�o abre e fecha folds

set foldmethod=indent
                        " fold s�o dado a partir da indenta��o

nnoremap j gj
nnoremap k gk
                        " movimenta��o vertical n�o ignora longas linhas duplas
inoremap jk <esc>
                        "sair para o modo normal agora � muito mais r�pido


" Atalhos compilar/interpretar arquivos
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

set backspace=eol,start
set guifont=Andale\ Mono:h14

" :find pode achar qualquer arquivo dentro da pasta que ele est� aberto
set path+=**

" :abre um menu quando iterando sobre sujest�es com tab
set wildmenu

" Configura��es do explorador de arquivos netwr
let g:netrw_banner=0 "Esconde o banner
let g:netrw_liststyle=3 "Explora em modo tree

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
