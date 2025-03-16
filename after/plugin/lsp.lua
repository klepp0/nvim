-- Import lsp-zero with the 'minimal' preset
local lsp_zero = require('lsp-zero').preset('minimal')

-- Ensure LSP servers are installed via Mason
lsp_zero.ensure_installed({
	'dockerls',   -- Docker
	'lua_ls',     -- Lua
	'pyright',    -- Python
	'rust_analyzer', -- Rust
	'yamlls',     -- YAML
	"eslint",     -- JavaScript and TypeScript linting
	"ts_ls",      -- TypeScript and JavaScript
})

-- Configure pyright using lsp-zero
lsp_zero.configure('pyright', {
	single_file_support = false,
	filetypes = { 'python' },
})

-- Configure rust_analyzer using lsp-zero
lsp_zero.configure('ts_ls', {
	settings = {
		javascript = {
			format = { enable = false }, -- Disable formatting for JavaScript
		},
		typescript = {
			format = { enable = false }, -- Disable formatting for TypeScript
		},
	},
})

-- Fix Undefined global 'vim'
lsp_zero.nvim_workspace()

-- Set up completion mappings
--local cmp = require('cmp')
--local cmp_select = { behavior = cmp.SelectBehavior.Select }
--local cmp_mappings = lsp_zero.defaults.cmp_mappings({
--	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--})

-- Set preferences for lsp-zero
lsp_zero.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I',
	},
})

-- Define on_attach function with key mappings
lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end)

-- Initialize lsp-zero
lsp_zero.setup()

-- Configure diagnostics to show virtual text
vim.diagnostic.config({
	virtual_text = true,
})

-- Set up mason-null-ls to manage null-ls sources via Mason
require('mason-null-ls').setup({
	ensure_installed = {
		'isort',
		'prettier',
		'ruff',
		'taplo'
	},
	automatic_installation = true,
})

-- Import null-ls and build options with lsp-zero
local null_ls = require('null-ls')
local null_opts = lsp_zero.build_options('null-ls', {})

-- Set up null-ls with the required sources
null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
		-- Add any additional on_attach functionality here
	end,
	sources = {
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.formatting.taplo,
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact',
				'css',
				'html',
				'json',
				'yaml',
				'markdown',
			},
		}),
	},
})
