" lewdawso's .vimrc
" source at github.com/scripts/dotfiles/vimrc

" lots of good stuff for a starting point / base .vimrc at vim.wikia.com/wiki/Example_vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype detection and indent/plugin loading
filetype plugin indent on

" enable syntax highlighting
syntax on

" better command line completion
set wildmenu 

" highlight searches
set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tabs/indents

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

set ttyfast
set textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" line numbers

set number
set relativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" have filename visible in status line
set laststatus=2

" display curser position in status line
set ruler

" set the command window height to 2 lines
set cmdheight=2

"set visual bell, but set action to empty => no beep or flash
set vb
set t_vb=

" background
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file specific autocmd's

autocmd FileType gitcommit set tw=72
autocmd FileType perl set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"split screen

set splitright
set splitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings

let mapleader = ","

" jump to next error with Ctrl+n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a.
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" open .vimrc with <leader>ev
nnoremap <leader>l :set list!<cr>
nnoremap <leader>ev :sp $MYVIMRC<cr>

" toggle highlighting off
nnoremap <leader>h :noh<cr>

" make Y behave like D,C by yanking until the end of the line rather than yy
map Y y$

nnoremap <leader>s :set spell!<CR>

nnoremap <leader>go :Goyo<CR>
autocmd! User GoyoEnter nested call EnterGoyo()
autocmd! User GoyoLeave nested call LeaveGoyo()

function EnterGoyo()
    :colorscheme seoul256
    Limelight
endfunction

function LeaveGoyo()
    Limelight!
    :colorscheme gruvbox
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" go mappings

augroup go
    autocmd!

    " GoBuild
    autocmd FileType go nmap <leader>b <Plug>(go-build)
    " GoTest
    autocmd FileType go nmap <leader>t <Plug>(go-test)
    " GoMetaLinter
    autocmd FileType go nmap <leader>ml <Plug>(go-metalinter)
    " GoCoverage
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    " GoDefs
    autocmd FileType go nmap <leader>d <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
    " GoRename
    autocmd FileType go nmap <leader>r <Plug>(go-rename)

    let g:go_rename_command = 'gopls'
    let g:go_rename_prefill = ''
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimdiff
if &diff
    highlight! link DiffText MatchParen
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'skywind3000/asyncrun.vim'
Plug 'prettier/vim-prettier'
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" react

" run eslintlint on write and auto fix
autocmd BufWritePost *.jsx AsyncRun -post=checktime npx eslint --fix %

" colorscheme
colorscheme gruvbox

" switch colorschemes
nnoremap <leader>z :colorscheme seoul256<CR>
nnoremap <leader>q :colorscheme gruvbox<CR>

" fzf stuff
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>

" prettier config
let g:prettier#config#tab_width = '2'

" rust
let g:rust_fmt_autosave = 1
