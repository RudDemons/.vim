" Sem retrocompatibilidade com Vi.
set nocompatible
" Antes de iniciar o Vundle, sem destaque de sintaxe por tipo de arquivo.
filetype off

" Runtime path para Vundle de acordo com o sistema nativo do Gvim, para
" permitir uso dos Vimscripts do Vundle.
" Esse sistema sup�e que para maquinas Windows haver� um Symbolic Link
" 'vimfiles' apontando para '.vim'.
if has('unix')

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
else    

    set rtp+=$HOME/.vim/bundle/Vundle.vim
    call vundle#begin('$HOME/.vim/bundle')
endif

" Vundle tem que ser capaz de se atualizar.
Plugin 'VundleVim/Vundle.vim'

" Colorscheme Solarized. Para Vim em terminal, o segundo tamb�m tem que usar
" Solarized como tema.
Plugin 'altercation/vim-colors-solarized'

" Auto-complete. Requer compila��o.
Plugin 'Valloric/YouCompleteMe'

" Fim dos plugins.
call vundle#end()

" Ativa detec��o de tipo de arquivo, indenta��o respectiva e mapeamento e
" op��es dos plugins baixados.
filetype plugin indent on

" Para uso do Solarized.
syntax enable
set background=dark
colorscheme solarized

" Para uso do YCM.
set encoding=utf-8

let mapleader=","

" vm = maquina virtual.
if has("vms")

  " maquinas virtuais tem configura��es de backup pr�prias.
  set nobackup
else

  set backup

  " Persistent_undo permite manter hist�rico de mudan�as de um arquivo
  " permitindo refaz�-las e desfaz�-las ao longo de diferentes 'sess�es'.
  if has('persistent_undo')

    set undofile

    " Manter todos os arquivos de hist�rico de mudan�a em undodir.
    set undodir=~/.vim/undodir
  endif
endif

" t_Co guarda quantas cores s�o suportadas no terminal.
if &t_Co > 2 || has("gui_running")

  " Mostra o �ltimo padr�o pesquisado.
  set hlsearch
endif

" Autocmd permite comandos serem executados assim que se abre um arquivo.
if has("autocmd")

  " Autocmds que que querem atingir o mesmo comportamento s�o agrupados
  " juntos. Esses grupos sempre s�o limpos com au! e autocmd! antes dos
  " autocmds, para evitar duplicatas e, portanto, lentid�o.
  augroup highlightOver74
  au!
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%74v.*/
  augroup END
endif

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
