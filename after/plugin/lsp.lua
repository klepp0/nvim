-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp_zero = require("lsp-zero")
lsp_zero.preset("minimal")

lsp_zero.ensure_installed({
	"eslint",     -- JavaScript
	"rust_analyzer", -- Rust
	"pyright",    -- Python
	"yamlls",     -- YAML
	"dockerls",   -- Docker
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
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end)

-- configure lsp
local lspconfig = require('lspconfig')

lspconfig.pyright.setup({
	single_file_support = false,
	filetypes = { "python" }
})

lsp_zero.setup()

vim.diagnostic.config({
	virtual_text = true
})

-- Setup null-ls
local null_ls = require('null-ls')
local null_opts = lsp_zero.build_options('null-ls', {})

-- Utility function to get the path of the current virtual environment
local function get_python_path()
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	else
		return "python"
	end
end

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
		--- you can add more stuff here if you need it
	end,
	sources = {
		null_ls.builtins.diagnostics.pylint.with({
			command = get_python_path(),
			args = function(params)
				return { "-m", "pylint", "--output-format=json", params.bufname }
			end,
			format = "json", -- Ensure null-ls expects JSON format
		}),
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "markdown", "yaml", "javascript", "typescript" },
		}),
	}
})
