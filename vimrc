" --------------------------------VIM-PLUG------------------------------------

if has('unix')

    let vimfolder = ".vim"
    let vimPlugFile = '~/' . vimfolder . '/autoload/plug.vim'
else

    let vimfolder = "vimfiles"
    let vimPlugFile = '$HOME\' . vimfolder . '\autoload\plug.vim'
endif

if empty(glob(vimPlugFile))

    execute 'silent !curl -fLo ' . vimPlugFile . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/" . vimfolder . "/plugged")

    Plug 'junegunn/vim-plug' " Vim help pro vim-plug

    " Para Vim em terminal, o segundo tamb�m tem que usar Solarized como tema.
    " Basta configurar as 16 cores.
    Plug 'altercation/vim-colors-solarized'

    Plug 'ycm-core/YouCompleteMe'
    " (cmd) Requer compila��o.
    " cmake: instalado e no path.
    " Python 3: Mesma arquitetura que o vim e mesma
    " vers�o que a flag -DDYNAMIC_PYTHON3_DLL.              python3 install.py
    " MSVC 2017: Adiciona no path ou usa parametro          --msvc=15

    " Suporte a C#:                                         --cs-completer
    " Suporte a GO: Instala GO                              --go-completer
    " Suporte a JS e TS: Instala Node.js e NPM              --ts-completer
    " Suporte a Rust:                                       --rust-completer
    " Suporte a Java: Instala o JDK8                        --java-completer
    " Suporte a tudo: Tudo acima                            --all

    " Deus do c�u, lento pra um caralho
    " Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
    
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'
call plug#end()

" -------------------------CONFIGURA��O DOS PLUGINS---------------------------

" altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

" ycm-core/YouCompleteMe
set encoding=utf-8

" powerline/powerline
set laststatus=2

" ------------------------------OP��ES DO VIM---------------------------------

" :help <op��o> � seu amigo. Por algum motivo (suspeito que teclados n�o
" US-International) vim n�o pula entre tags pelo <c-]> como esperado. Ao inv�s
" disso, <c-�> funciona. Algo similar ocorre no modo visual com `> e `<

filetype plugin indent on
let mapleader=","

" 4 colunas extras para a r�gua.
set lines=55 columns=84
set colorcolumn=80 textwidth=78

set expandtab " Tabs s�o espa�os.
set tabstop=4 " S�o quantos espa�os?
set shiftwidth=4 " >> e <<
set shiftround " >> e << sempre para m�ltiplos de shiftwidth

set showcmd
set ruler
set number
set relativenumber
set cursorline

set incsearch
set showmatch
set backspace=indent,eol,start,

set path+=**
set wildmenu

if has("vms")

    set nobackup " M�quinas virtuais tem configura��es de backup pr�prias.
else

    set backup
    let &backupdir = $HOME . "/" . vimfolder . "/backupdir//"

    if has('persistent_undo')

        set undofile
        let &undodir = $HOME . "/" . vimfolder . "/undodir//"
    endif
endif

if &t_Co > 2 || has("gui_running")

    set hlsearch " Sem 2 cores min, sem hl.
endif

" Alternativamente posso colocar tudo aqui dentro de um gvimrc.
if has("gui_running")

    " set guifont=* e set guifont? s�o seus amigos.
    " github.com/powerline/fonts
    set guifont=ProFont_for_Powerline:h14:b:cANSI:qDRAFT
endif

if has("folding")

    set foldenable
    set foldmethod=indent " Might change later, idk...
    set foldlevelstart=10 " Qu�o indentado at� fechar folds automaticamente?
    set foldnestmax=10 " Folds dentro de folds... Foldinception...
endif

" --------------------------CONFIGURA��ES DO VIM------------------------------

" Configura��es do explorador de arquivos netwr. Esconde o banner.
let g:netrw_banner=0
" Explora em modo tree
let g:netrw_liststyle=3

" ----------------------------FUN��ES PESSOAIS--------------------------------

highlight corrigir ctermbg=darkgreen guibg=Red
function GetTrailingSpaces()

    match corrigir /\s\+$/
endfunction

function GetOverLength()

    " Nenhuma linha deve ter mais de 80 caracteres
    match corrigir /\(\(^\s\+\|^\).\{79}\)\@<=.\+/
endfunction

" --------------------------------AUTOCMDS------------------------------------

if has("autocmd")

    augroup vimrc

        autocmd!
        autocmd FileType python nnoremap <buffer> <F9>
                    \ :w<CR>:exec '!python' shellescape(@%, 1)<cr>

        autocmd FileType javascript nnoremap <buffer> <F9>
                    \ :w<CR>:exec '!node' shellescape(@%, 1)<cr>

        autocmd BufReadPost fugitive://* set bufhidden=delete
    augroup END
endif

" -------------------------------MAPEAMENTOS----------------------------------

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <esc> <nop>

nnoremap j gj
nnoremap k gk

nnoremap <leader><space> :nohls<CR>
nnoremap <space> za

if has('clipboard')
    vnoremap <c-c> "+y<esc>
    vnoremap <c-v> v"+p<esc>
endif 
