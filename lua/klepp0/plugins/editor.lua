return {
	{ "tpope/vim-sleuth" },

	{ "numToStr/Comment.nvim", opts = {} },

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"Aasim-A/scrollEOF.nvim",
		event = { "CursorMoved", "WinScrolled" },
		opts = {},
	},

	{
		"klepp0/nvim-baml-syntax",
		dir = "~/dev/nvim-baml-syntax",
		dev = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("baml_syntax").setup({
				format_on_save = false,
			})
		end,
	},
}
