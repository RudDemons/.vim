set lines=25 columns=90

" Sem retrocompatibilidade com Vi.
set nocompatible
" Antes de iniciar o Vundle, sem destaque de sintaxe por tipo de arquivo.
filetype off

" Runtime path para Vundle de acordo com o sistema nativo do Gvim, para permitir
" uso dos Vimscripts do Vundle. Esse sistema sup�e que para maquinas Windows
" haver� um Symbolic Link 'vimfiles' apontando para '.vim'.
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

    " Persistent_undo permite manter hist�rico de mudan�as de um arquivo permitindo
    " refaz�-las e desfaz�-las ao longo de diferentes 'sess�es'.
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

if has("win32")

    set guifont=Inconsolata-g:h12:cANSI:qDRAFT
endif

" Defini��o de tema de highlight e fun��es de assist�ncia
highlight corrigir ctermbg=darkgreen guibg=darkgreen
function GetTrailingSpaces()

    match corrigir /\s\+$/
endfunction

function GetOverLength()

    match corrigir /\(\(^\s\+\|^\)\S.\{79}\)\@<=.\+/
endfunction

" Autocmd permite comandos serem executados assim que se abre um arquivo.
if has("autocmd")

    " Autocmds que que querem atingir o mesmo comportamento s�o agrupados juntos.
    " Esses grupos sempre s�o limpos com au! e autocmd! antes dos autocmds, para
    " evitar duplicatas e, portanto, lentid�o.
    augroup compileInterpret

        au!
        autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
    augroup END
endif

" Tabs s�o simplesmente uma quantidade de espa�os.
set expandtab
" Quantidade de espa�os de >>, << e ==.
set shiftwidth=4
" Quantidade de espa�os de <TAB> e <BS>.
set softtabstop=4

" Enquanto digitando, mostra combina��es com o padr�o pesquisado
set incsearch
" Mostra localiza��o atual do ponteiro.
set ruler
"Mostra o n�mero de linhas.
set number
" Destaca a linha atual.
set cursorline
" Destaca correspondente parenteses, colchetes etc
set showmatch

" Mapeamentos do modo normal n�o-recursivos.

" Tira os destaques de pesquisa.
nnoremap <leader><space> :nohls<CR>

" Navega��o vertical n�o ignora longas linhas duplas.
nnoremap j gj
nnoremap k gk

" Mapeamentos do modo normal recursivos.

" Desabilita movimenta��o por setas.
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

" Mapeamentos do modo de inser��o n�o recursivos.

" Atalho para o modo normal, do modo de inser��o.
inoremap jk <esc>

" Op��es de folding caso dispon�veis.
if has("folding")

    " Habilita folding de fun��es.
    set foldenable

    " Determina a partir de quanta indenta��o folds de um arquivo aberto estar�o
    " fechadas ou abertas.
    set foldlevelstart=10

    " Profundidade m�xima de fold.
    set foldnestmax=10

    " Fold s�o definidas a partir da indenta��o.
    set foldmethod=indent

    " Espa�o dobra folds.
    nnoremap <space> za
endif

" Permite backspace funcionar como a maioria dos editores de texto, n�o sendo
" bloqueado para in�cios de linha, indenta��o autom�tica ou in�cio de inser��o.
set backspace=eol,start,indent

" :find pode achar qualquer arquivo dentro da pasta em que o Vim foi aberto
" inicialmente.
set path+=**
" Abre um menu quando iterando sobre sujest�es de arquivos com taba.
set wildmenu

" Configura��es do explorador de arquivos netwr.
" Esconde o banner.
let g:netrw_banner=0
" Explora em modo tree
let g:netrw_liststyle=3
