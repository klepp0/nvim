return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"polarmutex/git-worktree.nvim",
		config = function()
			require("git-worktree").setup()
			require("telescope").load_extension("git_worktree")
		end,
		keys = {
			{
				"<leader>gw",
				function()
					require("telescope").extensions.git_worktree.git_worktrees()
				end,
				desc = "[G]it [W]orktrees",
			},
			{
				"<leader>gc",
				function()
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")
					local git_worktree = require("git-worktree")

					require("telescope.builtin").git_branches({
						attach_mappings = function(_, map)
							local create_worktree = function(prompt_bufnr)
								local selected = action_state.get_selected_entry()
								local branch = selected and selected.value or action_state.get_current_line()
								actions.close(prompt_bufnr)

								if branch == nil or branch == "" then
									vim.notify("No branch selected", vim.log.levels.ERROR)
									return
								end

								-- Derive path as sibling dir: <repo-name>-<sanitized-branch>
								local repo_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
								local path = "../" .. repo_name .. "-" .. branch:gsub("/", "-")
								git_worktree.create_worktree(path, branch, "origin")
							end

							map("i", "<CR>", create_worktree)
							map("n", "<CR>", create_worktree)
							return true
						end,
					})
				end,
				desc = "[G]it Worktree [C]reate",
			},
		},
	},
}
