set lines=55 columns=85

" Sem retrocompatibilidade com Vi.
set nocompatible
" Antes de iniciar o Vundle, sem destaque de sintaxe por tipo de arquivo.
filetype off

" -------------------VUNDLE---------------------
if has('unix')
    let vimfolder = ".vim"
else
    let vimfolder = "vimfiles"
    let pluginInstallPath = "~/" . vimfolder . "/bundle"
endif

if !filereadable($HOME . '/' . vimfolder . '/bundle/Vundle.vim/.git/config')
    exec '!git clone https://github.com/VundleVim/Vundle.vim '
            \ . $HOME . '\' . vimfolder . '\bundle\Vundle.vim\'
endif

let &rtp .= ",$HOME/" . vimfolder . "/bundle/Vundle.vim"
call vundle#begin(pluginInstallPath)
    " Vundle tem que ser capaz de se atualizar.
    Plugin 'VundleVim/Vundle.vim'

    " Colorscheme Solarized. Para Vim em terminal, o segundo também tem que usar
    " Solarized como tema.
    Plugin 'altercation/vim-colors-solarized'

    " Auto-complete. Requer compilação.
    Plugin 'ycm-core/YouCompleteMe'

    " Powerline para Vim (não funciona pra windows)
    Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
call vundle#end()

" ----------CONFIGURAÇÃO DOS PLUGINS------------

" Para uso do Solarized.
syntax enable
set background=dark
colorscheme solarized

" Para uso do YCM.
set encoding=utf-8

" Para uso do Power Line
set laststatus=2

" ----------PERSONALIZAÇÃO DO VIM---------------

" Ativa detecção de tipo de arquivo, indentação respectiva e mapeamento e opções
" dos plugins baixados.
filetype plugin indent on

let mapleader=","

" vm = maquina virtual.
if has("vms")

    " maquinas virtuais tem configurações de backup próprias.
    set nobackup
else

    set backup
    let &backupdir = $HOME .  "/" . vimfolder . "/backupdir//"

    " Persistent_undo permite manter histórico de mudanças de um arquivo
    " permitindo refazê-las e desfazê-las ao longo de diferentes 'sessões'.
    if has('persistent_undo')

        set undofile
        " Manter todos os arquivos de histórico de mudança em undodir.
            let &undodir = $HOME . "/" . vimfolder . "/undodir//"
    endif
endif

" t_Co guarda quantas cores são suportadas no terminal.
if &t_Co > 2 || has("gui_running")

    " Mostra o último padrão pesquisado.
    set hlsearch
endif

if has("gui_running")

    set guifont=ProFont_for_Powerline:h14:b:cANSI:qDRAFT
endif

" Definição de tema de highlight e funções de assistência
highlight corrigir ctermbg=darkgreen guibg=darkgreen
function GetTrailingSpaces()

    match corrigir /\s\+$/
endfunction

function GetOverLength()

    " Nenhuma linha deve ter mais de 80 caracteres
    match corrigir /\(\(^\s\+\|^\).\{79}\)\@<=.\+/
endfunction

set textwidth=80

" Autocmd permite comandos serem executados assim que se abre um arquivo.
if has("autocmd")

    " Autocmds que que querem atingir o mesmo comportamento são agrupados
    " juntos.  Esses grupos sempre são limpos com au! e autocmd! antes dos
    " autocmds, para evitar duplicatas e, portanto, lentidão.
    augroup compileInterpret

        au!
        autocmd FileType python nnoremap <buffer> <F9> 
                    \ :exec '!python' shellescape(@%, 1)<cr>
    augroup END
endif

" Tabs são simplesmente uma quantidade de espaços.
set expandtab
" Quantidade de espaços de >>, << e ==.
set shiftwidth=4
" Quantidade de espaços de <TAB> e <BS>.
set softtabstop=4

" Enquanto digitando, mostra combinações com o padrão pesquisado
set incsearch
" Mostra localização atual do ponteiro.
set ruler
"Mosra o número de linhas.
set number
" Destaca a linha atual.
set cursorline
" Destaca correspondente parenteses, colchetes etc
set showmatch

" Mapeamentos do modo normal não-recursivos.

" Tira os destaques de pesquisa.
nnoremap <leader><space> :nohls<CR>

" Navegação vertical não ignora longas linhas duplas.
nnoremap j gj
nnoremap k gk

" Mapeamentos do modo normal recursivos.

" Desabilita movimentação por setas.
nmap <up> <nop> nmap <down> <nop> nmap <left> <nop> nmap <right> <nop>

" Mapeamentos do modo de inserção não recursivos.

" Atalho para o modo normal, do modo de inserção.
inoremap jk <esc>

" Opções de folding caso disponíveis.
if has("folding")

    " Habilita folding de funções.
    set foldenable

    " Determina a partir de quanta indentação folds de um arquivo aberto estarão
    " fechadas ou abertas.
    set foldlevelstart=10

    " Profundidade máxima de fold.
    set foldnestmax=10

    " Fold são definidas a partir da indentação.
    set foldmethod=indent

    " Espaço dobra folds.
    nnoremap <space> za
endif

" Permite backspace funcionar como a maioria dos editores de texto, não sendo
" bloqueado para inícios de linha, indentação automática ou início de inserção.
set backspace=eol,start,indent

" :find pode achar qualquer arquivo dentro da pasta em que o Vim foi aberto
" inicialmente.
set path+=**
" Abre um menu quando iterando sobre sujestões de arquivos com taba.
set wildmenu

" Configurações do explorador de arquivos netwr.  Esconde o banner.
let g:netrw_banner=0
" Explora em modo tree
let g:netrw_liststyle=3

" Mostra comandos enquanto são digitados
set showcmd
