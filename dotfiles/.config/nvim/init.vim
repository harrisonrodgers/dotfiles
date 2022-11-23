if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'lifepillar/vim-solarized8'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'yggdroot/indentline'
"Plug 'itchyny/lightline.vim'
call plug#end()

let g:python_highlight_all=1
let s:terminal_italic=1" >> $HOME/.vimrc && \
set t_ZH=[3m
set t_ZR=[23m
highlight Comment term=italic gui=italic cterm=italic
highlight htmlArg term=italic gui=italic cterm=italic
let g:indentLine_color_term=0

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

set hidden

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[l` and `]l` to navigate diagnostics
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set termguicolors
set background=light
silent! colorscheme solarized8

" General (NVIM defaults)
set updatetime=100
set nocompatible
set incsearch
set display=lastline
set history=10000
set autoread
set hlsearch
set showcmd
set ruler
set autoindent
set wildmenu
set smarttab
set ttyfast
set t_Co=256
syntax enable
filetype plugin indent on

" General (more)
scriptencoding utf-8
set encoding=utf-8
set number
set cursorline
set colorcolumn=121
set expandtab
set tabstop=4
set shiftwidth=4
"set listchars=tab:Â»\ ,trail:Â·
set list
set splitbelow
set splitright
set ignorecase
set smartcase
set scrolloff=1
set spell
set laststatus=1
set mouse=a
set undolevels=50000
set undoreload=50000
set smartindent
set backup
silent !mkdir -p ~/.config/nvim/backup
set backupdir=~/.config/nvim/backup
silent !mkdir -p ~/.config/nvim/swap
set directory=~/.config/nvim/swap
silent !mkdir -p ~/.config/nvim/view
set viewdir=~/.config/nvim/view
set undofile
silent !mkdir -p ~/.config/nvim/undo
set undodir=~/.config/nvim/undo

" Ensure mouse works inside Docker & Tmux
"set ttymouse=xterm2

" Bind clear search highlight to window redraw
nnoremap <C-l> :nohlsearch<CR><C-l>

" Place mouse at last location
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

set laststatus=2
set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}%{coc#status()}

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit ad current position
nmap gc <Plug>(coc-git-commit)
