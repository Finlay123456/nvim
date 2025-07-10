-- Setup mason and mason-lspconfig
require('mason').setup()
require('mason-lspconfig').setup {
	ensure_installed = {
		'ts_ls',         -- typescript (was tsserver)
		'eslint',
		'lua_ls',        -- was sumneko_lua
		'rust_analyzer', -- add/remove as you wish!
		-- add 'pyright', 'gopls', etc. if you want more
	},
	automatic_installation = true,
}

-- Set preferences, no sign icons (like his setup)
vim.diagnostic.config({
	signs = false,
})

-- nvim-cmp autocompletion
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lua' },
	}
})

-- Setup LSP servers and attach keymaps on_attach
local lspconfig = require('lspconfig')
local servers = { 'ts_ls', 'eslint', 'lua_ls', 'rust_analyzer' }

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
	}
end
