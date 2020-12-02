source ~/.config/nvim/plug.vim

" Colors
set termguicolors
set background=light
colorscheme NeoSolarized

"source ~/.config/nvim/lsp.vim
source ~/.config/nvim/coc.vim

" providers - specify paths to speed up startup and avoid vitualenv issues
"let g:python_host_prog = '/bin/python2'
"let g:python3_host_prog = '/bin/python3'

" providers - disable those that are not in need for startup speed
"let g:loaded_python_provider = 0
"let g:loaded_python3_provider = 0
"let g:loaded_node_provider = 0
"let g:loaded_ruby_provider = 0
"let g:loaded_perl_provider = 0

" iCyMind/NeoSOlarized
let g:neosolarized_italic = 1

" yggdroot/indentline
let g:indentLine_color_term=0

" vim-python/python-syntax
let g:python_highlight_all=1

" Ensure comments are always italic
highlight Comment cterm=italic gui=italic

" General (do not use on vim without copying nvim-defaults)
set updatetime=100
set number
set cursorline
set colorcolumn=121
set expandtab
set tabstop=4
set shiftwidth=4
set list
set splitbelow
set splitright
set ignorecase
set smartcase
set scrolloff=1
set spell
set mouse=a
set smartindent
set undolevels=50000
set undoreload=50000
set backup
set undofile
silent !mkdir -p ~/.local/share/nvim/undo
silent !mkdir -p ~/.local/share/nvim/view
silent !mkdir -p ~/.local/share/nvim/swap
silent !mkdir -p ~/.local/share/nvim/backup
set undodir=~/.local/share/nvim/undo
set viewdir=~/.local/share/nvim/view
set directory=~/.local/share/nvim/swap
set backupdir=~/.local/share/nvim/backup

" Bind clear search highlight to window redraw
nnoremap <C-l> :nohlsearch<CR><C-l>

" Place mouse at last location
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
