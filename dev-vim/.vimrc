""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set syntax on
syntax on
" indent automatically depending on filetype
filetype indent plugin on
set autoindent
set nocompatible
" wrap text instead of being on one line
set lbr
" turn on line numbering.
set number
" turn on relative numbering
set relativenumber
" always show the status line
set laststatus=2
" using a 256 color terminal
set t_Co=256
" show a visual line under the cursor's current line
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch

"tabs
set smarttab
" buffers
" This allows buffers to be hidden if you've modified a buffer.
" This is to use buffers instead of tabs
set hidden


" Open a new empty buffer
nmap <leader>T :enew<CR>" Move to the next buffer
nmap <leader>l :bnext<CR" Move to the previous buffer
nmap <leader>h :bprevious<CR" Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
" nmap <leaderq :bp <BARd #<CR" Show all open buffers and their status
" nmap <leaderl :ls<CR>>>>>>>>>>>

" indentation
set si "smart indent
set ai "auto indent
set wrap "wrap lines

"special characters
set list
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
" set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
hi NonText ctermfg=16 guifg=#4a4a59
hi SpecialKey ctermfg=16 guifg=#4a4a59

" sets the system buffer for clipboard
set clipboard=unnamedplus

" backspace behaviour at eol
set backspace=indent,eol,start

"open/close
" return to last edit position when opening files
autocmd bufreadpost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" remember info about open buffers on close
set viminfo^=%
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" activate plugins
execute pathogen#infect()

" NERDTree
" Open NT if no file is specified on VIM open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close NT if only window still open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree toggle shortcut
map <c-n> :NERDTreeToggle<cr>

" Airline
let g:airline_theme='molokai'
" Airline tab line
let g:airline#extensions#tabline#enabled = 1

" tagbar
nmap <F8> :TagbarToggle<CR>

" " syntastic plugin recomeneded settings
set statusline+=%#warningmsg#
set statusline+=%{syntasticstatuslineflag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" " syntastic set specific checkers for filetypes
" let g:syntastic_python_checkers = ['flake8']
" "let g:syntastic_yaml_checkers = ['yamlxs']
" let g:syntastic_mode_map = { 'passive_filetypes': ['yaml'] }
" 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" case insensitive search
set ic
" higlhight search
set hls
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""shortcut keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
"ctrl-a select all
map <c-a> <esc>ggvG<cr>
" close file with <leader>q
noremap <leader>q :q<cr>
" save file with <leader>s
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr> #works in insert mode
" <ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <esc><esc> :noh<CR>
" convenient escape
inoremap jj <esc>
" moving between split panes
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
" moving between tabs
noremap <S-l> gt
noremap <S-h> gT
" Automatically add closing ( { [ ' " `
inoremap {<cr> {<cr>}<ESC>kA<CR>
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
" au FileType html,vim,xhtml,xml inoremap < <lt>><ESC>i| inoremap > <c-r>=ClosePair('>')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""language specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colour column
autocmd filetype python set colorcolumn=80
" sensible python defaults
autocmd BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=uni

" remap f5 to execute python script
autocmd filetype python nnoremap <buffer> <f5> :exec '!python3' shellescape(@%, 1)<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""json/yaml
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yaml files have the right tabbing
autocmd filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
" yaml files open with folds 
au! BufNewFile,BufReadPost *.{yaml,yml,tf,cfn} set filetype=yaml foldmethod=indent
"" set up stuff that is usually json
autocmd BufNewFile, BufRead *.cfn  set ft=yaml
autocmd BufNewFile, BufRead *.params set ft=json
autocmd BufNewFile, BufRead dockerfile set ft=yaml

" make filetype
autocmd filetype make setlocal noexpandtab
