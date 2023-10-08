set nocompatible " We're running Vim, not Vi!
set title

" We love utf8
set encoding=utf-8
set fileencoding=utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	" A vim plugin that simplifies the transition between multiline and
	" single-line code
	Plug 'AndrewRadev/splitjoin.vim'

	"Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
	Plug 'ConradIrwin/vim-bracketed-paste'

	" fugitive.vim: a Git wrapper
	Plug 'tpope/vim-fugitive'

	" surround.vim: quoting/parenthesizing made simple
	Plug 'tpope/vim-surround'

	" NERD tree will be loaded on the first invocation of NERDTreeToggle command
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

	" # Syntax Highlighting
	Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
	" https://github.com/elzr/vim-json
	Plug 'elzr/vim-json'
	Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
	Plug 'rust-lang/rust.vim'

	" Themes
	Plug 'tomasr/molokai'
	Plug 'mhartington/oceanic-next'
	Plug 'catppuccin/vim', { 'as': 'catppuccin', 'branch': 'main' }

	" A.L.E (https://github.com/w0rp/ale)
	Plug 'w0rp/ale'
call plug#end()


syntax enable         " Enable syntax highlighting
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

let mapleader = ","

" hide buffers instead of closing them
set hidden

set wrap " wrap lines

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.rbc,*.class,*.hi,*.o,*.mmo,.git,.svn

set pastetoggle=<F2>

" always show the status bar
set laststatus=2

set shell=/bin/zsh
set nu
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set formatoptions-=o
set ignorecase
set smartcase
set gdefault                   " applies substitutions globally on lines (like /g)
set ruler                      " show me where the cursor is
set rulerformat=%l/%L(%p%%),%c " a better ruler
"set hlsearch
set visualbell
set noerrorbells
set lazyredraw


set tabstop=4
set softtabstop=4
set shiftwidth=4

"highlight current line
set cursorline

"highlight long lines
"let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235 guibg=#2c2d27
"let &colorcolumn="80,".join(range(120,999),",")

" instead of :lcd %:p:h
" to change directories upon opening a file
"set autochdir

" set wildmenu on
set wmnu

" swap file directory
set directory^=~/.vim/swap

" don't store .viminfo in $HOME
set viminfo+=n~/.vim/viminfo

" enable display of invisible whitespace
set list
" toggle invisible whitespace display
nmap <leader>l :set list!<CR>
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬

" copy and paste ;)
vmap <C-c> "*y     " Yank current selection into system clipboard
nmap <C-c> "*Y     " Yank current line into system clipboard (if nothing is selected)
nmap <C-v> "*p     " Paste from system clipboard

" Theme
syntax enable
set t_Co=256
colorscheme catppuccin_mocha

set backspace=indent,eol,start

let g:rehash256 = 1
" for use with :Gist
"" clipboard fix
let g:gist_clip_command = 'xclip -selection clipboard'

" Using Tag completion for php
let g:tagcommands = {
	\	"php" : {
	\	"tagfile" : ".php.tags",
	\	"args" : "-R"
	\	}
\}

" autocmd
"" delete trailing whitespace on save
"" via http://gist.github.com/227361 (defunkt)
"" and
"" http://vimcasts.org/episodes/tidying-whitespace/
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre *.c,*.cpp,*.rb,*.erl,*.tex,*.xml,*.java,*.js,*.php,*.pde,*.css,*.tpl,*.txt,PKGBUILD,*.ronn,*.hs :call StripTrailingWhitespaces()
autocmd BufWritePre *.scss,*.erb,Rakefile :call StripTrailingWhitespaces()

"" delete trailing whitespace, but leave if more than one.
"" this enables <br>-style wrapping in markdown
function! StripTrailingWhitespacesMarkdown()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\(\S\)\s$/\1/e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre *.md,*.markdown :call StripTrailingWhitespacesMarkdown()

" Special handling for Markdown
function! <SID>PandocMarkdownFile()
    silent exec '!pdocm ' . shellescape(@%)
endfunction
autocmd BufWritePost *.m.md :call <SID>PandocMarkdownFile()



" Filetypes
augroup filetypedetect
	command! -nargs=* -complete=help Help vertical belowright help <args>
	autocmd FileType help wincmd L

	autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
	autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
	autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

	autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
	autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
	autocmd BufNewFile,BufRead *.html setlocal expandtab shiftwidth=2 tabstop=2
	autocmd BufNewFile,BufRead *.js setlocal expandtab shiftwidth=2 tabstop=2
	autocmd BufNewFile,BufRead *.yml setlocal expandtab shiftwidth=2 tabstop=2
	autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
	autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2

	autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2


	autocmd FileType php setlocal comments=sl:/*,mb:*,elx:*/
augroup END

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<CR>

" fix Vim's horribly broken default regex “handling”
nnoremap / /\v
vnoremap / /\v
" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/"

" enable :W, stupid typo
command! W w
command! Q q

" apply rot13 for people snooping over shoulder, good fun
map ,8 <ESC>ggg?G``

map <F10> :tabnew <CR>
map <F12> :NERDTreeToggle<CR>
"map \     :NERDTreeToggle<CR>

" Easy split window navigation
" use ALT+ArrowKeys to switch split windows
nmap <silent> <A-Up>    :wincmd k<CR>
nmap <silent> <A-Down>  :wincmd j<CR>
nmap <silent> <A-Left>  :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

cmap w!! w !sudo tee % > /dev/null

" no one needs help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" provide some context when editing
set scrolloff=3

" from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" Sometimes F2 won't work, so use ,p
map <leader>p :set paste!<CR>


" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" more natural splitting
" via thoughtsbot
set splitbelow
set splitright

" http://vimcasts.org/episodes/soft-wrapping-text/
" Show … in front of wrapped line
set showbreak=…
