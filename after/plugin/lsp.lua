-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp_zero = require("lsp-zero")
lsp_zero.preset("minimal")

lsp_zero.ensure_installed({
	"tsserver", -- TypeScript
	"eslint", -- JavaScript
	"rust_analyzer", -- Rust
	"pylint", -- Python
	"yamlls", -- YAML
	"dockerls", -- Docker
})

-- Fix Undefined global 'vim'
lsp_zero.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
})

lsp_zero.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.reference() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<C-n>", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<C-p>", function() vim.diagnostic.goto_prew() end, opts)
end)

-- configure lsp
local lspconfig = require('lspconfig')

lspconfig.pylint.setup({
	single_file_support = false,
	filetypes = { "python" }
})

lsp_zero.setup()

vim.diagnostic.config({
	virtual_text = true
})

-- add black formatter and isort
local null_ls = require('null-ls')
local null_opts = lsp_zero.build_options('null-ls', {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
		--- you can add more stuff here if you need it
	end,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "markdown", "yaml", "typescript" },
		}),
	}
})

-- Autoformat
local conform = require("conform")

conform.setup({
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
	},
})

-- Autocomplete
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		--		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		--		["<C-f>"] = cmp.mapping.scroll_docs(4),
		--		["<C-Space>"] = cmp.mapping.complete(),
		--		["<C-e>"] = cmp.mapping.close(),
		--		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})
