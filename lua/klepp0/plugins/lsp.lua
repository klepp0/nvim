return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v1.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		-- Null-LS
		{ "jay-babu/mason-null-ls.nvim" },
		{ "jose-elias-alvarez/null-ls.nvim" },
	},
	config = function()
		-- Mason setup (must come before lsp-zero)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
			ensure_installed = {
				"pyright",
				"debugpy",
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"ruff",
				"gopls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"pylint",
				"ruff",
				"gopls",
			},
		})

		-- LSP Zero setup
		local lsp_zero = require("lsp-zero").preset("minimal")

		lsp_zero.ensure_installed({
			"dockerls",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"yamlls",
			"eslint",
			"ts_ls",
		})

		lsp_zero.configure("pyright", {
			single_file_support = false,
			filetypes = { "python" },
		})

		lsp_zero.configure("ts_ls", {
			settings = {
				javascript = {
					format = { enable = false },
				},
				typescript = {
					format = { enable = false },
				},
			},
		})

		lsp_zero.nvim_workspace()

		lsp_zero.set_preferences({
			suggest_lsp_servers = false,
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		lsp_zero.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		end)

		lsp_zero.setup()

		-- Diagnostics
		vim.diagnostic.config({
			virtual_text = true,
		})

		-- Null-LS setup
		require("mason-null-ls").setup({
			ensure_installed = {
				"isort",
				"prettier",
				"ruff",
				"taplo",
				"stylua",
			},
			automatic_installation = true,
		})

		local null_ls = require("null-ls")
		local null_opts = lsp_zero.build_options("null-ls", {})

		null_ls.setup({
			on_attach = function(client, bufnr)
				null_opts.on_attach(client, bufnr)
			end,
			sources = {
				null_ls.builtins.formatting.taplo,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"html",
						"json",
						"yaml",
						"markdown",
					},
				}),
			},
		})
	end,
}
