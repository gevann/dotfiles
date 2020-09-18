set nocompatible
filetype off
set rtp+=~/.fzf

call plug#begin('~/.vim/plugged')

Plug '/vim-scripts/utl.vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/splitjoin.vim'
Plug 'derekwyatt/vim-scala'
Plug 'gevann/vim-centered'
Plug 'gevann/vim-mkdirf'
Plug 'gevann/vim-rg'
Plug 'gevann/vim-rshell'
Plug 'gevann/vim-rspec-simple'
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'nikvdp/ejs-syntax'
Plug 'pangloss/vim-javascript'
Plug 'qpkorr/vim-bufkill'
Plug 'quramy/vim-js-pretty-template'
Plug 'rking/vim-detailed'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'

call plug#end()

filetype plugin indent on

set autoindent
set autoread
set backspace=indent,eol,start
set breakindent
set complete-=t
set cursorline
set equalalways
set expandtab
set formatoptions+=1
set incsearch
set lazyredraw
set linebreak
set noautochdir
set nobackup
set nocursorcolumn
set belloff=all
set nolist
set noswapfile
set nowrap
set number
set ruler
set scrolloff=7
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set softtabstop=2
set textwidth=0
set updatetime=250
set viewoptions=cursor,folds,slash,unix
set wrapmargin=0

"Mapping vim-style movement between panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"map h, j, k, l movements to their g<movement> counterpart
nnoremap j gj
nnoremap k gk
nnoremap J gJ

"On save remove all trailing white space
autocmd BufWritePre * :%s/\s\+$//e
"On save of .rb files, replace all sections of 2 or more blank lines
"with 1 blank line
autocmd BufWritePre *.rb :%s/\n\{3,}/\r\r/e

au BufWinEnter,BufRead,BufNewFile *.ripgrep set filetype=ripgrep | setlocal cc=""

"syntax on
"colorscheme detailed
"I edited the Normal fg and bg colors in the 'detailed' color scheme to 223
"and 234 respectively

command! -nargs=1 Sgreproutes :new | setlocal buftype=nofile | r! bx rake routes 2> /dev/null | grep <args> | awk '{$1=$1};1' | sed -Ee 's/[[:blank:]]/,/g' | sed -Ee 's/^([[:upper:]])/ ,\1/' | awk '{print $0}' | column -t -s ','
command! -nargs=1 Egreproutes :enew | setlocal buftype=nofile | r! bx rake routes 2> /dev/null | grep <args> | awk '{$1=$1};1' | sed -Ee 's/[[:blank:]]/,/g' | sed -Ee 's/^([[:upper:]])/ ,\1/' | awk '{print $0}' | column -t -s ','
command! -nargs=1 Vgreproutes :vnew | setlocal buftype=nofile | r! bx rake routes 2> /dev/null | grep <args> | awk '{$1=$1};1' | sed -Ee 's/[[:blank:]]/,/g' | sed -Ee 's/^([[:upper:]])/ ,\1/' | awk '{print $0}' | column -t -s ','
command! Filename :r! rg . --files -g "" | fzy -l 3
command! -nargs=1 Columns :vertical resize <args>
command! Hor :windo wincmd K
command! Ver :windo wincmd H

function! MakeMulti()
  exec "normal! ma%imb`aa"
  substitute /\(,\s\+\)/\1\r/g
  exec "normal! `b=`a"
endfunction

command! Multiline :call MakeMulti()

runtime plugin/rshell.vim
"call Rshell('routes', 'bx rake routes | column -t')
"call Rshell('greproutes', "bx rake routes 2> /dev/null | grep <args> | awk '{$1=$1};1' | sed -Ee 's/[[:blank:]]/,/g' | sed -Ee 's/^([[:upper:]])/ ,\1/' | awk '{print $0}' | column -t -s ','")

"call Rshell('curl', 'curl -s <args>')
"call Rshell('jest', 'yarn jest <args>')
"call Rshell('get', 'http -v GET <args>')
"call Rshell('put', 'http -v PUT <args>')
"call Rshell('post', 'http -v POST <args>')

command! -range CURL :execute "r! curl -s " . @*
command! -range HTTP :execute "r! http " . @* . " | sed 's///'"
command! -range GET :execute "r! http -v GET " . @* . " | sed 's///'"
command! -range PUT :execute "r! http -v PUT " . @* . " | sed 's///'"
command! -range POST :execute "r! http -v POST " . @* . " | sed 's///'"
command! -range RG :execute "Srg '" . @* . "'"
command! Jest :execute "!yarn run jest %"


" fzy settings
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy -l 3")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction


" leader remaps
nnoremap <leader>e :GFiles<cr>
nnoremap <leader>/ :BLines!<cr>
"nnoremap <leader>e :call FzyCommand("rg . --files -g ''", ":e")<cr>
nnoremap <leader>g :call FzyCommand("rg $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy)) --files -g ''", ":e")<cr>
nnoremap <leader>re :call FzyCommand("rg . --files -g ''", ":r")<cr>
"nnoremap <leader>s :call FzyCommand("rg . --files -g ''", ":sp")<cr>
"nnoremap <leader>v :call FzyCommand("rg . --files -g ''", ":vs")<cr>
nnoremap <leader>x :! bundle exec ruby %<cr>
nnoremap <leader>mm :call MakeMulti()<cr>
nnoremap <leader>k :call search('\%' . virtcol('.') . 'v\S', 'bW')<cr>
nnoremap <leader>j :call search('\%' . virtcol('.') . 'v\S', 'wW')<cr>

vnoremap <leader>curl y:execute "Scurl " . "<C-r>0"<cr>
vnoremap <leader>get y:execute "Sget " . "<C-r>0"<cr>
vnoremap <leader>post y:execute "Spost " . "<C-r>0"<cr>
vnoremap <leader>put y:execute "Sput " . "<C-r>0"<cr>
vnoremap <leader>http y:execute "Shttp " . "<C-r>0"<cr>

let g:airline#extensions#ale#enabled = 1
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1

" disable netwhrist history
let g:netrw_dirhistmax = -1

"Fugitive settings
autocmd BufReadPost fugitive://* set bufhidden=delete

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" For comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif


"Source local vim settings
if filereadable(glob("~/dotfiles/vim/.vimrc.local"))
    source ~/dotfiles/vim/.vimrc.local
endif

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

highlight ALEWarning term=underline cterm=underline ctermfg=160 ctermbg=233
highlight ALEError term=underline cterm=underline ctermfg=160 ctermbg=233
highlight ColorColumn ctermbg=darkgray
let &colorcolumn=join(range(81,999),",")
let g:fzf_layout = { 'up': '~30%' }
nnoremap <leader>* :execute "Rg " . expand("<cword>")<cr>

syntax on
