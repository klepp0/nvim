-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
telescope.setup({
	extensions = { ["ui-select"] = { themes.get_dropdown() } },
	pickers = {
		live_grep = {
			-- Removed "-u" to respect .gitignore
			additional_args = function()
				return { "--hidden" } -- Search hidden files but respect gitignore
			end,
		},
	},
	defaults = {
		-- Patterns are matched against the full relative path
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

			-- Lockfiles (highly recommended to ignore for grep)
			"poetry%.lock",
			"package%-lock%.json",
			"yarn%.lock",
			"pnpm%-lock%.yaml",
			"composer%.lock",
			"Cargo%.lock",

			-- Build Output & Cache
			"dist/",
			"build/",
			"target/", -- Rust
			"bin/",
			"obj/",
			"%.next/", -- Next.js
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

-- Enable Telescope extensions if they are installed
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

-- See `:help telescope.builtin`
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

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
