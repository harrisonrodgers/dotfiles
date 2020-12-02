" neovim/nvim-lsp
lua << EOF
    local on_attach = function()
      require'completion'.on_attach()
      require'diagnostic'.on_attach()
    end

    require'nvim_lsp'.pyls.setup{
        on_attach=on_attach,
        settings = {
            pyls = {
                plugins = {
                    flake8 = {
                        enabled = true
                    }
                }
            }
        }
    }
    require'nvim_lsp'.jsonls.setup{on_attach=on_attach}
    require'nvim_lsp'.yamlls.setup{on_attach=on_attach}
EOF
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" format on save (not working right now)
"autocmd BufWritePre *.py <cmd>lua vim.lsp.buf.formatting()<CR>
"autocmd BufWritePre *.json <cmd>lua vim.lsp.buf.formatting()<CR>
"autocmd BufWritePre *.yml <cmd>lua vim.lsp.buf.formatting()<CR>
"autocmd BufWritePre *.yaml <cmd>lua vim.lsp.buf.formatting()<CR>

" SirVer/ultisnips
" unset these as tab is used by haorenW1025/completion-nvim
let g:UltiSnipsListSnippets="<F19>"
let g:UltiSnipsExpandTrigger="<F19>"

" haorenW1025/completion-nvim
let g:completion_enable_snippet = 'UltiSnips'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" enable completion in all types of buffers not just the lsps attached above
autocmd BufEnter * lua require'completion'.on_attach()

" haorenW1025/diagnostic-nvim
nnoremap <silent> [l <cmd>PrevDiagnostic<CR>
nnoremap <silent> ]l <cmd>NextDiagnostic<CR>
