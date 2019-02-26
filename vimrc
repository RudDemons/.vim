" Sem retrocompatibilidade com Vi.
set nocompatible
" Antes de iniciar o Vundle, sem destaque de sintaxe por tipo de arquivo.
filetype off

" Runtime path para Vundle de acordo com o sistema nativo do Gvim, para
" permitir uso dos Vimscripts do Vundle.
" Esse sistema supõe que para maquinas Windows haverá um Symbolic Link
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

" Colorscheme Solarized. Para Vim em terminal, o segundo também tem que usar
" Solarized como tema.
Plugin 'altercation/vim-colors-solarized'

" Auto-complete. Requer compilação.
Plugin 'Valloric/YouCompleteMe'

" Fim dos plugins.
call vundle#end()

" Ativa detecção de tipo de arquivo, indentação respectiva e mapeamento e
" opções dos plugins baixados.
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

  " maquinas virtuais tem configurações de backup próprias.
  set nobackup
else

  set backup

  " Persistent_undo permite manter histórico de mudanças de um arquivo
  " permitindo refazê-las e desfazê-las ao longo de diferentes 'sessões'.
  if has('persistent_undo')

    set undofile

    " Manter todos os arquivos de histórico de mudança em undodir.
    set undodir=~/.vim/undodir
  endif
endif

" t_Co guarda quantas cores são suportadas no terminal.
if &t_Co > 2 || has("gui_running")

  " Mostra o último padrão pesquisado.
  set hlsearch
endif

" Autocmd permite comandos serem executados assim que se abre um arquivo.
if has("autocmd")

  " Autocmds que que querem atingir o mesmo comportamento são agrupados
  " juntos. Esses grupos sempre são limpos com au! e autocmd! antes dos
  " autocmds, para evitar duplicatas e, portanto, lentidão.
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

set expandtab           " Tabs são simplesmente uma quantidade de espaços
set shiftwidth=4        " Quantidade de espaços de >>, << e ==
set softtabstop=4       " Quantidade de espaços de <TAB> e <BS>
set incsearch           " Mostra combinações, enquanto escreve, iguais
set ruler               " Mostra localização atual do ponteiro
set number              " Mostra o número de linhas
set cursorline          " Destaca a linha atual
set showmatch           " Destaca correspondente parenteses, colchetes etc
nnoremap <leader><space> :nohls<CR>
                        " tira os destaques de pesquisa

set foldenable          " habilita folding de funções 
set foldlevelstart=10
                        " faz com que apenas folds muito nested sejam fechadas com
                        " um novo buffer

set foldnestmax=10      " profundidade máxima de fold até 10

nnoremap <space> za     
                        " espaço abre e fecha folds

set foldmethod=indent
                        " fold são dado a partir da indentação

nnoremap j gj
nnoremap k gk
                        " movimentação vertical não ignora longas linhas duplas
inoremap jk <esc>
                        "sair para o modo normal agora é muito mais rápido


" Atalhos compilar/interpretar arquivos
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

set backspace=eol,start
set guifont=Andale\ Mono:h14

" :find pode achar qualquer arquivo dentro da pasta que ele está aberto
set path+=**

" :abre um menu quando iterando sobre sujestões com tab
set wildmenu

" Configurações do explorador de arquivos netwr
let g:netrw_banner=0 "Esconde o banner
let g:netrw_liststyle=3 "Explora em modo tree

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
