return {
	"stevearc/conform.nvim",
	lazy = false,
	config = function()
		local conform = require("conform")
		local util = require("conform.util")

		conform.setup({
			notify_on_error = true,

			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft == "python" then
					return { lsp_fallback = false, timeout_ms = 1000 }
				end
				return { lsp_fallback = true, timeout_ms = 500 }
			end,

			formatters_by_ft = {
				python = { "ruff_fix", "ruff_format" },
			},

			formatters = {
				ruff_fix = {
					command = "ruff",
					args = { "check", "--fix", "--select", "I", "--stdin-filename", "$FILENAME", "-" },
					cwd = util.root_file({ "pyproject.toml", "ruff.toml", ".ruff.toml" }),
					stdin = true,
				},
				ruff_format = {
					command = "ruff",
					args = { "format", "--stdin-filename", "$FILENAME", "-" },
					cwd = util.root_file({ "pyproject.toml", "ruff.toml", ".ruff.toml" }),
					stdin = true,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({ async = false, lsp_fallback = false })
		end, { desc = "[F]ormat buffer" })
	end,
}
