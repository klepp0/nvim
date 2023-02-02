-- local null_ls_status_ok, null_ls = pcall(require, "null-ls")
-- if not null_ls_status_ok then
--     return
-- end
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

local sources = {
	formatting.prettier.with({
		filetypes = { "html", "json", "yaml", "markdown" },
	}),
	formatting.stylua,
	formatting.black.with({ extra_args = { "--fast" } }),
	-- diagnostics.pylint,
	-- completion.spell,
	formatting.isort,
	diagnostics.pylint.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.code = diagnostic.message_id
		end,
	}),
}

null_ls.setup({
	debug = false,
	sources = sources,
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
