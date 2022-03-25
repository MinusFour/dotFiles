" VIM FILE

call plug#begin()
" Vim-Airline and Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
" Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'ajmwagar/vim-deus'

" Javascript Syntax
Plug 'othree/yajs'
Plug 'maxmellon/vim-jsx-pretty'

" Typescript Syntax
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Vim general utilites
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'

" Vim ZEN
Plug 'junegunn/goyo.vim'

" Vim Linters
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Vim snippets
Plug 'mattn/emmet-vim'

" Vim colors
Plug 'ap/vim-css-color'
Plug 'KabbAmine/vCoolor.vim'

call plug#end()

" --- Vim General Config
colorscheme deus
hi Quote ctermbg=109 guifg=#83a598
set termguicolors
set number
set hidden
set nosc
syntax enable
let mapleader = '\'
set shell=/bin/zsh
set updatetime=300
set signcolumn=yes
set mouse=a
set shortmess+=c
set linebreak
set splitright
set breakindent
set nobackup
set nowritebackup
set breakindentopt=shift:4
set showbreak=↪
set noshowmode

" --- Clipboard
set clipboard=unnamedplus

" --- GUI changes
"
set guifont=DelugiaCode\ NF:h12

" Change working directory with new buffer
" autocmd BufEnter * silent! lcd %:p:h

" Disable line numbers in terminal
" https://github.com/onivim/oni/issues/962
augroup TerminalStuff
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" --- Indentation
set ts=4 sw=4 expandtab

" --- Set cursor to default with blink
" set guicursor=n-v-c-sm:block-blinkon100-blinkoff100-blinkwait100,
"	\i-ci-ve:ver25-blinkon100-blinkoff100-blinkwait100,
"	\r-cr-o:hor20-blinkon100-blinkoff100-blinkwait100

" Reset cursor to blinking underscore
au VimLeave * set guicursor=a:hor20-blinkon100-blinkoff100-blinkwait100

" --- Vim-Airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'short_path'
let g:airline_stl_path_style = 'short'
let g:airline#extensions#ale#enabled = 1

" --- Fzf configuration
let g:fzf_command_prefix = 'Fzf'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g ''!.git'' .'

" --- Fzf Mappings
nnoremap <leader>o :FzfFiles<CR>
nnoremap <leader>O :FzfFiles ~<CR>
nnoremap <leader>l :FzfBuffers<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)
map <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-p> fzf#vim#complete#path(
            \ "\{ webpack-aliases-filter; realpath --relative-to=. $(rg --files ".getcwd()."); \} \| cat",
    \ fzf#wrap({'dir': expand('%:p:h'), 'options' : '--tac'})
\)

" --- File Explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1

" --- Ale
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '△'
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'json': ['jsonlint'],
\}
let g:ale_disable_lsp = 1


" --- Command and Conquer mappings
source $HOME/.config/nvim/coc-mappings.vim

" -- Debug highlight groups
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
