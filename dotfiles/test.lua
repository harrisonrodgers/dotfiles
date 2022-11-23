-- null-ls for formatting and linting
require("null-ls").config({
	-- you must define at least one source for the plugin to work
	sources = {
		-- python
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.isort,
		require("null-ls").builtins.diagnostics.flake8,
		require("null-ls").builtins.diagnostics.pylint,
		require("null-ls").builtins.diagnostics.json_tool,
		-- lua
		require("null-ls").builtins.formatting.stylua,
		-- json
		require("null-ls").builtins.diagnostics.json_tool, -- this is python's built in `json.tool`
	},
})

on_attach = function(client)
	-- format on save
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
	end
end

-- Setup for most lsp (plain)
require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
require("lspconfig").pyright.setup({})
require("lspconfig").jsonls.setup({})
require("lspconfig").yamlls.setup({})
require("lspconfig").vimls.setup({})
require("lspconfig").bashls.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").dockerls.setup({})
require("lspconfig").html.setup({})

require("nvim-treesitter.configs").setup({
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},
})

-- Configure Diagnostics (:help vim.lsp.diagnostic.on_publish_diagnostics)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	update_in_insert = true,
	severity_sort = true,
})

-- Configure Diagnostic Signs (:help vim.lsp.diagnostic.set_signs)
vim.fn.sign_define(
	"LspDiagnosticsSignError",
	{ text = "", texthl = "", linehl = "", numhl = "LspDiagnosticsSignError" }
)
vim.fn.sign_define(
	"LspDiagnosticsSignWarning",
	{ text = "", texthl = "", linehl = "", numhl = "LspDiagnosticsSignWarning" }
)
vim.fn.sign_define(
	"LspDiagnosticsSignInformation",
	{ text = "", texthl = "", linehl = "", numhl = "LspDiagnosticsSignInformation" }
)
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = "", linehl = "", numhl = "LspDiagnosticsSignHint" })

-- Configure gitsigns
require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = " ", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = " ", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = " ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = " ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsDelete", text = " ", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
	},
	keymaps = {
		["n gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
	},
})

-- nvim-compe
vim.o.completeopt = "menuone,noselect"
require("compe").setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,

	source = {
		path = true,
		buffer = true,
		tags = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = true,
		nvim_treesitter = true,
		spell = false,
		emoji = false,
	},
})

-- https://github.com/yamatsum/nonicons/blob/master/dist/nonicons.ttf
-- require('lspkind').init({
--     symbol_map = {
--         Text = '',
--         Method = '',
--         Function = '',
--         Constructor = '',
--         Variable = '',
--         Class = '',
--         Interface = '',
--         Module = '',
--         Property = '',
--         Unit = '',
--         Value = '',
--         Enum = '',
--         Keyword = '',
--         Snippet = '',
--         Color = '',
--         File = '',
--         Folder = '',
--         EnumMember = '',
--         Constant = '',
--         Struct = ''
--     },
-- })

-- https://github.com/microsoft/vscode-codicons/blob/main/dist/codicon.ttf
-- require('lspkind').init({
--     symbol_map = {
--         Text = "",
--         Method = "",
--         Function = "",
--         Constructor = "",
--         Field = "",
--         Variable = "",
--         Class = "",
--         Interface = "",
--         Module = "",
--         Property = "",
--         Unit = "",
--         Value = "",
--         Enum = "",
--         Keyword = "",
--         Snippet = "",
--         Color = "",
--         File = "",
--         Reference = "",
--         Folder = "",
--         EnumMember = "",
--         Constant = "",
--         Struct = "",
--         Event = "",
--         Operator = "",
--         TypeParameter = ""
--     },
-- })

-- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
require("lspkind").init({
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "ﲯ",
		Class = "",
		Interface = "ﰮ",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = " ",
		Keyword = "",
		Snippet = "﬌",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "ﬦ",
		TypeParameter = "",
	},
})

require("lsp_signature").on_attach({
	handler_opts = {
		border = "none",
	},
})
