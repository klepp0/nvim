return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		telescope.setup({
			extensions = { ["ui-select"] = { themes.get_dropdown() } },
			pickers = {
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
			defaults = {
				file_ignore_patterns = {
					-- Version Control
					"%.git/",
					-- Dependencies & Environments
					"node_modules/",
					"%.venv/",
					"vendor/",
					"__pycache__/",
					"env/",
					"venv/",
					-- Lockfiles
					"poetry%.lock",
					"package%-lock%.json",
					"yarn%.lock",
					"pnpm%-lock%.yaml",
					"composer%.lock",
					"Cargo%.lock",
					-- Build Output & Cache
					"dist/",
					"build/",
					"target/",
					"bin/",
					"obj/",
					"%.next/",
					"%.cache/",
					-- Logs & Temporary Files
					"logs/",
					"%.log",
					"tmp/",
					"%.swp",
					"%.DS_Store",
					-- Media & Binaries
					"%.png",
					"%.jpg",
					"%.jpeg",
					"%.gif",
					"%.pdf",
					"%.zip",
					"%.tar%.gz",
				},
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		-- Keymaps
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
