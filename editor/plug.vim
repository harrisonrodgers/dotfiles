call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-plug'

" Theme
Plug 'iCyMind/NeoSolarized'
Plug 'yggdroot/indentline'
"Plug 'unblevable/quick-scope'

" Syntax
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'

" LSP
"Plug 'neovim/nvim-lsp'
"Plug 'haorenW1025/completion-nvim'
"Plug 'haorenW1025/diagnostic-nvim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}

" Snippets engine & library
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Misc
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()
