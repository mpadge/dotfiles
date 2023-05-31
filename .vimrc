" ~./.vimrc
"
runtime! debian.vim 
" sets 'nocompatible'
set nocompatible
filetype off

call plug#begin()
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'jalvesaq/Nvim-R'
Plug 'tyru/open-browser.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'jimhester/lintr'
Plug 'mkitt/tabline.vim'
Plug 'kannokanno/previm'
"Plug 'suan/vim-instant-markdown'
Plug 'wesQ3/vim-windowswap'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-scripts/matchit.zip'
Plug 'craigemery/vim-autotag'
"Plug 'junegunn/fzf'
"Plug 'soywod/himalaya'

"colorschemes (see https://vimcolors.com/):
Plug 'altercation/vim-colors-solarized'
"Plug 'atahabaki/archman-vim'
Plug 'sickill/vim-monokai'
Plug 'jdsimcoe/hyper.vim'
Plug 'megantiu/true.vim'
Plug 'cormacrelf/vim-colors-github'
"Plug 'jreybert/vimagit'
Plug 'preservim/tagbar'
"Plug 'jupyter-vim/jupyter-vim'
"Plug 'pangloss/vim-javascript'
Plug 'Exafunction/codeium.vim'
call plug#end()
filetype plugin indent on

"execute pathogen#infect()

if has("syntax")
    syntax on
endif

"if has ('gui_running')
"    set background=light
"else
"    set background=dark
"endif
set t_Co=16
let g:solarized_termcolors=16
set background=dark
"colorscheme github "light
"colorscheme monokai "dark
colorscheme true "dark

if has("autocmd")
    " Jump to the last position when reopening a file
    "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Load indentation rules and plugins according to the detected filetype.
    " Note these are essential for r-plugin!
    filetype plugin on
    " filetype indent on " set above for vundle
endif

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden         " Hide buffers when they are abandoned

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Extra config lines 
set modelines=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set noexpandtab " noexpand needed for Makevars files to properly insert tabs
set expandtab
set autoindent
set ruler
"set relativenumber
set nu "line numbering
set wrap
set textwidth=80
set colorcolumn=84
set undofile
"global searches, so :%s/foo/bar/g automatically becomes :%s/foo/bar
set gdefault 
"automatically highlight searching
set hlsearch 
" Height of the command bar
set cmdheight=1
set backspace=indent,eol,start


" rename window to current file
" https://vi.stackexchange.com/questions/3897/how-to-label-tmux-tabs-with-the-name-of-the-file-edited-in-vim
"if exists('$TMUX')
"    autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window '" . expand("%:r") . "'")
"    autocmd VimLeave * call system("tmux setw automatic-rename")
"endif

"------------------------------------
" Behavior
"------------------------------------
let maplocalleader = ","
let mapleader = ";"
"let g:mapleader = ","
"set foldenable


"------------------------------------
" Remaps
"------------------------------------
nnoremap <C-L> :nohls<cr>
noremap <C-m> :!make<cr>
nmap <leader>w :w!<cr>
nmap <C-x> :qa<cr>
" Codeium
let g:codeium_map_no_tab = v:true
imap <C-n> <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-b> <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <script><silent><nowait><expr> <C-a> codeium#Accept()

" syntastic
nmap [l :lprev<cr> 
nmap ]l :lnext<cr> 

" openbrowser maps:
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nmap gw <Plug>(openbrowser-open)
vmap gw <Plug>(openbrowser-open)

" Next 2 lines make tab match brackets instead of %
nnoremap <tab> %
vnoremap <tab> %

" edit and source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" paste from clipboard
map <F4> :r!xclip -o<CR>
" copy to clipboard
map <F5> :r!xclip -sel c<CR>

"------------------------------------
" Showmarks
"------------------------------------
let Tlist_Ctags_Cmd = '/usr/bin/ctags-exuberant'
let marksCloseWhenSelected = 0
let showmarks_include="abcdefghijklmnopqrstuvwxyz"

"------------------------------------
" ExploreMode (instead of NERDTree) mapped to F2
" Note that help doesn't work, but just search "vim netrw" or see here:
" https://medium.com/@mozhuuuuu/vimmers-you-dont-need-nerdtree-18f627b561c3
"------------------------------------
function! MyExplore()
    tabnew
    Explore
    nmap <buffer> <leader>q :q<cr>
endfunction

nmap <F2> :call MyExplore()<cr>

"----------------------------------------
"-------------   airline   ---------------
"----------------------------------------

set laststatus=2
" configure vim-airline
let g:airline_theme='term'
"let g:airline_theme='solarized'
"let g:airline_theme='sol'
" show all open buffers on top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
" nice looking things
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

set wildmenu
set wildmode=list:full

"----------------------------------------
"---------   soywod/himalaya   ----------
"----------------------------------------

let g:himalaya_mailbox_picker = 'native'

"----------------------------------------
"-------------   Nvim-R   ---------------
"----------------------------------------

" Set color schemes with `colorout` package in `.Rprofile`

"omni-completion
set omnifunc=syntaxcomplete#Complee

let R_source = '/home/smexus/tmux_split.vim'
" https://github.com/jcfaria/Vim-R-plugin/issues/204
let g:ScreenImpl = 'Tmux'
let g:ScreenShellInitialFocus = 'shell' 
" send selection to R with space bar
vmap <Space> <Plug>RDSendSelection 
" send line to R with space bar
nmap <Space> <Plug>RDSendLine

" stop the plugin remapping underscore to '->':
let R_assign = 0

let g:R_external_term = 0
let g:R_applescript = 0
"let g:R_tmux_split = 1
let g:R_rconsole_height = winheight(0)
let g:R_rconsole_width = winwidth(0) / 2
"let g:R_rconsole_width = 0
"autocmd VimResized * let R_rconsole_width = winwidth(0) / 2
let g:R_nvimpager = "horizontal"
let R_args = ['--no-save', '--quiet']
"let R_tmux_title = 'automatic'
let R_tmux_title = 'R-'.split(getcwd(),'/')[-1]
"let g:R_notmuxconf = 1 "use my .tmux.conf, not the Nvim-r one

let r_syntax_folding = 1


"-------------------------------------------
"---------------   Tagbar   ----------------
"-------------------------------------------

nmap <F8> :TagbarToggle<CR>

"-------------------------------------------
"---------------   previm   ----------------
"-------------------------------------------

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

nnoremap <leader>m :PrevimOpen<cr>

"Manual markdown render with <leader>p
"inoremap <buffer> <F4> <ESC>:call Markdown_Preview()<cr>
"function! Markdown_Preview()
"    let b:curr_file = expand('%:p')
"    call system('pandoc --standalone "' . b:curr_file . '" >/tmp/vim-markdown-preview.html')
"    call system('xdg-open /tmp/vim-markdown-preview.html 1>/dev/null 2>/dev/null &')
"endfunction
"noremap <leader>mp :call Markdown_Preview()<cr> " currently `;mp`

"nmap <leader>p :call Markdown_Preview()<cr>
"nmap <buffer> <F4> :call Markdown_Preview()<cr>

"-------------------------------------------
"-------------   syntastic   ---------------
"-------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set encoding=utf-8

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_w = 0
let g:syntastic_check_on_wq = 0
"let b:syntastic_mode = 0 " disable
" http://stackoverflow.com/questions/20030603/vim-syntastic-how-to-disable-the-checker
let g:syntastic_mode_map = { 
    \ 'mode': 'active', 
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
"let g:syntastic_debug = 1
" - open .cpp and :mes, :SyntasticInfo to get debug info
" see https://github.com/vim-syntastic/syntastic/issues/1246 and
" https://github.com/Valloric/YouCompleteMe#user-content-the-gycm_show_diagnostics_ui-option
let g:ycm_show_diagnostics_ui = 0
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -std=libc++'
let g:syntastic_enable_cpp_check_header = 1
let g:syntastic_enable_cpp_lint_checker = 1
let g:syntastic_enable_cpp_clang_check = 1
let g:syntastic_enable_cpp_clang_tidy = 1
let g:syntastic_cpp_checkers = ['gcc', 'clang_check', 'clang_tidy', 'cpp_lint']

let g:syntastic_cpp_clang_check_quiet_messages = {"regex":
    \ ['file not found']}

" jimhester/lintr:
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
let g:syntastic_enable_rmd_lintr_checker = 1
let g:syntastic_rmd_checkers = ['lintr']
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 10])
    endif
endfunction

let g:syntastic_r_lintr_quiet_messages = {"regex": 
    \ ['Commented code should be removed',
    \ 'Remove spaces before the left parenthesis']}
let g:syntastic_rmd_lintr_quiet_messages = {"regex": 
    \ ['Commented code should be removed',
    \ 'Remove spaces before the left parenthesis']}
"let g:syntastic_r_lintr_quiet_messages = {"regex": 
"    \ ['Only use double-quotes.', 'Opening curly braces should never',
"    \ 'No visible global function definition', 'Commented code should be removed',
"    \ 'Remove spaces before the left parenthesis']}
"let g:syntastic_rmd_lintr_quiet_messages = {"regex": 
"    \ ['Only use double-quotes.', 'Opening curly braces should never',
"    \ 'No visible global function definition', 'Commented code should be removed',
"    \ 'Remove spaces before the left parenthesis']}
" syntastic has :Error, so this is required for :E to work again
" (https://github.com/vim-syntastic/syntastic/issues/164)
command! E Ex

"-------------------------------------------
"-------------   vim-latex   ---------------
"-------------------------------------------

" Set grep program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd BufRead,BufNewFile *.tex call CheckFileType()
function! CheckFileType()
    set textwidth=144
    set colorcolumn=150
    set syntax=context " or tex, latex, plaintex
endfunction

" set same widths for text files too
autocmd BufNewFile,BufRead *.txt set textwidth=144 | set colorcolumn=150


"-------------------------------------------
"------------   jupyter-vim   --------------
"-------------------------------------------

if has('nvim')
        let g:python3_host_prog = '/path/to/python/bin/python3'
else
        set pyxversion=3
endif

" =============== WORD COUNT FUNCTION =============
" From http://stackoverflow.com/questions/2974954/correct-word-count-of-a-latex-document
" with modifications from:
" http://tex.stackexchange.com/questions/534/is-there-any-way-to-do-a-correct-word-count-of-a-latex-document
" NOTE that this is globally defined for ALL filetypes, and may muck up other <F3> mappings!
:map <F3> :call WC()<CR>
function! WC()
    let filename = expand("%")
    "let cmd = "detex " . filename . " | wc -w | perl -pe 'chomp; s/ +//;'"
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction
" g<C-g> just counts words of a selection, but does not detex.

" NOTE that the above WC() function seems to give really rubbish estimates.
" A superior alternative is texcount, gives far more detail, for which see
" http://app.uio.no/ifi/texcount/howto.html
" To run it, just type :!texcount %<CR>
" It takes a while, but is far more accurate. It is nevertheless not really
" accurate, because it still counted far more words that those remaining when all
" major environments were excised. This is nevertheless possibly just because of
" \itemize, lists, and so on, so it seems to be the best way for the moment.


" =============== SPELL CHECKING =============
" NOTE that spell stopped working with .tex at some stage, and can be fixed by
" entering :syn spell toplevel.  To avoid having to manually enter this every
" time, follow the instructions in ":h mysyntaxfile-add": 
" Make a new directory in /.vim/after/sytax, with "tex.vim" holding this syn
" command. 
" Add a word to the `spellfile` with `zg`
" The mysyntaxfile-add instructions also have lots of details about custom
" colour highlight schemes and the likes.
set spell spelllang=en_gb
set spellfile=~/dictionary.utf-8.add
set nospell
