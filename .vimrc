" -----------------------------------------------------------
" Fz84's ultimate vimrc, good for C/C++ developer
"                           ,---.-,                
"                          '   ,'  '.         ,--, 
"     ,---,.              /   /      \      ,--.'| 
"   ,'  .' |             .   ;  ,/.  :   ,--,  | : 
" ,---.'   |       ,----,'   |  | :  ;,---.'|  : ' 
" |   |   .'     .'   .`|'   |  ./   :;   : |  | ; 
" :   :  :    .'   .'  .'|   :       ,|   | : _' | 
" :   |  |-,,---, '   ./  \   \     / :   : |.'  | 
" |   :  ;/|;   | .'  /    ;   ,   '\ |   ' '  ; : 
" |   |   .'`---' /  ;--, /   /      \\   \  .'. | 
" '   :  '    /  /  / .`|.   ;  ,/.  : `---`:  | ' 
" |   |  |  ./__;     .' '   |  | :  ;      '  ; | 
" |   :  \  ;   |  .'    '   |  ./   :      |  : ; 
" |   | ,'  `---'        |   :      /       '  ,/  
" `----'                  \   \   .'        '--'   
"                          `---`-'                 
" Based on: Amir Salihefendic (https://github.com/amix/vimrc)
" -----------------------------------------------------------


" -----------------------------------------------------------
"  Configuration for Vundle
" -----------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"
" Autocomplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'tpope/vim-surround'
Plugin 'lervag/vimtex'
" 
" Moving around
Plugin 'yonchu/accelerated-smooth-scroll'
" Search
Plugin 'dyng/ctrlsf.vim'

" File navigation
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Code reformat
Plugin 'rhysd/vim-clang-format'
"
" editor
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kshenoy/vim-signature'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sjl/gundo.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'ap/vim-buftabline'
"
" Code browsing
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'hari-rangarajan/CCTree'
" 
" Git 
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"
" Others
Plugin 'dietsche/vim-lastplace'
Plugin 'freitass/todo.txt-vim'

" C++ IDE
Plugin 'vim-scripts/a.vim'
Plugin 'drmikehenry/vim-headerguard'
call vundle#end()            " required

filetype plugin on
filetype indent on

set history=700
set autoread " autoread when a file is changed from the outside

" set <leader> to comma
let mapleader=","
let g:mapleader=","

" indent guide
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" tagbar
nnoremap <Leader>ilt :TagbarToggle<CR> 
let tagbar_width=32 
let g:tagbar_compact=1
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }


nmap <F2> :NERDTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
let g:CCTreeKeyToggleWindow = '<leader>cct' 

" ctrlsf
nnoremap <leader>ack :CtrlSF<CR>

" gundo
nnoremap <leader>z :GundoToggle<CR>

" -----------------------------------------------------------
" user interface
" -----------------------------------------------------------

set so=10 " screen offset
nnoremap j gjzz
nnoremap k gkzz

nnoremap Down hDown

set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*
set cursorline

"set ruler "Always show current position
"set cmdheight=1 " Height of the command bar
set hidden " A buffer becomes hidden when it is abandoned

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" make search modern and usable
set ignorecase
set smartcase
set hlsearch
set incsearch 

" folding
"
set foldmethod=syntax
set nofoldenable

" fuzzyfinder (fzf) configuration
let $FZF_DEFAULT_COMMAND = 'ag -g "" --ignore "*.o"'
map <leader>t :FZF<CR>

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" -----------------------------------------------------------
" Colors and Fonts
" -----------------------------------------------------------
syntax enable 
colorscheme gruvbox
set background=dark

if has("gui_running")
    " solarized scheme works better with GUI
    " see https://github.com/altercation/vim-colors-solarized
    let g:solarized_termcolors=256
    let g:solarized_underline=0

    " Set extra options when running in GUI mode
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t

    if has('gui_macvim')
        set guifont=Inconsolata:h14
    else
        set guifont=Fira\ Mono\ for\ Powerline\ 10
    endif
endif

set t_Co=256
set encoding=utf8
set ffs=unix,dos,mac

" -----------------------------------------------------------
" Files, backups and undo
" -----------------------------------------------------------
set nobackup
set nowb
set noswapfile


" -----------------------------------------------------------
" Text, tab and indent related
" -----------------------------------------------------------
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Linebreak on 80 characters
set linebreak
set breakat=80

" disable automatic wrapping
" as suggested by http://blog.ezyang.com/2010/03/vim-textwidth/
set textwidth=0
set fo-=t

set autoindent "Auto indent
set smartindent "Smart indent
set wrap 

" set mouse=i

" -----------------------------------------------------------
" Moving around, tabs, windows and buffers
" -----------------------------------------------------------
"
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Disable search highlight when <leader><CR> is pressed
map <silent> <leader><CR> :noh<CR>

" Jump back to the last access window
nnoremap <leader>wl <c-w><c-p>

" MiniBufExpl stuff
" nnoremap <leader>bf :MBEFocus<cr>

" mappings for managing tabs
nnoremap <silent> <leader>q :bd<CR>
nnoremap <silent> <C-Right> :bn<CR>
nnoremap <silent> <C-Left> :bp<CR>
nnoremap <silent> .. :bn<CR>
nnoremap <silent> ,, :bp<CR>
inoremap <silent> <C-Right> <ESC>:bn<CR>i
inoremap <silent> <C-Left> <ESC>:bp<CR>i
map <leader>e :edit <c-r>=expand("%:p:h")<cr>/
map <leader>w :w!<cr>



" -----------------------------------------------------------
" Editing mappings
" -----------------------------------------------------------
let g:tex_flavor = "latex"

map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

"" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""
" Spell checking
"
if v:version >= 700
    setlocal spell spelllang=en
    set nospell " don't check until I ask you so
    nmap <silent> <leader>s :set spell!<cr>
endif


" -----------------------------------------------------------
" Misc
" -----------------------------------------------------------

" display lineno
set nu


" -----------------------------------------------------------
" Helper functions
" -----------------------------------------------------------
"
"*
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Settings for YCM
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
    \ ]
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_server_keep_logfiles = 1

nnoremap <leader>go :YcmCompleter GoTo<CR>

" AutoPairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}

" Make
nnoremap <leader>m :silent !make -B<CR>

" Ctags
set tags=tags

" Airline
"let g:airline#extensions#bufferline#enabled = 0
"let g:airline#extensions#tabline= 1
"let g:airline_powerline_fonts = 1

" Auto-wrap at will
set sr
set tw=80

" Statusline
set laststatus=2
set statusline=
set statusline +=%y                "file type
set statusline +=\ %<%F            "full path
set statusline +=%m                "modified flag
set statusline +=%=%5l/%L(%2p%%)             "current line
set statusline +=%4v\              "virtual column number
set statusline +=0x%04B\           "character under cursor
"
"let g:airline#extensions#tagbar#enabled = 0
"let g:airline#extensions#ycm#enabled = 0
"let g:airline_section_z = '%=%5l/%L(%2p%%)'

"let g:airline#extensions#default#layout = [
    "\ [ 'a', 'b', 'c' ],
    "\ [ 'x', 'y', 'z']
    "\ ]


"" clighter"
let g:clighter_autostart = 1
let g:clighter_libclang_file = '/usr/local/opt/llvm/lib/libclang.dylib'

" buftabline
let g:buftabline_indicators = 1

" doxgen syntax
let g:load_doxygen_syntax=1

" For local replace
nnoremap gr :%s/\<<C-r><C-w>\>/
