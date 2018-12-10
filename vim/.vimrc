set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()

Plugin 'gmarik/Vundle.vim'


Plugin 'Raimondi/delimitMate'
Plugin 'airblade/vim-gitgutter'
Plugin 'andrewradev/splitjoin.vim'
Plugin 'gevann/vim-centered'
Plugin 'gevann/vim-rg'
Plugin 'gevann/vim-mkdirf'
Plugin 'gevann/vim-rspec-simple'
Plugin 'gevann/vim-rshell'
Plugin 'jceb/vim-orgmode'
Plugin 'kchmck/vim-coffee-script'
Plugin 'leafgarland/typescript-vim'
Plugin 'mxw/vim-jsx'
Plugin 'nikvdp/ejs-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'qpkorr/vim-bufkill'
Plugin 'quramy/vim-js-pretty-template'
Plugin 'rking/vim-detailed'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'utl.vim'
Plugin 'w0rp/ale'

call vundle#end()

filetype plugin indent on

set autoindent
set autoread
set backspace=indent,eol,start
set breakindent
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
call Rshell('routes', 'bx rake routes | column -t')
call Rshell('greproutes', 'bx rake routes | grep <args> | column -t')
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
nnoremap <leader>e :call FzyCommand("rg . --files -g ''", ":e")<cr>
nnoremap <leader>g :call FzyCommand("rg $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy)) --files -g ''", ":e")<cr>
nnoremap <leader>re :call FzyCommand("rg . --files -g ''", ":r")<cr>
nnoremap <leader>s :call FzyCommand("rg . --files -g ''", ":sp")<cr>
nnoremap <leader>v :call FzyCommand("rg . --files -g ''", ":vs")<cr>
nnoremap <leader>x :! bundle exec ruby %<cr>
nnoremap <leader>mm :call MakeMulti()<cr>

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

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif


"Source local vim settings
if filereadable(glob("~/dotfiles/vim/.vimrc.local"))
    source ~/dotfiles/vim/.vimrc.local
endif

syntax on

highlight ALEWarning term=underline cterm=underline ctermfg=160 ctermbg=233
highlight ALEError term=underline cterm=underline ctermfg=160 ctermbg=233
highlight ColorColumn ctermbg=darkgray
let &colorcolumn=join(range(81,999),",")
